<?php
include "initializer.php";

//Session is set to "PvUsrSess"

class Pet {

	public $pet_id;
	public $conn;
	public $is_logged;
	public $pet_data_array;

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

	//Get from extra class
	public function decodeBase64($imgbase){
		global $extras_class;
		return $extras_class->base64_decode($imgbase); 		
	}
	//End Get from extra class

	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 

	public function new_match_pet($id_pet_user, $id_pet_like){
		global $extras_class;
		global $strings_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$id_pet_user = mysqli_real_escape_string($this->conn,$id_pet_user);	
		$id_pet_like = mysqli_real_escape_string($this->conn,$id_pet_like);	
		$date = date('m/d/Y h:i:s a', time());
		
		$query = "SELECT * FROM match_pet WHERE id_pet_user = '$id_pet_user' AND id_pet_like = '$id_pet_like' ";
		$result = mysqli_query($this->conn, $query);

		//$row = $result -> fetch_assoc();
		//if(mysqli_fetch_assoc($result)){
		
		if(mysqli_num_rows($result)){

			$response_array = $extras_class->response("false","e1","Este id ya está registrado con ese like.", "both");

		} else {

			$sql = "INSERT INTO match_pet (id_pet_user,id_pet_like, creation_date) VALUES ('$id_pet_user', '$id_pet_like','$date')"; 

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso de la mascota que te gusta.", "console");
			} else {
				$response_array = $extras_class->response("false","e1","Registro fallido.", "both");
			}

		}

		return $response_array;
	}

	public function get_tinder_feed($id_pet_user){
		global $extras_class;
		global $strings_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$query = "SELECT * FROM pets";
		$result = mysqli_query($this->conn, $query);

		// Ver si hay resultados
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			$data_list_array[] = array("id_pet_user" => $row['id_pet_user'], "pet_name" => $row['pet_name'],"pet_img_url" => $row['pet_img_url'],"pet_gallery" => $row['pet_gallery'],"pet_age" => $row['pet_age'],"pet_gender" => $row['pet_gender'],"pet_nationality" => $row['pet_nationality'],"pet_breed" => $row['pet_breed'],"pet_biography" => $row['pet_biography'],"pet_information" => $row['pet_information'],"pet_personality" => $row['pet_personality']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información de las mascotas se obtuvo con éxito", "console");
		  $response_array[] = array('pet_data' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se han encontrado mascotas", "both");
		}

		return $response_array;
	}

	public function new_pet($user_id, $name, $img_url, $img_url_gallery, $age, $gender, $nationality, $breed, $biography, $information, $personality){

		global $extras_class;
		global $strings_class;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$base64 = $img_url;

		$pet_id = $this->randomCode('pet_');
		$user_id = mysqli_real_escape_string($this->conn,$user_id);
		$name = mysqli_real_escape_string($this->conn,$name);
		
		$img_code = mysqli_real_escape_string($this->conn,$img_url);
		$img_normal = base64_decode($img_code);

		$file = fopen('../img-pets/', "w");
		fwrite($file, base64_decode($base64));
		fclose($file);	

		//decodificar imagenes y subirlas
		$update_gallery = $this->upload_gallery($user_id,$img_url_gallery);

		$age = mysqli_real_escape_string($this->conn,$age);
		$gender = mysqli_real_escape_string($this->conn,$gender);
		$nationality = mysqli_real_escape_string($this->conn,$nationality);
		$breed = mysqli_real_escape_string($this->conn,$breed);
		$biography = mysqli_real_escape_string($this->conn,$biography);
		$information = mysqli_real_escape_string($this->conn,$information);
		$personality = mysqli_real_escape_string($this->conn,$personality);
		$date = date('m/d/Y h:i:s a', time());

		$sql = "INSERT INTO pets (id_pet_user, user_id, pet_name, pet_img_url, pet_gallery, pet_age, pet_gender, pet_nationality, pet_breed, pet_biography, pet_information, pet_personality, creation_date) VALUES ('$pet_id','$user_id','$name', '$img_normal', 'galeria','$age','$gender','$nationality','$breed', '$biography','$information', '$personality', '$date')"; 

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Registro exitoso.", "console"); 
				$response_array[] = array('pet_id' => $pet_id);

			} else {
				$response_array = $extras_class->response("false","e1","Registro fallido.", "both");
			}

		return $response_array;
	}

	public function get_pet_data($id_pet_user){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$id_pet_user = mysqli_real_escape_string($this->conn,$id_pet_user);

		$query = "SELECT * FROM pets WHERE id_pet_user = '$id_pet_user'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID existe
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  
			$data_list_array[] = array("id_pet_user" => $row['id_pet_user'], "pet_name" => $row['pet_name'],"pet_img_url" => $row['pet_img_url'],"pet_gallery" => $row['pet_gallery'],"pet_age" => $row['pet_age'],"pet_gender" => $row['pet_gender'],"pet_nationality" => $row['pet_nationality'],"pet_breed" => $row['pet_breed'],"pet_biography" => $row['pet_biography'],"pet_information" => $row['pet_information'],"pet_personality" => $row['pet_personality']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información de la mascota se obtuvo con éxito", "console");
		  $response_array[] = array('pet_data' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se ha encontrado nada para este ID", "both");
		}

		return $response_array;
	}

	public function get_user_pet_list($user_id){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");
		
		$user_id = mysqli_real_escape_string($this->conn,$user_id);
		$query = "SELECT * FROM pets WHERE user_id = '$user_id'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID existe
		if (mysqli_num_rows($result)) {
		  while($row = mysqli_fetch_assoc($result)) {
			  
			 $data_list_array[] = array("id_pet_user" => $row['id_pet_user'], "pet_name" => $row['pet_name'],"pet_img_url" => $row['pet_img_url'],"pet_gallery" => $row['pet_gallery'],"pet_age" => $row['pet_age'],"pet_gender" => $row['pet_gender'],"pet_nationality" => $row['pet_nationality'],"pet_breed" => $row['pet_breed'],"pet_biography" => $row['pet_biography'],"pet_information" => $row['pet_information'],"pet_personality" => $row['pet_personality']);
		  }

		  $response_array = $extras_class->response("true","sc1","La información de tus mascotas son:", "console");
		  $response_array[] = array('pet_data_list' => $data_list_array);
		} else {
			$response_array = $extras_class->response("false","e1","No se ha encontrado nada para este ID", "both");
		}

		return $response_array;
	}

	public function pet_questions($pet_id,$pregunta1,$pregunta2,$pregunta3){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");
		
		$pet_id = mysqli_real_escape_string($this->conn,$pet_id);
		$pregunta1 = mysqli_real_escape_string($this->conn,$pregunta1);
		$pregunta2 = mysqli_real_escape_string($this->conn,$pregunta2);
		$pregunta3 = mysqli_real_escape_string($this->conn,$pregunta3);
		
		$query = "SELECT * FROM questions_pets WHERE pet_id = '$pet_id'";
		$result = mysqli_query($this->conn, $query);

		// Ver si el ID existe
		if (mysqli_num_rows($result)) {
		  
			$sql = "UPDATE questions_pets SET question_1 = '$pregunta1', question_2 = '$pregunta2', question_3 = '$pregunta3' WHERE pet_id = '$pet_id';";

		  	if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Tus respuestas se actualizarón correctamente.", "console"); 
				//$response_array[] = array('pet_id' => $pet_id);

			} else {
				$response_array = $extras_class->response("false","e1","Actualización fallida. :(", "both");
			}
			  
		} else {

			$sql = "INSERT INTO questions_pets (pet_id, question_1, question_2, question_3) VALUES ('$pet_id','$pregunta1','$pregunta2', '$pregunta3')"; 

			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Tus respuestas se registraron correctamente.", "console"); 
				//$response_array[] = array('pet_id' => $pet_id);
			} else {
				$response_array = $extras_class->response("false","e1","No se pudieron agregar tus respuestas.", "both");

			}

		}

		return $response_array;
	}

	public function upload_gallery($pet_id,$url_gallery){
		global $extras_class;
		global $strings_class;
		$data_list_array;

		$response_array = $extras_class->response("false","e1","Hubo un problema interno (500).", "both");

		$pet_id = mysqli_real_escape_string($this->conn,$pet_id);
		$gallery_decode = array();
		$array_num = count($url_gallery);
		for ($i = 0; $i < $array_num; ++$i){
		    $url_gallery[$i] = base64_decode($url_gallery[$i]);
		    array_push($gallery_decode, $url_gallery[$i]);
		}

		foreach ($gallery_decode as $value) {
				$img_id = $this->randomCode('img_pet_');
				$sql = "INSERT INTO gallery_pet (pet_id,img_pet_id,url_img_gallery) VALUES ('$pet_id','$img_id','$value')";
			if (mysqli_query($this->conn,$sql)) {
				$response_array = $extras_class->response("true","sc1","Tus imágenes se subieron con exito.", "console"); 

			} else {
				$response_array = $extras_class->response("false","e1","No se subieron las ímágenes.", "both");
			}
		}

		return $response_array;
	}


}
?>