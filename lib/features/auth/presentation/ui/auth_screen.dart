import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:purala/core/consts/color_constants.dart';
import 'package:purala/core/consts/path_constants.dart';
import 'package:purala/features/home/home_screen.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/providers/session_provider.dart';
import 'package:purala/providers/user_provider.dart';
import 'package:purala/features/auth/presentation/ui/reset_password_screen.dart';
import 'package:purala/repositories/user_repository.dart';
import 'package:purala/core/validations/email_validation.dart';
import 'package:purala/core/validations/password_validation.dart';
import 'package:purala/core/components/image_widget.dart';
import 'package:purala/core/components/scaffold_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String routeName = "/signin";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      title: "Sign in",
      child: SigninWidget(),
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

  @override
  Widget build(BuildContext context) {
    
    final merchant = context.read<MerchantProvider>().merchant;
    
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
            child: ImageWidget(url: merchant?.media?.url ?? "${PathConstants.iconsPath}/purala-square-logo.png")
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
      
      final userRepo = UserRepository();

      final user = await userRepo.getBySsoId(res.user!.id);

      if(!user.confirmed || user.blocked) {
        throw Exception("Unable to login, please contact our support.");
      }
      
      final int merchantId = int.parse(dotenv.env['MERCHANT_ID'] ?? "");

      if (user.merchantId != merchantId) {
        throw Exception("User unable to login, please contact our support.");
      }

      if (context.mounted) {
        context.read<UserProvider>().set(user);
        context.read<SessionProvider>().set(res.session);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400,
                child: AlertDialog(
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                child: const Text("ok")
              )
            ],
          ),
              )
            ],
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