import 'package:flutter/material.dart';
import 'package:purala/presentation/core/components/tile_widget.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
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
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Center(child: TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
                            textStyle: const TextStyle(
                            )
                          ),
                          onPressed: () {
                          },
                          child: const Text('pay'),
                        ));
                      },
                      separatorBuilder: (context, index) {
                        return const VerticalDivider();
                      },
                    ),
                  )
                ],
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
              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),
              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),
              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000"),

              TileWidget(title: "coffee vanila latte", subtitle: "Rp.20000")
            ]
          ),
        )
      ]
    );
  }
}