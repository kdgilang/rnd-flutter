import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purala/presentations/features/category/category_screen.dart';
import 'package:purala/presentations/core/consts/color_constants.dart';
import 'package:purala/presentations/features/product/product_screen.dart';
import 'package:purala/providers/user_provider.dart';
import 'package:purala/presentations/features/starter/ui/starter_screen.dart';
import 'package:purala/presentations/features/stock/stock_screen.dart';
import 'package:purala/presentations/features/supplier/supplier_screen.dart';
import 'package:purala/presentations/features/user/user_screen.dart';
import 'package:purala/presentations/core/components/charts/line_chart_widget.dart';
import 'package:purala/presentations/core/components/charts/pie_chart_widget.dart';
import 'package:purala/presentations/features/home/widgets/tab_container_widget.dart';
import 'package:purala/presentations/features/home/widgets/tab_items_widget.dart';
import 'package:purala/presentations/features/pos/pos_widget.dart';
import 'package:purala/presentations/core/components/layouts/authenticated_layout.dart';
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
            child: Column(children: [
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Users'),
                      onTap: () {
                        Navigator.pushNamed(context, UserScreen.routeName);
                      },
                    ), 
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Categories'),
                      onTap: () {
                        Navigator.pushNamed(context, CategoryScreen.routeName);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.pages),
                      title: const Text('Products'),
                      onTap: () {
                        Navigator.pushNamed(context, ProductScreen.routeName);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.factory),
                      title: const Text('Suppliers'),
                      onTap: () {
                        Navigator.pushNamed(context, SupplierScreen.routeName);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.inventory),
                      title: const Text('Stocks'),
                      onTap: () {
                        Navigator.pushNamed(context, StockScreen.routeName);
                      },
                    ),
                    const Divider(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sign out'),
                      onTap: () {
                        Supabase.instance.client.auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(context, StarterScreen.routeName, (_) => false);
                      },
                    ),
                  ],
                )
              )
            ],)
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
