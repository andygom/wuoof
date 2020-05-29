import 'package:flutter/material.dart';
import 'package:wuoof/owner/register_ownerform.dart';
import 'package:wuoof/partner/partner_signup.dart';
import '../extras/globals.dart';

const orangecolor = const Color(0xFFE6B548);
const yellowcolor = const Color(0xFFFACA5E);
const greencolor = const Color(0xFF4FB961);

Container _buildButtonRow(context, titletext, iconimage, type) {
  var ruta;

  switch (type) {
    case "owner":
      ruta = RegisterOwnerform();
      break;

    case "host":
      ruta = PartnerSignup("host");
      break;

    case "walker":
      ruta = PartnerSignup("walker");
      break;

    default:
      ruta = RegisterOwnerform();
      break;
  }

  return Container(
    child: InkWell(
      child: Container(
        height: 120,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: normal_margin),
        padding: EdgeInsets.all(normal_padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(medium_border_radius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.19),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(titletext,
                      style: TextStyle(
                          color: greencolor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    (dummy_dog_bio),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: normal_margin),
            Container(
                child: Image.asset(iconimage),
                height: 100,
                alignment: Alignment.topRight),
          ],
        ),
      ),

/*                             child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                                child : Padding(
                                  padding: const EdgeInsets.only(left: 40, right: 40),
                                  child: Container(
                                    
                                  
                                    child: FittedBox(
                                      
                                      
                                    child: Material(
                                      
                                      color: Colors.white,
                                      elevation: 14,
                                      borderRadius: BorderRadius.circular(20),
                                      shadowColor: Color(0x802196F3),
                                      child: Row(
                                        
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(40),
                                                  
                                                
                                                child: Text(titletext, 
                                                style: TextStyle(
                                                  
                                                  color: greencolor,
                                                  fontSize:80,
                                                  fontWeight: FontWeight.bold)),
                                                ),
                                              ],
                                              
                                            ),
                                          ),
                                            Container(
                                              padding: EdgeInsets.all(20),
                                               width: 500,
                                              height: 250,
                                              child: ClipRect(
                                                child: Image.asset(iconimage,
                                                 alignment: Alignment.topRight,
                                                 ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      
                                    ),
                                    ),
                                  ),),
                                  
                            ), */
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ruta),
        );
      },
    ),
  );
}

class UserType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: greencolor,
      body: ListView(children: <Widget>[
        Container(
            color: greencolor,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            /* padding: EdgeInsets.all(50), */
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Container(
                    child: Image.asset('images/logo_white.png', height: 170),
                  ),
                ),
                Container(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Text('¿Qué eres?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      _buildButtonRow(
                          context, "Dueño", "images/owner.png", "owner"),
                      _buildButtonRow(
                          context, "Cuidador", "images/cuidador.png", "host"),
                      _buildButtonRow(
                          context, "Paseador", "images/paseador.png", "walker"),

                      /*  _buildButtonRow('Dueño', 'images/owner.png'),
                      _buildButtonRow('Cuidador', 'images/cuidador.png'),
                      _buildButtonRow('Paseador', 'images/paseador.png') */
                    ],
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
