import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/validation.dart';

// Future<String> rateDialog(context, partnerName) async {
//   return showDialog(
//     context: context,
//     barrierDismissible: true, // set to false if you want to force a rating
//     builder: (context) {
//         return RatingDialog(
//         icon: const FlutterLogo(
//             size: 100,
//             colors: Colors.red), // set your own image/icon widget
//         title: "Califica a " + dummy_partner_name,
//         description:
//             "Tap a star to set your rating. Add more description here if you want.",
//         submitButton: "SUBMIT",
//         alternativeButton: "Contact us instead?", // optional
//         positiveComment: "We are so happy to hear :)", // optional
//         negativeComment: "We're sad to hear :(", // optional
//         accentColor: Colors.red, // optional
//         onSubmitPressed: (int rating) {
//             print("onSubmitPressed: rating = $rating");
//         },
//         onAlternativePressed: () {
//             print("onAlternativePressed: do something");
//         },
//         );
//     });
// }

Future<String> rateDialog(context, partnerName) async {
  final _myForm = GlobalKey<FormState>();
  String review = 'review';
  double raitingPet = 0;

  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(medium_border_radius)),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Califica a " + dummy_partner_name,
              textAlign: TextAlign.center,
            ),
          ),
          contentPadding:
              EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 0),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Container(
              child: RatingBar(
                glowColor: Colors.blue[100],
                unratedColor: Colors.blueAccent[50],
                ignoreGestures: false,
                initialRating: 0,
                itemSize: 25,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.pets,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  raitingPet = rating;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Scrollbar(
                child: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  child: SizedBox(
                    height: 100.0,
                    child: Form(
                      key: _myForm,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        validator: reviewValidator,
                        onChanged: (val) => review = val,
                        maxLength: 50,
                        maxLines: 100,
                        decoration: new InputDecoration(
                          filled: true,
                          fillColor: Colors.blueAccent[50],
                          border: InputBorder.none,
                          labelText: 'Recomienda a ' + dummy_partner_name,
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                          // hintText: 'Recomienda a ' + dummy_partner_name,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Grrr!',
                //  'Seguir',
                style: TextStyle(color: Colors.red, fontSize: 17),
              ),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Wuoof!',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                if (_myForm.currentState.validate() && raitingPet > 0) {
                  Navigator.of(context).pop();
                } 
              },
            ),
          ],
        );
      });
    },
  );
}
