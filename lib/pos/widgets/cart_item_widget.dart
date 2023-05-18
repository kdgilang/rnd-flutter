import 'package:flutter/material.dart';
import 'package:purala/widgets/stepper_widget.dart';
import 'package:purala/widgets/tile_widget.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
          //set border radius more than 50% of height and width to make circle
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 8,
            child: TileWidget(title: "title", subtitle: "price", isDisabled: true, hasPadding: false,),
          ),
          Expanded(
            flex: 2,
            child: StepperWidget(onChanged: (val) {}),
          ),
        ],
      ),
    );
  }
}
