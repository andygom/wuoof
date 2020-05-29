<?php
//Initialize clasess and session
include "mods-start.php";
$json_call = false;
$errores_array = array();
$httpCode = null;

if (!isset($_POST["action"])) {
	$body = @file_get_contents('php://input');
	$data = json_decode($body);
	error_log($body);
	$action = $data->action;
	if ($action == null || $action == "") {
		$httpCode = 400;
		array_push($errores_array,'No hay una llamada concreta');
	} else {
		$json_call = true;
	}
} else {
	$action = $_POST["action"];
}

$response_array = $extras_class->response("false","e1","Hola amigo, cómo llegaste aquí?.", "both");

switch ($action) {
	case 'login':
		if ($json_call) {
			$mail = $data->mail;
			if($mail == null){
			    array_push($errores_array,'Falta el campo de correo');
			}

			$password = $data->password;
			if($password == null){
			    array_push($errores_array,'Falta el campo de contraseña');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->try_login(
					$mail,
					$password
				);
			}						
		} else {
			$response_array = $user_class->try_login(
				$_POST["mail"],
				$_POST["password"]
			);
		}
		break;

	case 'signup':
	if ($json_call) {
		$name = $data->name;
		//error_log($name);
		if($name == null){
		    array_push($errores_array,'Falta el campo de nombre');
		}

		$first_lastname = $data->first_lastname;
		if($first_lastname == null){
		    array_push($errores_array,'Falta el campo de apellido paterno');
		}

		$second_lastname = $data->second_lastname;
		if($second_lastname == null){
		    array_push($errores_array,'Falta el campo de apellido materno');
		}

		$img_url = $data->img_url;
		if($img_url == null){
		    array_push($errores_array,'Falta el campo de foto de perfil');
		}

		$birth_date = $data->birth_date;
		if($birth_date == null){
		    array_push($errores_array,'Falta el campo de fecha de nacimiento');
		}

		$state = $data->state;
		if($state == null){
		    array_push($errores_array,'Falta el campo de estado');
		}

		$municipality = $data->municipality;
		if($municipality == null){
		    array_push($errores_array,'Falta el campo de municipio');
		}

		$gender = $data->gender;
		if($gender == null){
		    array_push($errores_array,'Falta el campo de genero');
		}


		$mail = $data->mail;
		if($mail == null){
		    array_push($errores_array,'Falta el campo de correo');
		}

		$password = $data->password;
		if($password == null){
		    array_push($errores_array,'Falta el campo de contraseña');
		}

		if (count($errores_array) != 0) {
			$response_array = $extras_class->response("false","e1",$errores_array, "both");
		} else {
			$httpCode = 200;
			$response_array = $user_class->new_user(
				$name,
				$first_lastname,
				$second_lastname,
				$img_url,
				$birth_date,
				$state,
				$municipality,
				$gender,
				$mail,
				$password
			);
		}						
	} else {
		$response_array = $user_class->new_user(
			$_POST["name"],
			$_POST["first_lastname"],	
			$_POST["second_lastname"],	
			$_POST["img_url"],	
			$_POST["birth_date"],
			$_POST["state"],
			$_POST["municipality"],
			$_POST["gender"],
			$_POST["mail"],
			$_POST["password"]
		);
	}
		break; 
	

	case 'verify_login_js':
		$response_array = $user_class->verify_login_js();
		break;

	case 'logout':
		$httpCode = 200;
		$response_array = $user_class->logout();
		break;	

	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 
	//---------------------------- Rest API ---------------------------- 

	/*case 'get_user_private_data':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de id de usuario');
			}

			$mail = $data->mail;
			if($mail == null){
			    array_push($errores_array,'Falta el campo de correo');
			}

			$password = $data->password;
			if($password == null){
			    array_push($errores_array,'Falta el campo de contraseña');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->get_user_private_data(
					$user_id,
					$mail,
					$password
				);
			}						
		} else {
			$response_array = $user_class->get_user_private_data(
				$_POST["user_id"],
				$_POST["mail"],
				$_POST["password"]
			);
		}
		break;*/

	case 'get_user_private_data':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de id de usuario');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->get_user_private_data(
					$user_id
				);
			}						
		} else {
			$response_array = $user_class->get_user_private_data(
				$_POST["user_id"]
			);
		}
	break;

	case 'get_user_public_data':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de id de usuario');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->get_user_public_data(
					$user_id
				);
			}						
		} else {
			$response_array = $user_class->get_user_public_data(
				$_POST["user_id"]
			);
		}
		break;

	case 'account_verification_request':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de ID de usuario');
			}

			$ine_id = $data->ine_id;
			if($ine_id == null){
			    array_push($errores_array,'Falta el campo de INE');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->account_verification_request(
					$user_id,
					$ine_id
				);
			}						
		} else {
			$response_array = $user_class->account_verification_request(
				$_POST["user_id"],
				$_POST["ine_id"]
			);
		}
	break;

	case 'get_available_partners_list':
		if ($json_call) {
			$pet_id = $data->pet_id;
			if($pet_id == null){
			    array_push($errores_array,'Falta el campo de ID de la mascota de usuario');
			}

			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo ID de servicio');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $user_class->get_available_partners_list(
					$pet_id,
					$service_id
				);
			}						
		} else {
			$response_array = $user_class->get_available_partners_list(
				$_POST["pet_id"],
				$_POST["service_id"]
			);
		}
	break;

		
	case 'match_pet':
		if ($json_call) {
			$id_pet_user = $data->id_pet_user;
			//error_log($name);
			if($id_pet_user == null){
			    array_push($errores_array,'Falta el campo de ID mascota de usuario');
			}

			$id_pet_like = $data->id_pet_like;
			if($id_pet_like == null){
			 array_push($errores_array,'Falta el campo de ID mascota que le gustó');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->new_match_pet(
					$id_pet_user,
					$id_pet_like
				);
			}						
		} else {
			$response_array = $pet_class->new_match_pet(
				$_POST["id_pet_user"],
				$_POST["id_pet_like"]
			);
		}
	break; 

	case 'get_tinder_feed':
		if ($json_call) {
			$id_pet_user = $data->id_pet_user;
			//error_log($name);
			if($id_pet_user == null){
			    array_push($errores_array,'Falta el campo de ID mascota de usuario');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->get_tinder_feed(
					$id_pet_user
				);
			}						
		} else {
			$response_array = $pet_class->get_tinder_feed(
				$_POST["id_pet_user"]
			);
		}
	break; 

	case 'new_pet':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo ID de usuario');
			}

			$name = $data->name;
			if($name == null){
			    array_push($errores_array,'Falta el campo de nombre');
			}

			$img_url = $data->img_url;
			if($img_url == null){
			    array_push($errores_array,'Falta el campo de foto de perfil');
			}

			$img_url_gallery = $data->img_url_gallery;
			if($img_url_gallery == null){
			    array_push($errores_array,'Falta el campo de fotos de galeria');
			}

			$age = $data->age;
			if($age == null){
			    array_push($errores_array,'Falta el campo de edad');
			}

			$gender = $data->gender;
			if($gender == null){
			    array_push($errores_array,'Falta el campo de sexo');
			}

			$nationality = $data->nationality;
			if($nationality == null){
			    array_push($errores_array,'Falta el campo de nacionalidad');
			}

			$breed = $data->breed;
			if($breed == null){
			    array_push($errores_array,'Falta el campo de raza');
			}


			$biography = $data->biography;
			if($biography == null){
			    array_push($errores_array,'Falta el campo de biografia');
			}

			$information = $data->information;
			if($information == null){
			    array_push($errores_array,'Falta el campo de información extra');
			}

			$personality = $data->personality;
			if($personality == null){
			    array_push($errores_array,'Falta el campo de personalidad');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->new_pet(
					$user_id,
					$name,
					$img_url,
					$img_url_gallery,
					$age,
					$gender,
					$nationality,
					$breed,
					$biography,
					$information,
					$personality
				);
			}						
		} else {
			$response_array = $pet_class->new_pet(
				$_POST["user_id"],
				$_POST["name"],	
				$_POST["img_url"],	
				$_POST["img_url_gallery"],
				$_POST["age"],
				$_POST["nationality"],
				$_POST["gender"],
				$_POST["breed"],
				$_POST["biography"],
				$_POST["information"],
				$_POST["personality"]

			);
		}
	break; 

	case 'get_pet_data':
		if ($json_call) {
			$id_pet_user = $data->id_pet_user;
			if($id_pet_user == null){
			    array_push($errores_array,'Falta el campo de ID de mascota');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->get_pet_data(
					$id_pet_user
				);
			}						
		} else {
			$response_array = $pet_class->get_pet_data(
				$_POST["id_pet_user"]
			);
		}
	break;

	case 'get_user_pet_list':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de ID de usuario');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->get_user_pet_list(
					$user_id
				);
			}						
		} else {
			$response_array = $pet_class->get_user_pet_list(
				$_POST["user_id"]
			);
		}
	break;

	case 'pet_questions':
		if ($json_call) {
			$pet_id = $data->pet_id;
			if($pet_id == null){
			    array_push($errores_array,'Falta el campo de ID de la mascota');
			}

			$pregunta1 = $data->pregunta1;
			if($pregunta1 == null){
			    array_push($errores_array,'Falta pregunta 1');
			}

			$pregunta2 = $data->pregunta2;
			if($pregunta2 == null){
			    array_push($errores_array,'Falta pregunta 2');
			}

			$pregunta3 = $data->pregunta3;
			if($pregunta3 == null){
			    array_push($errores_array,'Falta pregunta 3');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->pet_questions(
					$pet_id,
					$pregunta1,
					$pregunta2,
					$pregunta3
				);
			}						
		} else {
			$response_array = $pet_class->pet_questions(
				$_POST["pet_id"],
				$_POST["pregunta1"],
				$_POST["pregunta2"],
				$_POST["pregunta3"]
			);
		}
	break;

	case 'upload_gallery':
		if ($json_call) {
			$pet_id = $data->pet_id;
			if($pet_id == null){
			    array_push($errores_array,'Falta el campo de ID de la mascota');
			}

			$url_gallery = $data->url_gallery;
			if($url_gallery == null){
			    array_push($errores_array,'Falta el arreglo de las imagenes');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $pet_class->upload_gallery(
					$pet_id,
					$url_gallery
				);
			}						
		} else {
			$response_array = $pet_class->upload_gallery(
				$_POST["pet_id"],
				$_POST["url_gallery"]
			);
		}
	break;

	case 'add_new_service_user':
		if ($json_call) {
			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo ID servicio');
			}

			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo ID usuario');
			}

			$description = $data->description;
			if($description == null){
			    array_push($errores_array,'Falta el campo de descripción');
			}

			$price = $data->price;
			if($price == null){
			    array_push($errores_array,'Falta el campo costo');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->add_new_service_user(
					$service_id,
					$user_id,
					$description,
					$price
				);
			}						
		} else {
			$response_array = $services_class->add_new_service_user(
				$_POST["service_id"],
				$_POST["user_id"],
				$_POST["description"],	
				$_POST["price"]
			);
		}
	break; 

	case 'new_service':
		if ($json_call) {
			$name_service = $data->name_service;
			if($name_service == null){
			    array_push($errores_array,'Falta el campo nombre del servicio');
			}

			$short_description = $data->short_description;
			if($short_description == null){
			    array_push($errores_array,'Falta el campo descripción corta');
			}

			$long_description = $data->long_description;
			if($long_description == null){
			    array_push($errores_array,'Falta el campo descripción larga');
			}

			$img_url = $data->img_url;
			if($img_url == null){
			    array_push($errores_array,'Falta el campo Imagen');
			}

			if (count($errores_array) != 0) {
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->new_service(
					$name_service,
					$short_description,
					$long_description,
					$img_url
				);
			}						
		} else {
			$response_array = $services_class->new_service(
				$_POST["name_service"],
				$_POST["short_description"],
				$_POST["long_description"],
				$_POST["img_url"]
			);
		}
	break; 

	case 'get_user_services_list':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de ID de usuario');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->get_user_services_list(
					$user_id
				);
			}						
		} else {
			$response_array = $services_class->get_user_services_list(
				$_POST["user_id"]
			);
		}
	break;

	case 'get_service_details':
		if ($json_call) {
			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo de ID de servicio');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->get_service_details(
					$service_id
				);
			}						
		} else {
			$response_array = $services_class->get_service_details(
				$_POST["service_id"]
			);
		}
	break;

	case 'delete_service':
		if ($json_call) {
			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo de ID de servicio');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->delete_service(
					$service_id
				);
			}						
		} else {
			$response_array = $services_class->delete_service(
				$_POST["service_id"]
			);
		}
	break;

	case 'delete_service_user':
		if ($json_call) {

			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo ID de usuario');
			}

			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo de ID de servicio');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->delete_service_user(
					$user_id,
					$service_id
				);
			}						
		} else {
			$response_array = $services_class->delete_service_user(
				$_POST["user_id"],
				$_POST["service_id"]
			);
		}
	break;
	

	case 'get_worker_public_data':
		if ($json_call) {
			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de is de usuario');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $worker_class->get_worker_public_data(
					$user_id
				);
			}						
		} else {
			$response_array = $worker_class->get_worker_public_data(
				$_POST["user_id"]
			);
		}
		break;

	case 'get_services_list':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
			    array_push($errores_array,'Falta el campo de id de usuario');
			}

			$status = $data->status;
			if($status == null){
			    array_push($errores_array,'Falta el campo de is de status');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->get_services_list(
					$user_id,
					$status
				);
			}						
		} else {
			$response_array = $services_class->get_services_list(
				$_POST["user_id"],
				$_POST["status"]
			);
		}
		break;

	case 'get_service_details':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$service_id = $data->service_id;
			if($service_id == null){
			    array_push($errores_array,'Falta el campo de id de servicio');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $services_class->get_service_details(
					$service_id
				);
			}						
		} else {
			$response_array = $services_class->get_service_details(
				$_POST["service_id"]
			);
		}
		break;

	case 'book_new_service':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$client_id = $data->client_id;
			if($client_id == null){
				array_push($errores_array, 'Falta el campo ID de cliente');
			}

			$dog_sitter_id = $data->dog_sitter_id;
			if($dog_sitter_id == null){
				array_push($errores_array, 'Falta el campo ID de cuidador');
			}

			$pet_id = $data->pet_id;
			if($pet_id == null){
				array_push($errores_array, 'Falta el campo ID de la mascota');
			}

			$service_id = $data->service_id;
			if($service_id == null){
				array_push($errores_array, 'Falta el campo ID de servicio');
			}

			$appointment_date = $data->appointment_date;
			if($appointment_date == null){
				array_push($errores_array, 'Falta el campo Fecha de la reservación');
			}

			$num_events = $data->num_events;
			if($num_events == null){
				array_push($errores_array, 'Falta el campo Numero de eventos');
			}

			$paid_amount = $data->paid_amount;
			if($paid_amount == null){
				array_push($errores_array, 'Falta el campo monto de pago');
			}

			$status_payment = $data->status_payment;
			if($status_payment == null){
				array_push($errores_array, 'Falta el campo status de pago');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->book_new_service(
					$client_id, 
					$dog_sitter_id, 
					$pet_id, 
					$service_id,
					$appointment_date,
					$num_events,
					$paid_amount,
					$status_payment
					
				);
			}						
		} else {
			$response_array = $booking_class->book_new_service(
				$_POST["client_id"],
				$_POST["dog_sitter_id"],
				$_POST["pet_id"],
				$_POST["service_id"],
				$_POST["appointment_date"],
				$_POST["num_events"],
				$_POST["paid_amount"],
				$_POST["status_payment"]
			);
		}
	break;

	case 'confirm_booking_request':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo ID reservación');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->confirm_booking_request(
					$booking_id
				);
			}						
		} else {
			$response_array = $booking_class->confirm_booking_request(
				$_POST["$booking_id"]
			);
		}
	break;

	case 'update_booking_status':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo ID reservación');
			}

			$status = $data->status;
			if($status == null){
				array_push($errores_array, 'Falta el campo estado de la reservación');
			}

			$status_payment = $data->status_payment;
			if($status_payment == null){
				array_push($errores_array, 'Falta el campo estado de pago');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->update_booking_status(
					$booking_id,
					$status,
					$status_payment
				);
			}						
		} else {
			$response_array = $booking_class->update_booking_status(
				$_POST["$booking_id"],
				$_POST["$status"],
				$_POST["$status_payment"]
			);
		}
	break;

	case 'get_booking_data':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo ID reservación');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->get_booking_data(
					$booking_id
				);
			}						
		} else {
			$response_array = $booking_class->get_booking_data(
				$_POST["$booking_id"]
			);
		}
	break;


	case 'confirm_service_execution':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo bookig_id');
			}

			$worker_user_id = $data->worker_user_id;
			if($worker_user_id == null){
				array_push($errores_array, 'Falta el campo worker_user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->confirm_service_execution(
					$booking_id,
					$worker_user_id
				);
			}						
		} else {
			$response_array = $booking_class->confirm_service_execution(
				$_POST["booking_id"],
				$_POST["worker_user_id"]
			);
		}
		break;

	case 'check_on_worker':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo bookig_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->check_on_worker(
					$booking_id
				);
			}						
		} else {
			$response_array = $booking_class->check_on_worker(
				$_POST["booking_id"]
			);
		}
		break;

	case 'get_booking_data':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$booking_id = $data->booking_id;
			if($booking_id == null){
				array_push($errores_array, 'Falta el campo bookig_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->get_booking_data(
					$booking_id
				);
			}						
		} else {
			$response_array = $booking_class->get_booking_data(
				$_POST["booking_id"]
			);
		}
		break;

	case 'get_client_bookings':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->get_client_bookings(
					$user_id
				);
			}						
		} else {
			$response_array = $booking_class->get_client_bookings(
				$_POST["user_id"]
			);
		}
		break;

	case 'get_worker_bookings':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$worker_user_id = $data->worker_user_id;
			if($worker_user_id == null){
				array_push($errores_array, 'Falta el campo worker_user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->get_worker_bookings(
					$worker_user_id
				);
			}						
		} else {
			$response_array = $booking_class->get_worker_bookings(
				$_POST["worker_user_id"]
			);
		}
		break;

	case 'get_avaialble_bookings_requests':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$worker_user_id = $data->worker_user_id;
			if($worker_user_id == null){
				array_push($errores_array, 'Falta el campo worker_user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $booking_class->get_avaialble_bookings_requests(
					$worker_user_id
				);
			}						
		} else {
			$response_array = $booking_class->get_avaialble_bookings_requests(
				$_POST["worker_user_id"]
			);
		}
		break;

	case 'create_stripe_customer':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->create_stripe_customer(
					$user_id
				);
			}						
		} else {
			$response_array = $payments_class->create_stripe_customer(
				$_POST["user_id"]
			);
		}
		break;

	case 'get_stripe_customer_data':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->get_stripe_customer_data(
					$user_id
				);
			}						
		} else {
			$response_array = $payments_class->get_stripe_customer_data(
				$_POST["user_id"]
			);
		}
		break;

	case 'add_new_card':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			$card_token = $data->card_token;
			if($card_token == null){
				array_push($errores_array, 'Falta el campo card_token');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->add_new_card(
					$user_id,
					$card_token
				);
			}						
		} else {
			$response_array = $payments_class->add_new_card(
				$_POST["user_id"],
				$_POST["card_token"]
			);
		}
		break;

	case 'get_stripe_customers_cards':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->get_stripe_customers_cards(
					$user_id
				);
			}						
		} else {
			$response_array = $payments_class->get_stripe_customers_cards(
				$_POST["user_id"]
			);
		}
		break;

	case 'remove_card':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			$card_id = $data->card_id;
			if($card_id == null){
				array_push($errores_array, 'Falta el campo card_id');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->remove_card(
					$user_id,
					$card_id
				);
			}						
		} else {
			$response_array = $payments_class->remove_card(
				$_POST["user_id"],
				$_POST["card_id"]
			);
		}
		break;

	case 'execute_charge':
		if ($json_call) {
			$httpCode = 500; //Por si hay un error en la lógica

			$user_id = $data->user_id;
			if($user_id == null){
				array_push($errores_array, 'Falta el campo user_id');
			}

			$amount = $data->amount;
			if($amount == null){
				array_push($errores_array, 'Falta el campo amount');
			}

			$payment_source = $data->payment_source;
			if($payment_source == null){
				array_push($errores_array, 'Falta el campo payment_source');
			}

			$description = $data->description;
			if($description == null){
				array_push($errores_array, 'Falta el campo description');
			}

			if (count($errores_array) != 0) {
				$httpCode = 400;
				$response_array = $extras_class->response("false","e1",$errores_array, "both");
			} else {
				$httpCode = 200;
				$response_array = $payments_class->execute_charge(
					$user_id,
					$amount,
					$payment_source,
					$description
				);
			}						
		} else {
			$response_array = $payments_class->execute_charge(
				$_POST["user_id"],
				$_POST["amount"],
				$_POST["payment_source"],
				$_POST["description"]
			);
		}
		break;
	
	default:
		$response_array = $extras_class->response("false","e1","Hola amigo, cómo llegaste aquí?.", "both");
		break;
}

if ($json_call) {
	header('Content-type: application/json');
	http_response_code($httpCode);
}
echo json_encode($response_array);
?>