import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/shared/screens/home.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.primary,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: const StarterWidget()
      ),
    );
  }
}


class StarterWidget extends StatefulWidget {
  const StarterWidget({super.key});

  @override
  State<StarterWidget> createState() => _StarterWidgetState();
}

class _StarterWidgetState extends State<StarterWidget> with SingleTickerProviderStateMixin {
  
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward().whenComplete(() async  {
      await Future.delayed(const Duration(milliseconds: 1500));
      Navigator.pushReplacementNamed(context, HomeScreen.id);
  });

  late final Animation<double> _opacityAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -3.2),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SlideTransition(
      position: _offsetAnimation,
      child:  Image.asset(
        "assets/icons/launch_icon.png",
        fit: BoxFit.contain,
        height: 80,
      ),
    );
  }
}