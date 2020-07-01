import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/main-appbar.dart';
import 'package:wuoof/owner/requesting.dart';
import '../partner/list-card.dart';

class Checkout extends StatefulWidget {
  var partnerData;
  final String service;

  Checkout(this.partnerData, this.service);

  @override
  _Checkout createState() => _Checkout();
}

class _Checkout extends State<Checkout> {
  String _date = "Seleccionar fecha";
  String _time = "Seleccionar hora";
  String dropdownValue = "One";
  bool loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String mail = null;
  String password = null;
  String user_id = null;

  int event_counter = 1;
  String event_counter_string = "1";

  String payment_action = "request_payment";

  /* preBookingRequest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = (prefs.getString('user_mail') ?? null);
      password = (prefs.getString('user_password') ?? null);
      user_id = (prefs.getString('user_id') ?? null);
    });
    if (mail != null && password != null && user_id != null) {
      requestBooking(context);
    } else {
      //Logout
      Navigator.of(context).pop();
    }
  } */

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /* Future<String> _asyncInputDialog(BuildContext context) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingresa tu cupón'),
          content: new Column(
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Código de cupón',
                    hintText: 'eg. Juventus F.C.'),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }

  Future<http.Response> requestBooking(context) async {
    final http.Response response = await http.post(
      'http://balabox-demos.com/fixme/backend/app/mods/mods',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "action": "book_new_service",
        "client_user_id": user_id,
        "worker_user_id": "",
        "service_id": widget.service_id,
        "appointment_date": selectedDate.toString(),
        "appointment_location": "Calle Ejemplo, 1, Col. Ejemplo",
        "payment_action": payment_action,
        "customer_id": "customerStripe_IZnaROosy5Y",
        "method": "Tarjeta",
        "card_id": "card_0897685tgyhi",
        "coupon": "",
        "status": "looking_for_worker"
      }),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      //print("Good");
      if (jsonResponse[0]['status'] == "true") {
        String booking_id = jsonResponse[1]['booking_id'];
        setState(() {
          loading = false;
        });
        //print("Listo");
        if (booking_id != null) {
        } else {
          _displaySnackBar(context, jsonResponse[0]['message'].toString());
          Navigator.pop(context);
        }
      } else {
        setState(() {
          loading = false;
        });
        _displaySnackBar(context, jsonResponse[0]['message'].toString());
      }
    } else {
      setState(() {
        loading = false;
      });
      _displaySnackBar(context, jsonResponse[0]['message'].toString());
      throw Exception('Failed to login.');
    }
  } */

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  validateRequestData(context) {
    /* setState(() {
      loading = true;
    }); */
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Requesting()));
    //requestBooking(context);
    //preBookingRequest(context);
  }

  eventCount(add) {
    if (add) {
      setState(() {
        event_counter++;
      });
    } else {
      if (event_counter > 1) {
        setState(() {
          event_counter = event_counter - 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = "N/D";
    String city = "N/D";
    String description = "N/D";
    String service_price = null;
    String partner_img = pattern;

    String ticketServiceDescription = "N/D";

    if (checkJsonArray(context, jsonEncode(widget.partnerData))) {
      print(jsonEncode(widget.partnerData));
      name = widget.partnerData["name"];
      description = widget.partnerData["description"];
      service_price = widget.partnerData["price"];
      partner_img = widget.partnerData["img_url"];
    }

    if (widget.service == "walk") {
      ticketServiceDescription =
          "Los paseos son un servicio que ofrece Wuoof, en el que la persona a la que contratas se encarga de dar un paseo a tu mascota, y puede variar la dinámica dependiendo de la oferta de cada paseador.";
    } else {
      ticketServiceDescription =
          "Los cuidados son un servicio que ofrece Wuoof, en el que la persona a la que contratas se encarga de cuidar a tu mascota por el día ó por la noche dependiendo el acuerdo, y puede variar la dinámica dependiendo de la oferta de cada paseador.";
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: main_appbar(context, "Checkout"),
        body: loading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: const CircularProgressIndicator(),
                ))
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/Chat-bg.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop))),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: partnerListCard(context, true,
                                widget.partnerData, "cuidado", false),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Material(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(40),
                                  child: new InkWell(
                                    onTap: () {
                                      eventCount(false);
                                    },
                                    borderRadius: BorderRadius.circular(40),
                                    child: new Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Icon(Icons.remove,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 40,
                                    padding: EdgeInsets.symmetric(
                                        vertical: small_padding,
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Colors.grey[200]),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(event_counter.toString(),
                                            style: TextStyle(
                                                color: common_grey,
                                                fontWeight: FontWeight.w700)),
                                        Text("/ días",
                                            style: TextStyle(
                                                color: common_grey,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    )),
                                Material(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(40),
                                  child: InkWell(
                                    onTap: () {
                                      eventCount(true);
                                    },
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child:
                                          Icon(Icons.add, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Ticket",
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 0),
                                            child: SizedBox(
                                              height: 0.5,
                                              width: double.infinity,
                                              child: const DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              ticketServiceDescription,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 0),
                                            child: SizedBox(
                                              height: 0.5,
                                              width: double.infinity,
                                              child: const DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Text(
                                              '\$' +
                                                  (event_counter *
                                                          double.parse(
                                                              service_price))
                                                      .toString() +
                                                  ' mxn',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: primary_green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 0.0,
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight: 210.0,
                                  ),
                                  showTitleActions: true,
                                  minTime: DateTime(2000, 1, 1),
                                  maxTime: DateTime(2022, 12, 31),
                                  onConfirm: (date) {
                                print('confirm $date');
                                _date =
                                    '${date.year} - ${date.month} - ${date.day}';
                                setState(() {});
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              size: 15.0,
                                              color: primary_yellow,
                                            ),
                                            Text(
                                              " $_date",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "  Cambiar",
                                    style: TextStyle(
                                        color: primary_yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 0.0,
                            onPressed: () {
                              DatePicker.showTimePicker(context,
                                  theme: DatePickerTheme(
                                    containerHeight: 210.0,
                                  ),
                                  showTitleActions: true, onConfirm: (time) {
                                print('confirm $time');
                                _time =
                                    '${time.hour} : ${time.minute} : ${time.second}';
                                setState(() {});
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.access_time,
                                              size: 15.0,
                                              color: primary_yellow,
                                            ),
                                            Text(
                                              " $_time",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "  Cambiar",
                                    style: TextStyle(
                                        color: primary_yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ],
                              ),
                            ),
                            color: Colors.white,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 0),
                            child: SizedBox(
                              height: 0.5,
                              width: double.infinity,
                              child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.grey),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              validateRequestData(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [primary_yellow, primary_yellow],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: double.infinity, minHeight: 40.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Seleccionar tarjeta",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              validateRequestData(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [primary_green, primary_green],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: double.infinity, minHeight: 40.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Wuoof!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
  }
}
