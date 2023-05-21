import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/constants/path_constants.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/signin/signin_screen.dart';
import 'package:purala/validations/email_validation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static const String routeName = "/reset-password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).textTheme.bodyLarge!.color,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Reset password"),
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
        child: const ResetPasswordWidget()
      ),
    );
  }
}

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({super.key});

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  bool isBusy = false;
  final emailControl = TextEditingController();
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
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0)
                    )
                  ),
                  validator: EmailValidation.validateEmail,
                ),
                const SizedBox(height: 40,),
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
                  onPressed: _onSendEmail,
                  child: const Text('Send email'),
                ),
              ],
            )
          ),
        ],
      )
    );
  }

  Future<void> _onSendEmail() async {
    if (!_formKey.currentState!.validate() || isBusy) {
      return;
    }

    setState(() {
      isBusy = true;
    });

    try {
     final test = await supabase.auth.resetPasswordForEmail(emailControl.text);

      if(context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Reset link sent, please check your email."),
                  const SizedBox(height: 20,),
                  TextButton(onPressed: () { 
                    Navigator.pop(context, SigninScreen.routeName);
                  }, child: const Text("ok"))
                ],
              ),
            );
          },
        );
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