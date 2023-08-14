import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purala/data/features/merchant/data/models/merchant_model.dart';
import 'package:purala/dependencies.dart';
import 'package:purala/presentation/core/consts/color_constants.dart';
import 'package:purala/presentation/features/home/home_screen.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_bloc.dart';
import 'package:purala/presentation/features/merchant/bloc/merchant_state.dart';
import 'package:purala/presentation/features/signin/bloc/signin_bloc.dart';
import 'package:purala/presentation/features/signin/bloc/signin_event.dart';
import 'package:purala/presentation/features/signin/bloc/signin_state.dart';
import 'package:purala/presentation/features/reset-password/ui/reset_password_screen.dart';
import 'package:purala/presentation/core/validations/email_validation.dart';
import 'package:purala/presentation/core/validations/password_validation.dart';
import 'package:purala/presentation/core/components/image_widget.dart';
import 'package:purala/presentation/core/components/scaffold_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const String routeName = "/signin";
  
  final bool isButtonsVisible = false;

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWidget(
      title: "Sign in",
      child: SigninWidget()
    );
  }
}

class SigninWidget extends StatefulWidget {
  const SigninWidget({super.key});

  @override
  State<SigninWidget> createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  final _emailControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late MerchantModel? _merchant;
  late MerchantBloc _merchantBloc;
  late SigninBloc _signinBloc;
  bool _isBusy = false;

  @override
  void initState() {
    _merchantBloc = sl<MerchantBloc>();
    _signinBloc = sl<SigninBloc>();
    _merchant = _merchantBloc.state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<MerchantBloc>.value(
          value: _merchantBloc,
        ),
        BlocProvider<SigninBloc>.value(
          value: _signinBloc,
        ),
      ],
      child: BlocBuilder<MerchantBloc, MerchantState>(
        builder: (context, state) {
          return _formBuilder();
        },
      )
    );
  }

  Widget _formBuilder() {
    return  Container(
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
            child: ImageWidget(
              height: 100,
              width: 100,
              url: _merchant?.image?.url
            )
          ),
          const SizedBox(height: 10,),
          Visibility(
            visible: _isBusy,
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                size: 20,
                color: ColorConstants.secondary
              ),
            ),
          ),
          BlocListener<SigninBloc, SigninState>(
            listener: (context, state) {
               if (state is SigninDone) {
                setState(() {
                  _isBusy = false;
                });
               }
              if (state is SigninError) {
                setState(() {
                  _isBusy = false;
                });

                showDialog(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 400,
                          child: AlertDialog(
                      content: Text(state.error?.message ?? ''),
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
              }

              if (state is SigninDone) {
                // context.read<UserProvider>().set(user);
                // context.read<SessionProvider>().set(res.session);
                Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (_) => false);
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailControl,
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
                    controller: _passwordControl,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                      // floatingLabelStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, width: 1.0
                        )
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
          ),
        ],
      )
    );
  }

  Future<void> _onSingin () async {
    if (!_formKey.currentState!.validate() || _isBusy) {
      return;
    }

    setState(() {
      _isBusy = true;
    });

    _signinBloc.add(Auth(
      identifier: _emailControl.text,
      password: _passwordControl.text
    ));

      //     final user = await userRepo.getBySsoId(res.user!.id);

      // if(!user.confirmed || user.blocked) {
      //   throw Exception("Unable to login, please contact our support.");
      // }
      
      // final int merchantId = int.parse(dotenv.env['MERCHANT_ID'] ?? "");

      // if (user.merchantId != merchantId) {
      //   throw Exception("User unable to login, please contact our support.");
      // }
  }

  @override
  void dispose() {
    _emailControl.dispose();
    _emailControl.dispose();
    super.dispose();
  }
}