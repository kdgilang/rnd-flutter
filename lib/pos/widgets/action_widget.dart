import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
      )
    );
  }
}
