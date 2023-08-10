import 'package:flutter/material.dart';
import 'package:purala/core/components/heading_widget.dart';

class TabContainerWidget extends StatelessWidget {
  const TabContainerWidget({
    super.key,
    this.title = "",
    this.subtitle = "",
    required this.child
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        minHeight: double.infinity,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (title.isNotEmpty && subtitle.isNotEmpty)
            HeadingWidget(title: title, subtitle: subtitle),
          
          Expanded(
            child: child,
          ),
          
        ]
      ),
    );
  }
}





// old style
// class TabContainerWidget extends StatelessWidget {
//   const TabContainerWidget({
//     super.key,
//     required this.title,
//     this.subtitle,
//     required this.child
//   });

//   final String title;
//   final String? subtitle;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(
//         minHeight: double.infinity,
//       ),
//       decoration: const BoxDecoration(
//         color: ColorConstants.grey,
//       ),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(15.0),
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//           color: Colors.white,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             TitleWidget(title: title, subtitle: subtitle),
//             const SizedBox(height: 20,),
//             Expanded(
//               child: child,
//             ),
//           ]
//         ),
//       ),
//     );
//   }
// }
