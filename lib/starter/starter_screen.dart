import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/constants/path_constants.dart';
import 'package:purala/signin/signin_screen.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  static const String routeName = "/starter";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

  bool isButtonsVisible = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  )..forward()
    .whenComplete(() {
      setState(() {
        isButtonsVisible = true;
      });
    });

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -1.5),
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
            "${PathConstants.iconsPath}/purala-square-logo.png",
            fit: BoxFit.contain,
            height: 120,
            width: 120,
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
              Navigator.pushNamed(context, SigninScreen.routeName);
            },
            child: const Text('Sign in'),
          ),
          // const SizedBox(height: 20,),
          // OutlinedButton(
          //   style: OutlinedButton.styleFrom(
          //     foregroundColor: Colors.white,
          //     side: const BorderSide(color: Colors.white, width: 1),
          //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
          //     minimumSize: const Size(280, 0),
          //     textStyle: const TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 18.0,
          //     )
          //   ),
          //   onPressed: () {},
          //   child: const Text('Register'),
          // ),
        ],
      ),
    );
  }
}