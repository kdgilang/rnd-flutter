import 'package:flutter/material.dart';
import 'package:purala/pos/widgets/action_widget.dart';
import 'package:purala/pos/widgets/cart_widget.dart';
import 'package:purala/pos/widgets/search_widget.dart';
import 'package:purala/pos/widgets/total_widget.dart';

class PosWidget extends StatelessWidget {
  const PosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row (
      children: [
        const Expanded(
          flex: 2,
          child: Text("test"),
        ),
        const Expanded(
          flex: 5,
          child: SearchWidget(),
        ),
        const SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Column(
            children: const [
              Expanded(
                flex: 6,
                child: CartWidget()
              ),
              SizedBox(height: 10,),
              Expanded(
                flex: 2,
                child: TotalWidget(),
              ),
              SizedBox(height: 10,),
              Expanded(
                flex: 2,
                child: ActionWidget(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
