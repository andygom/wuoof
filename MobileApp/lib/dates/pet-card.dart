import 'package:flutter/material.dart';
import '../extras/globals.dart';
import '../extras/globals.dart';

Widget petCard(BuildContext context) {
  return Card(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(dummy_net_img),
        ),
      ),
    ),
  );
}
