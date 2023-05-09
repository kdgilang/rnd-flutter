import 'package:flutter/material.dart';
import 'package:purala/shared/widgets/stepper_widget.dart';
import 'package:purala/shared/widgets/tile_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 3,
        child: StepperWidget(initialValue: 0, onChanged: (val) {},),
        // child: QRViewExample(),
      ),
      const SizedBox(width: 20,),
      Expanded(
        flex: 7,
        child: Column(
        children: [
            Expanded(
              flex: 2,
              child: Material(
                elevation: 4,
                shadowColor: Colors.black12,
                color: Theme.of(context).primaryColor,
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search products by name or code.',
                      floatingLabelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
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
                shrinkWrap: true,
                childAspectRatio: 2.8,
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
          ]
        )
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