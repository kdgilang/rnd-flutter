import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:purala/providers/session_provider.dart';
import 'package:purala/starter/starter_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticatedLayout extends StatelessWidget {
  const AuthenticatedLayout({super.key, required this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (context.read<SessionProvider>().isValidToken()) {
      return child;
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            child: AlertDialog(
              content: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Session expired", style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 20,),
                  Text("please login again.", style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Supabase.instance.client.auth.refreshSession();
                    // Supabase.instance.client.auth.signOut();
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    Navigator.pushNamedAndRemoveUntil(context, StarterScreen.routeName, (_) => false);
                  },
                  child: const Text("ok")
                )
              ],
            ),
          ),
        ],
      );
    }
  }
}
