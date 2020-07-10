import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wuoof/general/main-appbar.dart';

import 'extras/globals.dart';


class SliderAppBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SliderAppBarState();
  }
}

class _SliderAppBarState extends State<SliderAppBar>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customScrollView(),
    );
  }
}

Widget _customScrollView(){
  List<dynamic> _images = [
    Image.network(house_img),
    Image.network(house_img),
    Image.network(house_img),
    Image.network(house_img),
    Image.network(house_img)
  ];
    return CustomScrollView(
      slivers: <Widget>[
  SliverAppBar(
    expandedHeight: 250.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text("Collapsing Toolbar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            )),
        background: Swiper(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) => 
            Image.network(house_img, 
            fit: BoxFit.cover,),
          autoplay: false,
          scrollDirection: Axis.horizontal,
          pagination: new SwiperPagination(
             margin: new EdgeInsets.all(50.0),
             alignment: Alignment.topCenter
    ),
            
        )),
  ),
  SliverList(
    delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 75,
                color: Colors.black12,
              ),
            ),
        childCount: 10),
  )
]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _customScrollView(),
    );
  }


