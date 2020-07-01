import 'package:flutter/material.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/general/main-appbar.dart';

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

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethods createState() => _PaymentMethods();
}

class _PaymentMethods extends State<PaymentMethods> with ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  /* PaymentMethod _paymentMethod = PaymentMethod(); */

  @override
  void initState() {
    super.initState();
    /* StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_1A9Tx5rNPvvdmKgWc07nFhQZ00wCcQe3x7")); */
  }

  addNewCard() {
    /* StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .then((paymentMethod) {
      _paymentMethod = paymentMethod;
    }).catchError((error) {
      print(error.toString());
    }); */
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = main_appbar(context, "Mis tarjetas");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: appBar.preferredSize.height +
                MediaQuery.of(context).padding.top,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.blue, Colors.deepPurple],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(2.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              image: DecorationImage(
                image: AssetImage("img/bg-2.jpg"),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/white-bg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop))),
              child: new ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: listaTarjetas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listaTarjetas[index]["card_id"];
                    final lastDigits = listaTarjetas[index]["card_lastnumbers"];
                    return Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Dismissible(
                        // Show a red background as the item is swiped away.
                        background: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: Text(
                            "Eliminar tarjeta",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        key: Key(item),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          listaTarjetas
                              .removeWhere((item) => item["card_id"] == item);

                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Tarjeta terminación $lastDigits eliminada")));
                        },

                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: new LinearGradient(
                                colors: [Colors.grey[300], Colors.grey[200]],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(2.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.network(
                                    listaTarjetas[index]["card_brand_img"],
                                    width: 25,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Terminación: " +
                                          listaTarjetas[index]
                                              ["card_lastnumbers"],
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Desliza para eliminar",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewCard();
        },
        child: Icon(Icons.add),
        backgroundColor: primary_green,
      ),
    );
  }
}
