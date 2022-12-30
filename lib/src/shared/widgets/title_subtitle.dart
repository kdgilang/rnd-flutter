import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22))),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(subtitle, style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 11))
        )
      ]),
    );
  }
}
