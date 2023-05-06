import 'package:flutter/material.dart';
import 'package:purala/shared/widgets/charts/line_chart_widget.dart';
import 'package:purala/shared/widgets/charts/pie_chart_widget.dart';
import 'package:purala/home/widgets/tab_container_widget.dart';
import 'package:purala/home/widgets/tab_items_widget.dart';
import 'package:purala/signin/signin_screen.dart';
import 'package:purala/pos/pos_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).primaryColor,
          title: Center(
            child: Image.asset(
              "assets/icons/hp_logo_blue.png",
              width: 30,
              height: 30,
            )
          ),
          leading: Builder(builder: (context) => IconButton(
              color: Theme.of(context).textTheme.bodyText1!.color,
              iconSize: 30.0,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          ),
          actions: [
            IconButton(
              color: Theme.of(context).textTheme.bodyText1!.color,
              iconSize: 28.0,
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sign out'),
                onTap: () {
                  Navigator.pushNamed(context, SigninScreen.routeName);
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: const TabItemsWidget(),
        body: TabBarView(
          children: [ 
            const TabContainerWidget(
              title: "Point of sale",
              child: PosWidget()
            ),
            TabContainerWidget(
              title: "Statistic",
              subtitle: "Angus, your super has changed since you joined",
              child: LineChartWidget.withSampleData()
            ),
            TabContainerWidget(
              title: "History",
              subtitle: "find your transaction history",
              child: PieChartWidget.withSampleData()
            ),
            const TabContainerWidget(
              title: "Insurance",
              subtitle: "Angus, your super has changed since you joined",
              child: Text("")
            ),
            const TabContainerWidget(
              title: "None",
              subtitle: "Angus, your super has changed since you joined",
              child: Text("")
            ),
          ],
        ),
      ),
    );
  }
}
