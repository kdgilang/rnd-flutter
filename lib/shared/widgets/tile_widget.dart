import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({super.key, required this.title, required this.subtitle, this.isDisabled = false, this.hasPadding = true });

  final String title;
  final String subtitle;
  final bool isDisabled;
  final bool hasPadding;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        contentPadding: hasPadding ? const EdgeInsets.fromLTRB(15, 5, 15, 5) : EdgeInsets.zero,
        leading: const FlutterLogo(size: 30.0),
        title: Text(
          title, 
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        onTap: isDisabled ? null : () {},
      ),
    );
  }
}