import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/home/home_screen.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  static const String routeName = "/signin";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).textTheme.bodyText1!.color,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Sign in"),
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: const SigninWidget()
      ),
    );
  }
}

class SigninWidget extends StatefulWidget {
  const SigninWidget({super.key});

  @override
  State<SigninWidget> createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  final memberControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/icons/launch_icon.png",
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: memberControl,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Email address',
                  // floatingLabelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                  )
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Email address is required.';
                  }
                  return null;
                },
              )
            ],
          ),
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: passwordControl,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Password',
                  // floatingLabelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                  )
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
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
                    "Forgot your password?"
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
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
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       // Retrieve the text that the user has entered by using the
              //       // TextEditingController.
              //       content: Text(memberControl.text),
              //     );
              //   },
              // );
              if (passwordControl.text == memberControl.text) {
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
              }
            },
            child: const Text('Sign in'),
          ),
          // const SizedBox(height: 10,),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     "Can't find your member number?",
          //     style: TextStyle(
          //       color: ColorConstants.tertiary,
          //       decoration: TextDecoration.underline,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12.0,
          //     ),
          //   ),
          // ),
        ],
      )
    );
  }
}