<?php
include "initializer.php";

class Payments {

	public $conn;
	public $payment_library;

	function __construct()
	{
		global $extras_class;

		$this->payment_library = '../libraries/stripe/init.php';

		require_once($this->payment_library);

		$this->conn = $extras_class->database();

		\Stripe\Stripe::setApiKey($extras_class->stripe_api_key);
	}

	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 

	public function create_stripe_customer($user_id){
		global $extras_class;	
		global $user_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		if ($extras_class->record_exists('users','user_id',$user_id)) {

			$user_public_data = $user_class->get_user_public_data($user_id);

			$user_name = $user_public_data[1]["user_data"][0]["name"]." ".$user_public_data[1]["user_data"][0]["first_lastname"]." ".$user_public_data[1]["user_data"][0]["second_lastname"];

			$user_type = $user_public_data[1]["user_data"][0]["type"];
			$user_mail = $user_public_data[1]["user_data"][0]["mail"];
			$user_phone = $user_public_data[1]["user_data"][0]["phone"];

			try {
				$customer = \Stripe\Customer::create([
					'name' => $user_name,
				    'description' => 'Fixme ('.$user_type.')',
				    'email' => $user_mail,
				    'phone' => $user_phone
				]);

				$customer_id = $customer->id;

				$response_array[] = array("customer_id"=>$customer_id);

				if ($customer_id != null) {
					$associate_customer = $this->associate_customer_id($user_id, $customer_id);
					if ($associate_customer[0]["status"] == "true") {
						$response_array = $extras_class->response("true","s1","Se registró el cliente de manera exitosa en ambos servicios.", "both");
						$response_array[] = array("stripe_response"=>$customer);
					} else {
						$response_array = $extras_class->response("false","ec1",$associate_customer[0]["message"], "both");
					}
				} else {
					$response_array = $extras_class->response("false","ec1","El cliente se registró en Stripe pero no se pudo localizar el customer id", "both");
				}

			} catch (Exception $e) {
				$response_array = $extras_class->response("false","ec1",$e->getMessage(), "both");
			}
		} else {
			$response_array = $extras_class->response("false","ec1","El id de usuario que se quiere registrar como cliente Stripe no existe.", "both");
		}

		return $response_array;
	}

	public function get_stripe_customer_data($user_id){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$customer_id = $this->get_stripe_customer_id($user_id);
		if ($customer_id[0]["status"] == "true") {
			$customer_id = $customer_id[1]["customer_id"];
			try {
				$customer = \Stripe\Customer::retrieve($customer_id);

				$response_array = $extras_class->response("true","s1","Se recibió respuesta de Stripe con éxito.", "both");
				$response_array[] = array("stripe_response"=>$customer);
			} catch (Exception $e) {
				$response_array = $extras_class->response("false","ec1",$e->getMessage(), "both");
			}
		} else {
			$response_array = $extras_class->response("false","ec1","No se encontró ningún registro de cliente para ese id.", "both");
		}

		return $response_array;
	}

	public function associate_customer_id($user_id, $customer_id){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		if ($extras_class->record_exists('customers','user_id',$user_id)) {
			$sql = "UPDATE customers SET customer_id = '$customer_id' WHERE user_id = '$user_id';";
			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","s1","Se actualizó el id del cliente exitósamente.", "both");
			} else {
				$response_array = $extras_class->response("false","ec1","Hubo un problema para actualizar el id del cliente.", "both");
			}
		} else {
			$sql = "INSERT INTO customers (user_id,customer_id) VALUES ('$user_id', '$customer_id')";
			if (mysqli_query($this->conn,$sql)) {					
				$response_array = $extras_class->response("true","s1","Se creó el id del cliente exitósamente.", "both");
			} else {
				$response_array = $extras_class->response("false","ec1","Hubo un problema para crear el id del cliente.", "both");
			}
		}

		return $response_array;
	}

	public function get_stripe_customer_id($user_id){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$query = "SELECT * FROM customers WHERE user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  $customer_id = $row['customer_id'];
		  }

		  $response_array = $extras_class->response("true","s1","Se obtuvo el id de cliente con éxito.", "both");
		  $response_array[] = array("customer_id"=>$customer_id);

		} else {
			$response_array = $extras_class->response("false","ec1","No se encontró ningún registro de cliente para ese id.", "both");
		}

		return $response_array;
	}

	public function add_new_card($user_id,$card_token){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$customer_id = $this->get_stripe_customer_id($user_id);
		if ($customer_id[0]["status"] != "true") {
			$create_new_stripe_customer = $this->create_stripe_customer($user_id);
			if ($create_new_stripe_customer[0]["status"] != "true") {
				$response_array = $extras_class->response("false","e1","Se intentó crear el cliente para asignarle el método de pago, pero hubo el siguiente error: ".$create_new_stripe_customer[0]["message"], "both");
				return $response_array;
				exit();
			} else {
				$customer_id = $this->get_stripe_customer_id($user_id);
				if ($customer_id[0]["status"] != "true") {
					$response_array = $extras_class->response("false","e1","Se intentó obtener el id del cliente en un segundo intento para asignarle el método de pago, pero hubo el siguiente error: ".$customer_id[0]["message"], "both");
					return $response_array;
					exit();
				}
			}
		}

		$customer_id = $customer_id[1]["customer_id"];
		try {
			$create_card = \Stripe\Customer::createSource(
						  $customer_id,
						  ['source' => $card_token]
						);

			$response_array = $extras_class->response("true","s1","Se agregó la tarjeta de Stripe con éxito.", "both");
			$response_array[] = array("stripe_response"=>$create_card);
		} catch (Exception $e) {
			$response_array = $extras_class->response("false","ec1",$e->getMessage(), "both");
		}

		return $response_array;
	}

	public function remove_card($user_id,$card_id){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$customer_id = $this->get_stripe_customer_id($user_id);
		if ($customer_id[0]["status"] == "true") {
			$customer_id = $customer_id[1]["customer_id"];
			try {
				$remove_card = \Stripe\Customer::deleteSource(
								  $customer_id,
								  $card_id
								);

				$response_array = $extras_class->response("true","s1","Se eliminó la tarjeta de Stripe con éxito.", "both");
				$response_array[] = array("stripe_response"=>$remove_card);
			} catch (Exception $e) {
				$response_array = $extras_class->response("false","ec1",$e->getMessage(), "both");
			}
		} else {
			$response_array = $extras_class->response("false","ec1","No se encontró ningún registro de cliente para ese id.", "both");
		}

		return $response_array;
	}

	public function get_stripe_customers_cards($user_id){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$customer = $this->get_stripe_customer_data($user_id);

		if ($customer[0]["status"] == "true") {
			$stripe_response = $customer[1]["stripe_response"];
			$customers_payment_sources = $stripe_response["sources"]["data"];
			$response_array = $extras_class->response("true","s1","Se obtuvo la lista de métodos de pago del cliente con éxito.", "both");
			$response_array[] = array("metodos_de_pago"=>$customers_payment_sources);
		} else {
			$response_array = $extras_class->response("false","ec1","No se encontró ningún registro de cliente para ese id", "both");
		}

		return $response_array;
	}

	public function execute_charge($user_id,$amount,$payment_source,$description){
		global $extras_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$customer_id = $this->get_stripe_customer_id($user_id);
		if ($customer_id[0]["status"] == "true") {
			$customer_id = $customer_id[1]["customer_id"];
			
			$amount = floatval($amount)*100;
			try {
				$payment = \Stripe\Charge::create([
							  'amount' => $amount,
							  'currency' => 'mxn',
							  'customer' => $customer_id,
							  'source' => $payment_source,
							  'description' => $description,
							]);

				$response_array = $extras_class->response("true","s1","Se realizó el cargo de Stripe con éxito.", "both");
				$response_array[] = array("stripe_response"=>$payment);
			} catch (Exception $e) {
				$response_array = $extras_class->response("false","ec1",$e->getMessage(), "both");
			}
		} else {
			$response_array = $extras_class->response("false","e1","El usuario que intenta hacer el pago no aparece como un cliente Stripe registrado, significa que no ha registrado ninguna tarjeta aún o un método de pago. Usuario: ".$user_id, "both");
		}

		return $response_array;
	}
}
?>