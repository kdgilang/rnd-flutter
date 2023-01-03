import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/shared/widgets/title_subtitle.dart';

class TabContentContainer extends StatelessWidget {
  const TabContentContainer({
    super.key,
    required this.title,
    this.subtitle,
    required this.child
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: double.infinity),
      decoration: const BoxDecoration(
        color: ColorConstants.grey,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TitleSubtitle(title: title, subtitle: subtitle),
            const SizedBox(height: 20,),
            Expanded(
              child: child,
            )
          ]
        ),
      ),
    );
  }
}
