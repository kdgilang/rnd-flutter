import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              color: Theme.of(context).primaryColor,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(children: const [
                  Text("tets")
                ]),
              )
            )
          )
      ]);
  }
}
