import 'package:flutter/material.dart';
import 'package:wuoof/general/partner-appbar.dart';
import 'package:wuoof/partner/partner_service_card.dart';
//import 'package:wuoof/owner/service_list_card.dart';
import '../extras/globals.dart';
import '../general/main-appbar.dart';
import '../pets/new_pet.dart';

class OfferedServices extends StatefulWidget {
  @override
  _OfferedServices createState() => _OfferedServices();
}

class _OfferedServices extends State<OfferedServices> {
  List<Map<String, dynamic>> listaTarjetas = [
    {
      "card_id": "card_123456789",
      "card_lastnumbers": "5882",
      "card_brand_img":
          "https://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png",
    },
    {
      "card_id": "card_123456788",
      "card_lastnumbers": "1882",
      "card_brand_img":
          "https://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png",
    },
    {
      "card_id": "card_123456787",
      "card_lastnumbers": "0812",
      "card_brand_img":
          "https://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png",
    },
  ];

  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = partner_appbar(context, "Mis servicios");

    return Scaffold(
      appBar: appBar,
      body: ListView(
        padding: EdgeInsets.all(normal_padding),
        children: <Widget>[
          partnerServiceCard(context, "walk", "90"),
          partnerServiceCard(context, "host", "200")
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          /* Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPet())); */
        },
        child: Icon(Icons.add),
        backgroundColor: primary_green,
      ), */
    );
  }
}
