import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/pos/widgets/action_widget.dart';
import 'package:purala/pos/widgets/cart_widget.dart';
import 'package:purala/pos/widgets/total_widget.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: const [
          Expanded(
            child: CartWidget()
          ),
          SizedBox(height: 10,),
          TotalWidget(),
          SizedBox(height: 10,),
          ActionWidget()
        ],
      );
  }
}