import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.title, required this.price});

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        leading: const FlutterLogo(size: 30.0),
        title: Text(
          title, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(price),
        onTap: () {},
      ),
    );
  }
}