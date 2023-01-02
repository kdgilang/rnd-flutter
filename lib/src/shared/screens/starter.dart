import 'package:flutter/material.dart';
import 'package:hostplus/src/constants/Color.dart';
import 'package:hostplus/src/constants/path.dart';
import 'package:hostplus/src/shared/screens/signin.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});
  
  final bool isButtonsVisible = false;

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
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )
            ),
            onPressed: () {
              Navigator.pushNamed(context, SigninScreen.id);
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
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}