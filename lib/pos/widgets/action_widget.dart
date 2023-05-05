import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
    );
  }
}
