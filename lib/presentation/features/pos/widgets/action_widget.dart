import 'package:flutter/material.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.black12,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Cash...',
                floatingLabelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0)
                )
              ),
            )
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.secondary,
                        foregroundColor: ColorConstants.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        )
                      ),
                      onPressed: () {
                      },
                      child: const Text('Draft'),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child:  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: ColorConstants.white,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        )
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              // Retrieve the text that the user has entered by using the
                              // TextEditingController.
                              content: Text("Test"),
                            );
                          },
                        );
                      },
                      child: const Text('pay'),
                    )
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
