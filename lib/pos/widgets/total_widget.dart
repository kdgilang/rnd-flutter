import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key});
  
  final bool isButtonsVisible = false;

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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
              Text("Subtotal:"),
              Text("Rp.20000000")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
              Text("Tax:"),
              Text("Rp.20000")
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
              Text("Discount:"),
              Text("Rp.200000000")
            ]),
          ],
        ),
      )
    );
  }
}
