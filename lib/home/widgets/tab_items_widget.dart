import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class TabItemsWidget extends StatelessWidget {
  const TabItemsWidget({ super.key });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.primary,
      child: const TabBar(
        labelStyle: TextStyle(fontSize: 7),
        labelColor: ColorConstants.secondary,
        unselectedLabelColor: Colors.white70,
        // indicatorSize: TabBarIndicatorSize.tab,
        // indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            text: "Pos",
            icon: Icon(Icons.computer),
          ),
          Tab(
            text: "Statistic",
            icon: Icon(Icons.show_chart),
          ),
          Tab(
            text: "History",
            icon: Icon(Icons.history),
          ),
          Tab(
            text: "Investment",
            icon: Icon(Icons.money_off),
          ),
          Tab(
            text: "Insurance",
            icon: Icon(Icons.shield),
          ),
        ],
      ),
    );
  }
}