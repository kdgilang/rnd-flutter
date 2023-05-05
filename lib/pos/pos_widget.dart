import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/pos/widgets/result_widget.dart';

class PosWidget extends StatelessWidget {
  const PosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          ResultWidget()
        ],
      )
    );
  }
}
