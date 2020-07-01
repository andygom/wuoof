import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wuoof/extras/globals.dart';
import 'package:wuoof/owner/checkout.dart';
import 'user_walk_service_details.dart';
import 'partner_info.dart';
import 'partner_host_service_details.dart';

class PublicPartnerProfile extends StatefulWidget {
  final String service;
  var partnerData;
  PublicPartnerProfile(this.service, this.partnerData);

  @override
  _PublicPartnerProfile createState() => _PublicPartnerProfile();
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _PublicPartnerProfile extends State<PublicPartnerProfile> {
  
  @override
  Widget build(BuildContext context) {
    String name = "N/D";
    String city = "N/D";
    String description = "N/D";
    String service_price = null;
    String partner_img = pattern;

    String tabServiceName = "N/D";

    if (checkJsonArray(context, jsonEncode(widget.partnerData))) {
      print(jsonEncode(widget.partnerData));
      name = widget.partnerData["name"];
      description = widget.partnerData["description"];
      service_price = widget.partnerData["price"];
      partner_img = widget.partnerData["img_url"];
    }

    if (widget.service == "walk"){
      tabServiceName = "Paseo";
      print('paseo');
    } else {
      tabServiceName = "Cuidado";
      print('cuidado');
    }

    return Scaffold(
      bottomNavigationBar: Container(
          color: primary_green,

          /// MediaQuery.of(context).padding.bottom - the bottom safe area size
          height: MediaQuery.of(context).padding.bottom + 58,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Checkout(widget.partnerData, widget.service)));
              },
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 5),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    Text(
                      'Wuoof!',
                     // 'Contratar a ' + name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
