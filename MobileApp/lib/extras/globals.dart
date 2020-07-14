import 'dart:convert';

import 'package:flutter/material.dart';


String payHost  = 'hora';
String payWalk  = 'hora';
String payHotel = 'día';


var primary_yellow = Color(0xfffaca5e);
var primary_green = Colors.green;
var primary_red = Colors.red;
var primary_blue = Colors.blue;
var edit_color = Colors.blue;
var title_color = Colors.blue;
var small_title_weight = FontWeight.w700;
var small_title_size = 15.00;
var normal_padding = 15.00;
var small_padding = 7.50;
var common_grey = Colors.black54;
var small_paragraph_size = 12.00;
var small_border_radius = 5.0;
var big_border_radius = 15.0;
var medium_border_radius = 10.00;
var normal_margin = 15.00;
var drawer_bg =
    "https://i.pinimg.com/736x/3e/74/30/3e7430bab993954bbde7d61538f530a3.jpg";
var card_img =
    "https://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png";

var house_img =
    "https://st.hzcdn.com/simgs/fa31f5d505d3c11a_4-0906/home-design.jpg";

var pattern =
    "https://previews.123rf.com/images/natashapankina/natashapankina1607/natashapankina160700169/61231804-conjunto-drenado-mano-del-doodle-patr%C3%B3n-transparente-animales-cosas-y-de-suministro-de-iconos-ilustraci.jpg";

var dummy_net_img =
    "https://t1.uc.ltmcdn.com/images/8/7/8/img_cuanto_mide_un_perro_chihuahua_29878_600_square.jpg";
var dummy_pet_img_2 =
    "https://www.webanimales.com/ficheros/2014/11/PRAZSKY-KRYSARIK.jpg";
var dog_dummy_name = "Bambina";
var dog_dummy_name_2 = "Balvin";
var placeholder_dog = "https://us.123rf.com/450wm/roiandroi/roiandroi1801/roiandroi180100004/93089666-perro-lindo-del-perro-de-la-chihuahua-ilustraci%C3%B3n-de-dibujos-animados-de-vector-sobre-un-fondo-blanco-.jpg?ver=6";
var dummy_dog_bio =
    "Soy una perrita de 5 años, muy juguetona y me encanta socializar con otros perros.";

var dummy_net_partner =
    "https://assets.change.org/photos/9/xm/ov/HuXMoVlIDzauXCp-800x450-noPad.jpg?1562964866";
var dummy_partner_name = "Alex";
var dummy_partner_bio =
    "Soy una persona a la que le encanta cuidar de los perritos, tengo mucha experiencia y me apasiona.";

var dummy_user_name = "Luis";
var dummy_user_image =
    "https://www.ninjaonlinedating.com/images/Articles/Good_Dating_Profile_Photo.jpg?full=1";

var dummy_service_description =
    "Ten toda la confianza del mundo, te aseguro que tu mascota estará en las mejores manos, me encantan los perritos y además me he dedicado por mucho tiempo a cuidarlos. Les doy comida premium, así como también me gusta recompensarlos con galletas y juguetes.";

//Api
var api_url = "http://balabox-demos.com/wuoof/backend/app/mods/mods";
var images_path = "http://balabox-demos.com/wuoof/backend/app/img-pets/";

setImage(type, link, decoration) {
  var imageWidget;

  if (type == "network") {
    if (decoration) {
      if (link == null || link == "") {
        imageWidget = AssetImage("img/bg-2.jpg");
      } else {
        imageWidget = NetworkImage(link);
      }
    } else {
      if (link == null || link == "") {
        imageWidget = Image.asset(
          "img/bg-2.jpg",
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Image.network(
          link,
          fit: BoxFit.cover,
        );
      }
    }
  }

  return imageWidget;
}

checkJsonArray(BuildContext context, data) {
  var jsonString = data;
  Map<String, dynamic> decodedJSON;
  var decodeSucceeded = false;

  try {
    var array = jsonDecode(jsonString);
    if (array != "" && array != null){
      decodeSucceeded = true;
    }
  } on FormatException catch (e) {
    print('The provided string is not valid JSON');
  }

  print('Decoding succeeded: $decodeSucceeded');

  return decodeSucceeded;
}
