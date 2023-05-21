import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/constants/path_constants.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/providers/user_provider.dart';
import 'package:purala/screens/reset_password_screen.dart';
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
  bool isBusy = false;
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();
  final supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  final merchant = MerchantProvider.get();

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
            child: merchant?.media?.url != null ? Image.network(
              merchant?.media?.url ?? "",
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            ) : Image.asset(
              "${PathConstants.iconsPath}/purala-square-logo.png",
              fit: BoxFit.contain,
              height: 120,
              width: 120,
            )
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
                    onPressed: () {
                      Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                    },
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
                  onPressed: _onSingin,
                  child: const Text('Sign in'),
                ),
              ],
            )
          ),
        ],
      )
    );
  }

  Future<void> _onSingin () async {
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

      UserProvider.setAuth(res.user, res.session);

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
      debugPrint('unknown error: $e');
    } finally {
      setState(() {
        isBusy = false;
      });
    }
  }
}