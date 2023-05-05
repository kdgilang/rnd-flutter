import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/pos/widgets/result_widget.dart';
import 'package:purala/pos/widgets/sidebar_widget.dart';

class PosWidget extends StatelessWidget {
  const PosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row (
  
      // mainAxisSize: MainAxisSize.max,
      children: const [
        Expanded(
          child: ResultWidget(),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: SidebarWidget(),
        )
      ],
    );
  }
}
