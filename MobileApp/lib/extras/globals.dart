import 'package:flutter/material.dart';

var primary_yellow = Colors.orangeAccent;
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
var normal_margin = 15.00;
var drawer_bg =
    "https://i.pinimg.com/736x/3e/74/30/3e7430bab993954bbde7d61538f530a3.jpg";
var card_img =
    "https://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png";

var dummy_net_img =
    "https://t1.uc.ltmcdn.com/images/8/7/8/img_cuanto_mide_un_perro_chihuahua_29878_600_square.jpg";
var dummy_pet_img_2 =
    "https://www.webanimales.com/ficheros/2014/11/PRAZSKY-KRYSARIK.jpg";
var dog_dummy_name = "Bambina";
var dog_dummy_name_2 = "Balvin";
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
