import 'package:flutter/material.dart';
import 'package:hostplus/constants/color_constants.dart';
import 'package:hostplus/shared/widgets/chart_stacked_line_widget.dart';
import 'package:hostplus/home/widgets/tab_container_widget.dart';
import 'package:hostplus/home/widgets/tab_items_widget.dart';

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
          backgroundColor: ColorConstants.grey,
          title: Center(
            child: Image.asset(
              "assets/icons/hp_logo_blue.png",
              width: 30,
              height: 30,
            )
          ),
          leading: Builder(builder: (context) => IconButton(
              iconSize: 30.0,
              color: ColorConstants.primary,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          ),
          actions: [
            IconButton(
              iconSize: 28.0,
              color: ColorConstants.primary,
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          backgroundColor: ColorConstants.primary,
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
            ],
          ),
        ),
        bottomNavigationBar: const TabItemsWidget(),
        body:  TabBarView(
          children: [ 
            TabContainerWidget(
                title: "Dashboard",
                subtitle: "Angus, your super has changed since you joined",
                child: ChartStackedLineWidget.withSampleData()
              ),
            const TabContainerWidget(
                    title: "Contributions",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            const TabContainerWidget(
                    title: "Investments",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            const TabContainerWidget(
                    title: "Insurance",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            const TabContainerWidget(
                    title: "None",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
          ],
        ),
      ),
    );
  }
}
