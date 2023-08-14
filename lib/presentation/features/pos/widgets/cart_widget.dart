import 'package:flutter/material.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';
import 'package:purala/presentation/features/pos/widgets/cart_item_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order summary", style: Theme.of(context).textTheme.headlineSmall,),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: ColorConstants.tertiary,
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    child: const Text(
                      "Clear all"
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 9,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CartItemWidget();
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ),
            )
          ],
        )
      )
    );
  }
}
