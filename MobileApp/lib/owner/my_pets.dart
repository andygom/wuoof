import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../pets/pet_list_card.dart';
import '../general/main-appbar.dart';

class MyPets extends StatefulWidget {
  @override
  _MyPets createState() => _MyPets();
}

class _MyPets extends State<MyPets> {
  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Mis mascotas");

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.all(normal_padding),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return petListCard(context, true, "cuidado");
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //addNewPet();
        },
        child: Icon(Icons.add),
        backgroundColor: primary_green,
      ),
    );
  }
}
