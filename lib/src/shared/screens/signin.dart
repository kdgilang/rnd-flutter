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
      appBar: AppBar(
        foregroundColor: ColorConstants.primary,
        shadowColor: Colors.transparent,
        backgroundColor: ColorConstants.grey,
        title: const Text("Sign in"),
        titleTextStyle: const TextStyle(
          color: ColorConstants.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
      body: Container(
        color: Colors.white,
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


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("You can find your member number on your statement or member card. By proceeding you agree to the Terms and Conditions, and Privacy Policy."),
          const SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Member number',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: ColorConstants.tertiary,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  child: const Text(
                    "Forgot your member number?"
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: ColorConstants.tertiary,
                    padding: EdgeInsets.zero,
                    textStyle: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  child: const Text(
                    "Forgot your member number?"
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstants.secondary,
              foregroundColor: ColorConstants.primary,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              minimumSize: const Size(280, 0),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              )
            ),
            onPressed: () {},
            child: const Text('Continue'),
          ),
          const SizedBox(height: 10,),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Can't find your member number?",
              style: TextStyle(
                color: ColorConstants.tertiary,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      )
    );
  }
}