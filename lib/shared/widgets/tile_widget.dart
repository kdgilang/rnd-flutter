import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.title, required this.price});

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).primaryColor,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
          //set border radius more than 50% of height and width to make circle
      ),
      leading: const FlutterLogo(size: 30.0),
      title: Text(
        title, 
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(price),
      onTap: () {}
    );
  }
}