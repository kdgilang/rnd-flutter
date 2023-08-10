import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.title,
    required this.child,
    this.appBarActions,
  });

  final String title;
  final Widget child;
  final List<Widget>? appBarActions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(title),
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
        actions: appBarActions,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: child
      ),
    );
  }
}
