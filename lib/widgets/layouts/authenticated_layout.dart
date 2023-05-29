import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/providers/session_provider.dart';
import 'package:purala/starter/starter_screen.dart';

class AuthenticatedLayout extends StatelessWidget {
  const AuthenticatedLayout({super.key, required this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.read<SessionProvider>().isValidToken()) {
      return child;
    } else {
      return AlertDialog(
        content: Column(
          children: [
            const Text("Session expired, please login again."),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.secondary,
                foregroundColor: ColorConstants.primary,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                minimumSize: const Size(250, 0),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                )
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, StarterScreen.routeName, (_) => false);
              },
              child: const Text("ok"),
            )
          ],
        ),
      );
    }
  }
}
