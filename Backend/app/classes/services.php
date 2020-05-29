<?php
include "initializer.php";

//Session is set to "PvUsrSess"

class Services {

	public $conn;

	function __construct()
	{
		global $extras_class;
		$this->conn = $extras_class->database();
	}

	//Get from extra class
	public function randomCode($prefix){
		global $extras_class;
		return $extras_class->randomCode($prefix); 		
	}
	//End Get from extra class

	
	public function add_new_service_user($service_id,$user_id,$description,$price){
		global $extras_class;
		$services_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$service_id = mysqli_real_escape_string($this->conn,$service_id);
		$user_id = mysqli_real_escape_string($this->conn,$user_id);
		$description = mysqli_real_escape_string($this->conn,$description);
		$price = mysqli_real_escape_string($this->conn,$price);
		$date = date('m/d/Y h:i:s a', time());

		$query = "SELECT * FROM user_services WHERE service_id = '$service_id' AND user_id ='$user_id'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID de servicio existe
		if (mysqli_num_rows($result)) {

			$response_array = $extras_class->response("false","e1"," Este Id de servicio ya está registrado con el usuario.", "both");  
		  
		} else {

			$sql = "INSERT INTO user_services (service_id, user_id, description, price, creation_date) VALUES ('$service_id','$user_id' ,'$description', '$price', '$date')"; 

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso de servicio.", "console");
			} else {
				$response_array = $extras_class->response("false","e1","Registro fallido.", "both");
			}
			
		}

		return $response_array;
	}


	public function new_service($name_service,$short_description,$long_description,$img_url){
		global $extras_class;
		$services_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$name_service = mysqli_real_escape_string($this->conn,$name_service);

		$query = "SELECT * FROM services_list WHERE name_service = '$name_service'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID de servicio existe
		if (mysqli_num_rows($result)) {
			$response_array = $extras_class->response("false","e1"," Este servicio ya está registrado.", "both");  
		} else {

			$short_description = mysqli_real_escape_string($this->conn,$short_description);
			$long_description = mysqli_real_escape_string($this->conn,$long_description);
			$img_url = mysqli_real_escape_string($this->conn,$img_url);
			$service_id = $this->randomCode('service_');

			$sql = "INSERT INTO services_list (service_id, name_service, short_description, long_description,img_url_service) VALUES ('$service_id','$name_service' ,'$short_description', '$long_description','$img_url')";

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso de servicio.", "console");
			} else {
				$response_array = $extras_class->response("false","e1","Registro fallido.", "both");
			}
			
		}

		return $response_array;
	}


	public function get_user_services_list($user_id){
		global $extras_class;
		$services_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		//SELECT price, description, name_service, status FROM user_services INNER JOIN services_list ON user_services.service_id=services_list.service_id

		$query = "SELECT * FROM user_services INNER JOIN services_list ON user_services.service_id=services_list.service_id WHERE user_id = '$user_id'";

		$result = mysqli_query($this->conn, $query);

		// Ver si el ID existe
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  
			$data_list_array[] = array("service_id" => $row['service_id'],"user_id" => $row['user_id'], "description" => $row['description'],"price" => $row['price'],"name_service" => $row['name_service']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información de los servicios se obtuvo con éxito.", "console");
		  $response_array[] = array('service_list_user' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se ha encontrado nada para este ID", "both");
		}

		return $response_array;
	}


	//Get service details
	public function get_service_details($service_id){
		global $extras_class;
		$services_details_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$query_list = "SELECT * FROM services_list WHERE service_id = '$service_id'";
		$result_list = mysqli_query($this->conn, $query_list);

		if (mysqli_num_rows($result_list)) {
			  while($row = mysqli_fetch_assoc($result_list)) {
			  	$services_details_array[] = $row;
			  }

			  $response_array = $extras_class->response("true","sc1","Información del servicio obtenida con éxito", "console");
			  $response_array[] = array("service_data"=>$services_details_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se encontró un servicio asociado con ese ID", "both");
		}

		return $response_array;
	}

	public function delete_service($service_id){
		global $extras_class;
		$services_details_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$query_list = "SELECT * FROM services_list WHERE service_id = '$service_id'";
		$result_list = mysqli_query($this->conn, $query_list);

		if (mysqli_num_rows($result_list)) {

			$sql = "DELETE FROM services_list WHERE service_id = '$service_id'";

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","El servicio se ha eliminado con éxito", "console");
			} else {
				$response_array = $extras_class->response("false","e1","Eliminación fallido.", "both");
			}

		} else {
			$response_array = $extras_class->response("false","e1","No se encontró un servicio asociado con ese ID", "both");
		}

		return $response_array;
	}

	public function delete_service_user($user_id,$service_id){
		global $extras_class;
		$services_details_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$user_id = mysqli_real_escape_string($this->conn,$user_id);

		$query_list = "SELECT * FROM user_services WHERE user_id = '$user_id'";
		$result_list = mysqli_query($this->conn, $query_list);

		if (mysqli_num_rows($result_list)) {
			$service_id = mysqli_real_escape_string($this->conn,$service_id);
			$response_array = $extras_class->response("true","sc1","El id existe", "console");

			/*$sql = "DELETE FROM user_services WHERE service_id = '$service_id'";

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","El servicio se ha eliminado con éxito", "console");
			} else {
				$response_array = $extras_class->response("false","e1","Eliminación fallido.", "both");
			}*/
			
		} else {
			$response_array = $extras_class->response("false","e1","No se encontró un servicio asociado con ese ID", "both");
		}

		return $response_array;
	}

}
?>