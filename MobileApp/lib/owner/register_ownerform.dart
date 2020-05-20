import 'package:flutter/material.dart';

const greencolor = const Color(0xFF4FB961);    

class RegisterOwnerform extends StatefulWidget{

    RegisterOwnerform({Key key, this.title}) : super(key: key);
  final String title;
  static _RegisterOwnerform of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_RegisterOwnerform>());

  @override
  _RegisterOwnerform createState() => _RegisterOwnerform();

}

class _RegisterOwnerform extends State<RegisterOwnerform>{
    int _counter = 0;
  bool filling_form = false;
  final _myForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //String mail = "prueba@prueba.com";
  //String password = "12345678";


/*   Future<http.Response> tryLogin(context) async {
    setState(() {
      filling_form = true;
    });
    final http.Response response = await http.post(
      'https://balabox-demos.com/fixme/backend/app/mods/mods',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'action': "login",
        'mail': mail,
        'password': password
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print("Good");
      if (jsonResponse[0]['status'] == "true") {
        String user_id = jsonResponse[1]['user_id'];
        if (user_id != null) {
          storeLoginData(mail, password, user_id, context);
        }
      } else {
        setState(() {
          filling_form = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message']);
      }
    } else {
      setState(() {
        filling_form = false;
      });
      _displaySnackBar(context, "No se ha podido iniciar sesión");
      throw Exception('Failed to login.');
    }
  } */

 /*  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  } */

/*   storeLoginData(mail, password, user_id, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_mail', mail);
    await prefs.setString('user_password', password);
    await prefs.setString('user_id', user_id);
    goHome(context);
  } */

/* goHome(context) {
    bool is_coach = false;
    if (is_coach) {
      Navigator.pushReplacement(
      //  context,
      //  MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
      //  context,
      //  MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  } */  

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
                         Form(
                          key: _myForm,
                          
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, right: 40),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            
                            children: <Widget>[

                              TextFormField(

                                style: TextStyle(
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Nombre',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Nombre',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey),
                                  ),
                                  focusedBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greencolor),
                                  ),
                                  errorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.yellow),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                ),
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Ingresa tu correo';
                                  } else {
                                    setState(() {
                                      mail = value;
                                    });
                                  } */
                                  return null;
                                  
                                },
                              ),
                          
                              TextFormField(

                                
                                
                                style: TextStyle(
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Apellido Paterno',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Apellido Paterno',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey),
                                  ),
                                  focusedBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greencolor),
                                  ),
                                  errorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.yellow),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                ),
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Ingresa tu correo';
                                  } else {
                                    setState(() {
                                      mail = value;
                                    });
                                  } */
                                  return null;
                                  
                                },
                              ),

                              TextFormField(

                                style: TextStyle(
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Apellido Materno',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Apellido Materno',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey),
                                  ),
                                  focusedBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greencolor),
                                  ),
                                  errorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.yellow),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                ),
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Ingresa tu correo';
                                  } else {
                                    setState(() {
                                      mail = value;
                                    });
                                  } */
                                  return null;
                                  
                                },
                              ),
                          
                              TextFormField(

                                style: TextStyle(
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Teléfono',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Teléfono',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey),
                                  ),
                                  focusedBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greencolor),
                                  ),
                                  errorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.yellow),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                ),
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Ingresa tu correo';
                                  } else {
                                    setState(() {
                                      mail = value;
                                    });
                                  } */
                                  return null;
                                  
                                },
                              ),

                              TextFormField(

                                style: TextStyle(
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  hintText: 'Dirección',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  labelText: 'Dirección',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey),
                                  ),
                                  focusedBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greencolor),
                                  ),
                                  errorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                  errorStyle: TextStyle(
                                      color: Colors.yellow),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.yellow),
                                  ),
                                ),
                                validator: (value) {
                                  /* if (value.isEmpty) {
                                    return 'Ingresa tu correo';
                                  } else {
                                    setState(() {
                                      mail = value;
                                    });
                                  } */
                                  return null;
                                  
                                },
                              ),


                              Padding(
                               padding: EdgeInsets.only(
                                   top: 20, bottom: 5),
                               child: RaisedButton(
                                 onPressed: () {
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
                                       "Siguiente",
                                       textAlign:
                                           TextAlign.center,
                                       style: TextStyle(
                                           color: Colors.white),
                                     ),
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