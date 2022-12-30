import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/shared/widgets/tab_content_container.dart';
import 'package:hostplus/src/shared/widgets/tab_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String id = "/main";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: ColorConstants.grey,
          title: Container(
            height: 30.0,
            width: 30.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/hp_logo_blue.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
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
        bottomNavigationBar: const TabItems(),
        body: const TabBarView(
          children: [ 
            TabContentContainer(
                title: "Dashboard",
                subtitle: "Angus, your super has changed since you joined",
                child: Text('data')
              ),
            TabContentContainer(
                    title: "Contributions",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            TabContentContainer(
                    title: "Investments",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            TabContentContainer(
                    title: "Insurance",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
            TabContentContainer(
                    title: "None",
                    subtitle: "Angus, your super has changed since you joined",
                    child: Text("")),
          ],
        ),
      ),
    );
  }
}
