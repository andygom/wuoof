import 'package:flutter/material.dart';
import 'package:wuoof/extras/globals.dart';
import 'user_walk_service_details.dart';
import 'partner_info.dart';
import 'partner_host_service_details.dart';

class PublicPartnerProfile extends StatefulWidget {
  final String service;
  PublicPartnerProfile(this.service);

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
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                primary: true,
                backgroundColor: primary_yellow,
                automaticallyImplyLeading: true,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: false,
                    title: Row(
                      children: <Widget>[
                        Text("Alex",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: primary_green,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Verificado",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    background: Image.network(
                      dummy_net_partner,
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      new Tab(
                          icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            size: 18,
                            color: primary_green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(widget.service)
                        ],
                      )),
                      new Tab(
                          icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person_pin,
                            size: 18,
                            color: primary_blue,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Perfil")
                        ],
                      )),
                    ],
                  ),
                ),
                pinned: false,
                floating: false,
              ),
            ];
          },
          body: Container(
            color: Colors.grey[200],
            child: TabBarView(children: [
              ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(normal_padding),
                    child: widget.service == "cuidado" ? hostServiceDetailsCard(context, "data") : profileServiceDetailsCard(context, "data"),
                  )
                ],
              ),
              ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(normal_padding),
                    child: partnerInfoCard(context, "data"),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
              color: primary_green,
              /// MediaQuery.of(context).padding.bottom - the bottom safe area size
              height: MediaQuery.of(context).padding.bottom + 50,
              child: SafeArea(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        Text('Contratar a '+dummy_partner_name, style: TextStyle(
                          color: Colors.white,
                        ),)
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
