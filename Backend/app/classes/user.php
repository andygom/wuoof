<?php
include "initializer.php";

//Session is set to "PvUsrSess"

class User {

	public $user_id;
	public $conn;
	public $is_logged;
	public $user_data_array;

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

	//Decode img base64
	public function decodeBase64($imgbase){
		global $extras_class;
		return $extras_class->base64_decode($imgbase); 		
	}


	public function new_user($name, $first_lastname, $second_lastname, $img_url, $birth_date, $state, $municipality, $gender, $mail, $password){
		global $extras_class;
		global $strings_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$mail = mysqli_real_escape_string($this->conn,$mail);

		$query = "SELECT * FROM users WHERE mail = '$mail'";
		$result = mysqli_query($this->conn, $query);
		if(mysqli_num_rows($result)){
			$response_array = $extras_class->response("false","e1","Este correo ya está registrado.", "both");
		} else {

			$name = mysqli_real_escape_string($this->conn,$name);		
			$password = password_hash(mysqli_real_escape_string($this->conn,$password), PASSWORD_DEFAULT);
			$first_lastname = mysqli_real_escape_string($this->conn,$first_lastname);
			$second_lastname = mysqli_real_escape_string($this->conn,$second_lastname);
			$img_url = mysqli_real_escape_string($this->conn,$img_url);
			
			//$img_url = $this->decodeBase64($img_url);
			$img_url = base64_decode($img_url);


			$birth_date = mysqli_real_escape_string($this->conn,$birth_date);
			$state = mysqli_real_escape_string($this->conn,$state);
			$municipality = mysqli_real_escape_string($this->conn,$municipality);
			$gender = mysqli_real_escape_string($this->conn,$gender);
			$mail = mysqli_real_escape_string($this->conn,$mail);

			$date = date('m/d/Y h:i:s a', time());
			$user_id = $this->randomCode('user_');

			$sql = "INSERT INTO users (user_id,name,mail,password,first_lastname,second_lastname,img_url,birth_date,state,municipality,gender,creation_date) VALUES ('$user_id', '$name','$mail','$password','$first_lastname','$second_lastname','$img_url','$birth_date','$state','$municipality','$gender','$date')"; 

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso.", "console");
				$response_array[] = array('user_id' => $user_id);
				$response_array[] = array('url' => $extras_class->home_url);
				$this->user_id = $user_id;
				$this->trigger_login();
			} else {
				$response_array = $extras_class->response("false","e1","Registro fallido.", "both");
			}

		}		

		return $response_array;
	}

	public function try_login($mail,$password){
		global $extras_class;
		global $strings_class;

		$query = "SELECT * FROM users WHERE mail = '$mail'";
		$result = mysqli_query($this->conn, $query);

		/* Ver si el correo existe */
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  $password_db = $row['password'];
			  $user_id = $row['user_id'];
		  }

		  /* Comparar las contraseñas */
		  if (password_verify($password, $password_db)) {
		  	$response_array = $extras_class->response("true","sc1","Sesión iniciada", "console");
		  	$response_array[] = array('user_id' => $user_id);
		  	$response_array[] = array('link' => $extras_class->home_url);
		  	$this->user_id = $user_id;
		  	$this->trigger_login();
		  } else {
		  	$response_array = $extras_class->response("false","e1","No coinciden las contraseñas", "both");
		  }

		} else {
			$response_array = $extras_class->response("false","e1","El correo no está registrado", "both");
		}

		return $response_array;
	}

	public function trigger_login(){
		global $extras_class;
		$conn = $extras_class->database();

		if ($this->user_id != "") {
			$_SESSION['PvUsrSess'] = $this->user_id;
			ob_end_flush();	
			$this->is_logged = true;

			//Get user data
			$user_id = $this->user_id;
			$query = "SELECT * FROM users WHERE user_id = '$user_id'";
			$result = mysqli_query($conn, $query);

			if(mysqli_num_rows($result)){
			    $this->user_data_array = mysqli_fetch_assoc($result);
			}			
			//End get user data

		} else {
			$this->is_logged = false;
		}
	}

	public function verify_login(){
		if ($_SESSION['PvUsrSess'] != "") {
			$this->user_id = $_SESSION['PvUsrSess'];
			ob_end_flush();
			$this->is_logged = true;
		} else {
			$this->is_logged = false;
		}

		return $this->is_logged;
	}

	public function verify_login_js(){
		global $extras_class;
		global $strings_class;

		$response_array = $extras_class->response("false","e1","No loggeado", "both");

		if ($_SESSION['PvUsrSess'] != "") {
			$this->user_id = $_SESSION['PvUsrSess'];
			ob_end_flush();
			$response_array = $extras_class->response("true","e1","loggeado", "both");
		}

		return $response_array;
	}

	public function logout(){
		global $extras_class;
		global $strings_class;
		session_unset();
		if (ini_get("session.use_cookies")) {
		    $params = session_get_cookie_params();
		    setcookie(session_name(), '', time() - 42000,
		        $params["path"], $params["domain"],
		        $params["secure"], $params["httponly"]
		    );

		} // Finally, destroy the session.
		session_destroy();
		$response_array = $extras_class->response("true","e1","Logout exitoso", "both");
		$response_array[] = array('url' => $extras_class->home_url);

		return $response_array;
	}


	public function getPublicUserInfo($user_id){
		
		if ($user_id == "") {
			if ($this->verify_login()) {
				$user_id = $this->user_id;
			}
		}

		$query = "SELECT * FROM users WHERE user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);
		if(mysqli_num_rows($result)){
		    $row = mysqli_fetch_assoc($result);
		} else {
			$row = "";
		}

		return $row;
	}


	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 

	public function get_user_private_data_2($user_id, $mail, $password){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$query = "SELECT * FROM users WHERE mail = '$mail' AND user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		/* Ver si el correo existe */
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  $password_db = $row['password'];
			  $data_list_array[] = $row;
		  }		  

		  /* Comparar las contraseñas */
		  if (password_verify($password, $password_db)) {
		  	$response_array = $extras_class->response("true","sc1","Se obtuvo la información pública del usuario con éxito", "console");
		  	$response_array[] = array("user_data"=>$data_list_array);
		  } else {
		  	$response_array = $extras_class->response("false","e1","No coinciden las contraseñas", "both");
		  }

		} else {
			$response_array = $extras_class->response("false","e1","Los datos no coinciden", "both");
		}

		return $response_array;
	}

	/*public function get_user_private_data($user_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$query = "SELECT * FROM users WHERE mail = '$mail' AND user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el correo existe 
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  //$password_db = $row['password'];
			  $data_list_array[] = array("user_id" => $row['user_id'], "name" => $row['name'], "first_lastname" => $row['first_lastname'], "second_lastname" => $row['second_lastname'], "img_url" => $row['img_url'],"state" => $row['state'],"municipality" => $row['municipality'], "gender" => $row['gender'], "mail" => $row['mail']);
		  }		  

		  // Comparar las contraseñas 
		  if (password_verify($password, $password_db)) {
		  	$response_array = $extras_class->response("true","sc1","La información privada del usuario se obtuvo con éxito", "console");
		  	$response_array[] = array('user_data' => $data_list_array);
		  } else {
		  	$response_array = $extras_class->response("false","e1","No coinciden las contraseñas", "both");
		  }

		} else {
			$response_array = $extras_class->response("false","e1","Los datos no coinciden", "both");
		}

		return $response_array;
	}*/

	public function get_user_private_data($user_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$query = "SELECT * FROM users WHERE user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el id existe
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  //$password_db = $row['password'];
			  $data_list_array[] = array("user_id" => $row['user_id'], "name" => $row['name'], "first_lastname" => $row['first_lastname'], "second_lastname" => $row['second_lastname'], "img_url" => $row['img_url'],"state" => $row['state'],"municipality" => $row['municipality'], "gender" => $row['gender'], "mail" => $row['mail']);
		  }		  

		  $response_array = $extras_class->response("true","sc1","La información privada del usuario se obtuvo con éxito", "console");
		  	$response_array[] = array('user_data' => $data_list_array);

		} else {
			$response_array = $extras_class->response("false","e1","Los datos no coinciden", "both");
		}

		return $response_array;
	}

	public function get_user_public_data($user_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$query = "SELECT * FROM users WHERE user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		/* Ver si el correo existe */
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  $password_db = $row['password'];
			  $data_list_array[] = array("user_id" => $row['user_id'], "name" => $row['name'], "first_lastname" => $row['first_lastname'], "second_lastname" => $row['second_lastname'], "img_url" => $row['img_url']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información pública del usuario se obtuvo con éxito", "console");
		  $response_array[] = array('user_data' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se ha encontrado nada para este ID", "both");
		}

		return $response_array;
	}

	public function account_verification_request($user_id, $ine_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		//$response_array = $extras_class->response("true","sc1","Validando INE", "console");

		$query = "SELECT * FROM validation_ine WHERE user_id = '$user_id' ";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID existe 
		if (mysqli_num_rows($result)) {
			
			$response_array = $extras_class->response("false","e1"," El Id ya tiene una INE registrada.", "both");

		} else {

			$ine_id = mysqli_real_escape_string($this->conn,$ine_id);
			$date = date('m/d/Y h:i:s a', time());

			$sql = "INSERT INTO validation_ine (user_id,ine,status_validation, creation_date) VALUES ('$user_id','$ine_id','cheking','$date')";


			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso. Tu INE se esta validando.", "console");
				$response_array[] = array('status_validation'=> 'cheking');
			}else{
				$response_array = $extras_class->response("false","e1","Registro fallido del booking en fase 1.", "both");
			}
		}

		return $response_array;
	}

	public function get_available_partners_list($pet_id,$service_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$query = "SELECT * FROM users INNER JOIN user_services ON users.user_id=user_services.user_id WHERE service_id = '$service_id'";
		$result = mysqli_query($this->conn, $query);

		//Ver si el ID existe 
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			
			  $data_list_array[] = array("user_id" => $row['user_id'], "name" => $row['name'], "first_lastname" => $row['first_lastname'], "img_url" => $row['img_url'], "description" => $row['description'], "price" => $row['price']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información de los paseadores se obtuvo con éxito", "console");
		  $response_array[] = array('partners_data_list' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No hay cuidadores con ese servicio", "both");
		}

		return $response_array;
	}
	
}
?>