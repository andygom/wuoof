import 'package:flutter/material.dart';
import '../owner/register_owner.dart';
import '../owner/user_login.dart';

const orangecolor = const Color(0xFFE6B548);
const yellowcolor = const Color(0xFFFACA5E);
const greencolor = const Color(0xFF4FB961);

Container _buildButtonRow(titletext, iconimage) {
  return Container(
    padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
    child: InkWell(
      child: Container(
        height: 100,
        width: 380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Text(titletext,
                      style: TextStyle(
                          color: greencolor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  child: Text(
                    ('Lorem'),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10),
                    child: Image.asset(iconimage),
                    height: 100,
                    alignment: Alignment.topRight),
              ],
            ),
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

                      Container(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: InkWell(
                child: Container(
                  height: 100,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text('Dueño',
                                style: TextStyle(
                                    color: greencolor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: Text(
                              ('Lorem'),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Image.asset('images/owner.png'),
                              height: 100,
                              alignment: Alignment.topRight),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           RegisterOwner()),
                  );  
                 },
               ),
             ),


              Container(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: InkWell(
                child: Container(
                  height: 100,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text('Cuidador',
                                style: TextStyle(
                                    color: greencolor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: Text(
                              ('Lorem'),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Image.asset('images/cuidador.png'),
                              height: 100,
                              alignment: Alignment.topRight),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           LoginPage()),
                  );  
                 },
               ),
             ),






             Container(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
              child: InkWell(
                child: Container(
                  height: 100,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text('Paseador',
                                style: TextStyle(
                                    color: greencolor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            child: Text(
                              ('Lorem'),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Image.asset('images/paseador.png'),
                              height: 100,
                              alignment: Alignment.topRight),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) =>
                           RegisterOwner()),
                  );  
                 },
               ),
             ),

  

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