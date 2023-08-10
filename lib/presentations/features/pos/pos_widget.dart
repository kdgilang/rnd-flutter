import 'package:flutter/material.dart';
import 'package:purala/presentations/features/pos/widgets/action_widget.dart';
import 'package:purala/presentations/features/pos/widgets/cart_widget.dart';
import 'package:purala/presentations/features/pos/widgets/history_widget.dart';
import 'package:purala/presentations/features/pos/widgets/search_widget.dart';
import 'package:purala/presentations/features/pos/widgets/stock_widget.dart';
import 'package:purala/presentations/features/pos/widgets/total_widget.dart';

class PosWidget extends StatelessWidget {
  const PosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row (
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: HistoryWidget()
              ),
              SizedBox(height: 10,),
              Expanded(
                child: StockWidget(),
              )
            ],
          )
        ),
        SizedBox(width: 20,),
        Expanded(
          flex: 5,
          child: SearchWidget(),
        ),
        SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: Column(
            children: [
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
