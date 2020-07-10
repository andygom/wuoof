import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';


  List<Asset> images = List<Asset>();
  String _error = 'No hay error';



  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: "#4fb961",
          actionBarColor: "#4fb961",
          actionBarTitle: "Fotos de mi servicio",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      //ByteData byteData = await images[0].getByteData(quality: 80);
      print("Hey");
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
    return images;
  }