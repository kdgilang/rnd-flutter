import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';

class TabItems extends StatelessWidget {
  const TabItems({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.primary,
      child: const TabBar(
        labelStyle: TextStyle(fontSize: 10),
        labelColor: ColorConstants.secondary,
        unselectedLabelColor: Colors.white70,
        // indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            text: "Dashboard",
            icon: Icon(Icons.dashboard),
          ),
          Tab(
            text: "Contributions",
            icon: Icon(Icons.show_chart),
          ),
          Tab(
            text: "Investments",
            icon: Icon(Icons.money_off),
          ),
          Tab(
            text: "Insurance",
            icon: Icon(Icons.shield),
          ),
          Tab(
            text: "More",
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}