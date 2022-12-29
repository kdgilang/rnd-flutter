import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/shared/widgets/title_subtitle.dart';

class TabContentContainer extends StatelessWidget {
  const TabContentContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: double.infinity),
      decoration: const BoxDecoration(
        color: ColorConstants.grey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Container(
          height: 70,
          decoration: const BoxDecoration(
            color: ColorConstants.grey,
          ),
        ),
        Expanded(
          child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white,
          ),
          child: Container(

            child: Column(children: [
              TitleSubtitle(title: title, subtitle: subtitle),
              child
            ]),
          ),
        ),)
    ])
    );
  }
}
