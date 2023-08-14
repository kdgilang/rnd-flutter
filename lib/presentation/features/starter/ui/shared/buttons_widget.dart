import 'package:flutter/material.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';
import 'package:purala/presentation/features/signin/ui/auth_screen.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({ super.key, required this.isVisible });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.secondary,
              foregroundColor: ColorConstants.primary,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            ),
            onPressed: () {
              Navigator.pushNamed(context, AuthScreen.routeName);
            },
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 20,),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            ),
            onPressed: () {},
            child: const Text('Add User'),
          ),
        ],
      ),
    );
  }
}