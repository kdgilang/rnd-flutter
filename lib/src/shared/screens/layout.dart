import 'package:flutter/material.dart';
import 'package:hostplus/src/shared/widgets/tab_content_container.dart';
import 'package:hostplus/src/shared/widgets/tab_items.dart';
import 'package:hostplus/src/shared/widgets/title_subtitle.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 30.0,
            width: 30.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/hp_logo.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        bottomNavigationBar: const TabItems(),
        body: TabBarView(
          children: [
            Container(
                child: const TabContentContainer(
                  title: "",
                  subtitle: "",
                  child: Text('data'))
              ),
            Container(
                child: const TitleSubtitle(
                    title: "Contributions",
                    subtitle:
                        "Angus, your super has changed since you joined")),
            Container(
                child: const TitleSubtitle(
                    title: "Investments",
                    subtitle:
                        "Angus, your super has changed since you joined")),
            Container(
                child: const TitleSubtitle(
                    title: "Insurance",
                    subtitle:
                        "Angus, your super has changed since you joined")),
            Container(
                child: const TitleSubtitle(
                    title: "None",
                    subtitle:
                        "Angus, your super has changed since you joined")),
          ],
        ),
      ),
    );
  }
}
