import 'package:flutter/material.dart';
import 'package:purala/presentation/core/components/tile_widget.dart';

class StockWidget extends StatelessWidget {
  const StockWidget({super.key});
  
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
                  Text("Stock reminder", style: Theme.of(context).textTheme.titleMedium,),
                ],
              )
            ),
            Expanded(
              flex: 9,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TileWidget(title: "test", subtitle: "price");
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
