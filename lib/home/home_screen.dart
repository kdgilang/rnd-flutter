import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/providers/user_provider.dart';
import 'package:purala/starter/starter_screen.dart';
import 'package:purala/user/user_screen.dart';
import 'package:purala/widgets/charts/line_chart_widget.dart';
import 'package:purala/widgets/charts/pie_chart_widget.dart';
import 'package:purala/home/widgets/tab_container_widget.dart';
import 'package:purala/home/widgets/tab_items_widget.dart';
import 'package:purala/pos/pos_widget.dart';
import 'package:purala/widgets/layouts/authenticated_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return AuthenticatedLayout(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Theme.of(context).primaryColor,
            title: Center(
              child: Image.asset(
                "assets/icons/purala-logo.png",
                width: 30,
                height: 30,
              )
            ),
            leading: Builder(builder: (context) => IconButton(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                iconSize: 30.0,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            ),
            actions: [
              IconButton(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                iconSize: 28.0,
                onPressed: () {},
                icon: context.read<UserProvider>().user!.image != null ?
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorConstants.secondary,
                      child: CircleAvatar(
                        radius: 13,
                        backgroundImage: NetworkImage(context.read<UserProvider>().user!.image!.url)
                      ) ,
                    ) : 
                    const Icon(Icons.person)
                  ,
              ),
            ],
          ),
          drawerEnableOpenDragGesture: true,
          drawer: Drawer(
            backgroundColor: Theme.of(context).primaryColor,
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Users'),
                  onTap: () {
                    Navigator.pushNamed(context, UserScreen.routeName);
                  },
                ),
                ListTile(
                  title: const Text('Sign out'),
                  onTap: () {
                    Supabase.instance.client.auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, StarterScreen.routeName, (_) => false);
                  },
                )
              ],
            ),
          ),
          bottomNavigationBar: const TabItemsWidget(),
          body: TabBarView(
            children: [ 
              const TabContainerWidget(
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
      ),
    );
  }
}
