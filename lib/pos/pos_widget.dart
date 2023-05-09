import 'package:flutter/material.dart';
import 'package:purala/pos/widgets/search_widget.dart';
import 'package:purala/pos/widgets/sidebar_widget.dart';

class PosWidget extends StatelessWidget {
  const PosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row (
  
      // mainAxisSize: MainAxisSize.max,
      children: const [
        Expanded(
          flex: 7,
          child: SearchWidget(),
        ),
        SizedBox(width: 20,),
        Expanded(
          flex: 3,
          child: SidebarWidget(),
        )
      ],
    );
  }
}
