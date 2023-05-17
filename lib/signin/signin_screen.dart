import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/validations/email_validation.dart';
import 'package:purala/validations/password_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  static const String routeName = "/signin";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Sign in"),
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
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
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  bool isBusy = false;
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();

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
              "assets/icons/purala-square-logo.png",
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 10,),
          Visibility(
            visible: isBusy,
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(color: ColorConstants.secondary, size: 20),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailControl,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Email address',
                    // floatingLabelStyle: TextStyle(color: Colors.white),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: EmailValidation.validateEmail,
                ),
                const SizedBox(height: 10,),
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
                  validator: PasswordValidation.validateRegisterPassword,
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
                const SizedBox(height: 20,),
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
                  onPressed: () async {

                    if (!_formKey.currentState!.validate() || isBusy) {
                      return;
                    }

                    setState(() {
                      isBusy = true;
                    });

                    try {
                      final AuthResponse res = await supabase.auth.signInWithPassword(
                        email: emailControl.text,
                        password: passwordControl.text,
                      );

                      final Session? session = res.session;
                      final User? user = res.user;

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
                      }
                    } on Exception catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(e.toString()),
                          );
                        },
                      );
                    } catch (e) {
                      debugPrint('Something really unknown: $e');
                    } finally {
                      setState(() {
                        isBusy = false;
                      });
                    }
                  },
                  child: const Text('Sign in'),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}