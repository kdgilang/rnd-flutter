import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/shared/widgets/tile_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Expanded(
            flex: 1,
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              color: Theme.of(context).primaryColor,
              child:  Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Search products by name or code.',
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0)
                    )
                  ),
                )
              )
            )
          ),
          const SizedBox(height: 10,),
          Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: const [
                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

                TileWidget(title: "coffee vanila latte", price: "Rp.20000")
              ]
            ),
          )
      ]);
  }
}


            //     CustomScrollView(
                  
            //   primary: true,
            //   slivers: <Widget>[
            //     SliverPadding(
            //       padding: const EdgeInsets.all(20),
            //       sliver: SliverGrid.count(
            //         crossAxisSpacing: 10,
            //         mainAxisSpacing: 10,
            //         crossAxisCount: 4,
            //         children: [
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),

            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //           TileWidget(title: "coffee vanila latte", price: "Rp.20000"),
            //         ]
            //       )
            //     )
            //   ]
            // )