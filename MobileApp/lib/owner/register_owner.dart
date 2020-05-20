import 'package:flutter/material.dart';
import 'register_ownerform.dart';

const greencolor = const Color(0xFF4FB961);    

class RegisterOwner extends StatefulWidget{

    RegisterOwner({Key key, this.title}) : super(key: key);
  final String title;
  static _RegisterOwner of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_RegisterOwner>());

  @override
  _RegisterOwner createState() => _RegisterOwner();

}

class _RegisterOwner extends State<RegisterOwner>{
    int _counter = 0;
  bool filling_form = false;
  final _myForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //String mail = "prueba@prueba.com";
  //String password = "12345678";


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: filling_form
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Center(
                child: const CircularProgressIndicator(),
              ))
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  color:  Colors.white,        
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30, bottom: 15, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Container(
                              child: Container(
                                  child: Image.asset('images/logo-fondo-blanco.png', height: 170),
                                
                              ),
                            ),

                             Container(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text('Registro Dueño',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                         Container(
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                               padding: EdgeInsets.only(
                                   top: 20, bottom: 5),
                               child: RaisedButton(
                                 onPressed: () {
                                    Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         RegisterOwnerform()),
                                    );        
                                   /* if (_myForm.currentState
                                       .validate()) {
                                     tryLogin(context);
                                   } */
                                 },
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                         BorderRadius.circular(
                                             80.0)),
                                 padding: EdgeInsets.all(0.0),
                                 child: Ink(
                                   decoration: BoxDecoration(
                                     color: greencolor,
                                       /* gradient: LinearGradient(
                                         colors: [
                                           Colors.lightGreen,
                                           Colors
                                               .lightGreenAccent
                                         ],
                                         begin: Alignment
                                             .centerLeft,
                                         end: Alignment
                                             .centerRight,
                                       ), */
                                       borderRadius:
                                           BorderRadius.circular(
                                               8.0)),
                                   child: Container(
                                     constraints: BoxConstraints(
                                         maxWidth:
                                             double.infinity,
                                         minHeight: 40.0),
                                     alignment: Alignment.center,
                                     child: Text(
                                       "Registro manual",
                                       textAlign:
                                           TextAlign.center,
                                       style: TextStyle(
                                           color: Colors.white),
                                     ),
                                   ),
                                 ),
                               ),
                              ),


                              Padding(
                               padding: EdgeInsets.only(
                                   top: 20, bottom: 5),
                                child: Divider(
                                  color: Colors.black,
                                ),

                              ),

                              Padding(
                               padding: EdgeInsets.only(
                                   top: 20, bottom: 5),
                               child: RaisedButton(
                                 onPressed: () {
                                  /*  Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         HomePage()),
                                    );      */  
                                   /* if (_myForm.currentState
                                       .validate()) {
                                     tryLogin(context);
                                   } */
                                 },
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                         BorderRadius.circular(
                                             80.0)),
                                 padding: EdgeInsets.all(0.0),
                                 child: Ink(
                                   decoration: BoxDecoration(
                                     color: greencolor,
                                       /* gradient: LinearGradient(
                                         colors: [
                                           Colors.lightGreen,
                                           Colors
                                               .lightGreenAccent
                                         ],
                                         begin: Alignment
                                             .centerLeft,
                                         end: Alignment
                                             .centerRight,
                                       ), */
                                       borderRadius:
                                           BorderRadius.circular(
                                               8.0)),
                                   child: Container(
                                     constraints: BoxConstraints(
                                         maxWidth:
                                             double.infinity,
                                         minHeight: 40.0),
                                     alignment: Alignment.center,
                                     child: Text(
                                       "Registro con Facebook",
                                       textAlign:
                                           TextAlign.center,
                                       style: TextStyle(
                                           color: Colors.white),
                                     ),
                                   ),
                                 ),
                               ),
                              ),

                              Padding(
                               padding: EdgeInsets.only(
                                   top: 20, bottom: 5),
                               child: RaisedButton(
                                 onPressed: () {
                                  /*  Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         HomePage()),
                                    );      */  
                                   /* if (_myForm.currentState
                                       .validate()) {
                                     tryLogin(context);
                                   } */
                                 },
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                         BorderRadius.circular(
                                             80.0)),
                                 padding: EdgeInsets.all(0.0),
                                 child: Ink(
                                   decoration: BoxDecoration(
                                     color: greencolor,
                                       /* gradient: LinearGradient(
                                         colors: [
                                           Colors.lightGreen,
                                           Colors
                                               .lightGreenAccent
                                         ],
                                         begin: Alignment
                                             .centerLeft,
                                         end: Alignment
                                             .centerRight,
                                       ), */
                                       borderRadius:
                                           BorderRadius.circular(
                                               8.0)),
                                   child: Container(
                                     constraints: BoxConstraints(
                                         maxWidth:
                                             double.infinity,
                                         minHeight: 40.0),
                                     alignment: Alignment.center,
                                     child: Text(
                                       "Registro con Google",
                                       textAlign:
                                           TextAlign.center,
                                       style: TextStyle(
                                           color: Colors.white),
                                     ),
                                   ),
                                 ),
                               ),
                              ),


                              Container(
                                padding: EdgeInsets.all(40),
                                 child: InkWell(
                                   onTap: () {
                                    /*  Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) =>
                                               RegisterPage()),
                                     ); */
                                   },
                                   child: RichText(
                                     
                                     text: new TextSpan(

                                       children: <TextSpan>[
                                         
                                         new TextSpan(
                                             text: 'Terminos y Condiciones',
                                             style: new TextStyle(
                                                 color: Colors.grey,
                                                 fontWeight:
                                                     FontWeight.bold)),

                                       ],
                                     ),
                                   ),
                                 ),
                              ),

                          ],
                          
                        ),
                         ),
                      ),

                        
                    ],
                    
                  ),
                    
                ),
              ],
              
            ),
          
                 
              )
              ]
              )
              );
  }
}