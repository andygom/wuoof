import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../extras/globals.dart';
import '../extras/globals.dart';
import '../general/main-appbar.dart';
import 'list-card.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;


class WalkerList extends StatefulWidget {
  @override
  _WalkerList createState() => _WalkerList();
}

class _WalkerList extends State<WalkerList> {
  List<RangeSliderData> rangeSliders;

  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  double _lowerValueFormatter = 20.0;
  double _upperValueFormatter = 20.0;

  Future<String> showFilters(context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Filtrar'),
            contentPadding:
                EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Filtra la lista con las siguientes opciones",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
                frs.RangeSlider(
                  min: 0.0,
                  max: 500.0,
                  lowerValue: _lowerValue,
                  upperValue: _upperValue,
                  divisions: 50,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 1,
                  onChanged: (double newLowerValue, double newUpperValue) {
                    setState(() {
                      _lowerValue = newLowerValue;
                      _upperValue = newUpperValue;
                    });
                  },
                  onChangeStart:
                      (double startLowerValue, double startUpperValue) {
                    print(
                        'Started with values: $startLowerValue and $startUpperValue');
                  },
                  onChangeEnd: (double newLowerValue, double newUpperValue) {
                    print(
                        'Ended with values: $newLowerValue and $newUpperValue');
                  },
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Aplicar'),
                onPressed: () {},
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: primary_yellow,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text("Paseadores"),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {
            showFilters(context);
          },
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              color: primary_yellow,
              padding: EdgeInsets.all(normal_padding),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: "walker-badge",
                    child: Container(
                    width: 80,
                    height: 80,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(80),
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage("images/paseador.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Encuentra al paseador ideal para tu mascota",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          Expanded(
            child: ListView.builder(
                itemCount: 20,
                padding: EdgeInsets.all(normal_padding),
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return partnerListCard(context, true, "paseo");
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: primary_green,
        icon: Image.asset(
          "images/paseador.png",
          width: 40,
        ),
        label: Text("Únete"),
      ),
    );
  }

  // -----------------------------------------------
  // Creates a list of RangeSliders, based on their
  // definition and SliderTheme customizations
  // -----------------------------------------------
  List<Widget> _buildRangeSliders() {
    List<Widget> children = <Widget>[];
    for (int index = 0; index < rangeSliders.length; index++) {
      children
          .add(rangeSliders[index].build(context, (double lower, double upper) {
        // adapt the RangeSlider lowerValue and upperValue
        setState(() {
          rangeSliders[index].lowerValue = lower;
          rangeSliders[index].upperValue = upper;
        });
      }));
      // Add an extra padding at the bottom of each RangeSlider
      children.add(SizedBox(height: 8.0));
    }

    return children;
  }

  // -------------------------------------------------
  // Creates a list of RangeSlider definitions
  // -------------------------------------------------
  List<RangeSliderData> _rangeSliderDefinitions() {
    return <RangeSliderData>[
      RangeSliderData(
          min: 0.0, max: 100.0, lowerValue: 10.0, upperValue: 100.0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          overlayColor: Colors.red[100]),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: false,
          valueIndicatorMaxDecimals: 0),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 10.0,
          upperValue: 30.0,
          showValueIndicator: true,
          valueIndicatorMaxDecimals: 0,
          activeTrackColor: Colors.red,
          inactiveTrackColor: Colors.red[50],
          valueIndicatorColor: Colors.green),
      RangeSliderData(
          min: 0.0,
          max: 100.0,
          lowerValue: 25.0,
          upperValue: 75.0,
          divisions: 20,
          thumbColor: Colors.grey,
          valueIndicatorColor: Colors.grey),
    ];
  }
}

// ---------------------------------------------------
// Helper class aimed at simplifying the way to
// automate the creation of a series of RangeSliders,
// based on various parameters
//
// This class is to be used to demonstrate the appearance
// customization of the RangeSliders
// ---------------------------------------------------
class RangeSliderData {
  double min;
  double max;
  double lowerValue;
  double upperValue;
  int divisions;
  bool showValueIndicator;
  int valueIndicatorMaxDecimals;
  bool forceValueIndicator;
  Color overlayColor;
  Color activeTrackColor;
  Color inactiveTrackColor;
  Color thumbColor;
  Color valueIndicatorColor;
  Color activeTickMarkColor;

  static const Color defaultActiveTrackColor = const Color(0xFF0175c2);
  static const Color defaultInactiveTrackColor = const Color(0x3d0175c2);
  static const Color defaultActiveTickMarkColor = const Color(0x8a0175c2);
  static const Color defaultThumbColor = const Color(0xFF0175c2);
  static const Color defaultValueIndicatorColor = const Color(0xFF0175c2);
  static const Color defaultOverlayColor = const Color(0x290175c2);

  RangeSliderData({
    this.min,
    this.max,
    this.lowerValue,
    this.upperValue,
    this.divisions,
    this.showValueIndicator: true,
    this.valueIndicatorMaxDecimals: 1,
    this.forceValueIndicator: false,
    this.overlayColor: defaultOverlayColor,
    this.activeTrackColor: defaultActiveTrackColor,
    this.inactiveTrackColor: defaultInactiveTrackColor,
    this.thumbColor: defaultThumbColor,
    this.valueIndicatorColor: defaultValueIndicatorColor,
    this.activeTickMarkColor: defaultActiveTickMarkColor,
  });

  // Returns the values in text format, with the number
  // of decimals, limited to the valueIndicatedMaxDecimals
  //
  String get lowerValueText =>
      lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  // Builds a RangeSlider and customizes the theme
  // based on parameters
  //
  Widget build(BuildContext context, frs.RangeSliderCallback callback) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(lowerValueText),
          ),
          Expanded(
            child: SliderTheme(
              // Customization of the SliderTheme
              // based on individual definitions
              // (see rangeSliders in _RangeSliderSampleState)
              data: SliderTheme.of(context).copyWith(
                overlayColor: overlayColor,
                activeTickMarkColor: activeTickMarkColor,
                activeTrackColor: activeTrackColor,
                inactiveTrackColor: inactiveTrackColor,
                //trackHeight: 8.0,
                thumbColor: thumbColor,
                valueIndicatorColor: valueIndicatorColor,
                showValueIndicator: showValueIndicator
                    ? ShowValueIndicator.always
                    : ShowValueIndicator.onlyForDiscrete,
              ),
              child: frs.RangeSlider(
                min: min,
                max: max,
                lowerValue: lowerValue,
                upperValue: upperValue,
                divisions: divisions,
                showValueIndicator: showValueIndicator,
                valueIndicatorMaxDecimals: valueIndicatorMaxDecimals,
                onChanged: (double lower, double upper) {
                  // call
                  callback(lower, upper);
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: 40.0,
              maxWidth: 40.0,
            ),
            child: Text(upperValueText),
          ),
        ],
      ),
    );
  }
}
