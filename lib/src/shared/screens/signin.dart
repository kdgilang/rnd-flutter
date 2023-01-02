import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/constants/path.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  static const String id = "/signin";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.primary,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: const Signin()
      ),
    );
  }
}

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> with SingleTickerProviderStateMixin {

  bool isButtonsVisible = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward()
    .whenComplete(() {
      setState(() {
        isButtonsVisible = true;
      });
      // Navigator.pushReplacementNamed(context, HomeScreen.id);
    });

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -3.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linearToEaseOut,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SlideTransition(
          position: _offsetAnimation,
          child: Image.asset(
            "${PathConstants.iconsPath}/launch_icon.png",
            fit: BoxFit.contain,
            height: 80,
          ),
        ),
        ButtonsWidget(isVisible: isButtonsVisible)
      ],
    );
  }
}

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({ super.key, required this.isVisible });

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
        return  AnimatedOpacity(
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
              minimumSize: const Size(250, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              )
            ),
            onPressed: () {},
            child: const Text('Sign in'),
          ),
          const SizedBox(height: 20,),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(250, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              )
            ),
            onPressed: () {},
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}