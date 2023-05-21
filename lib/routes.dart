import 'package:flutter/material.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/screens/reset_password_screen.dart';
import 'package:purala/signin/signin_screen.dart';
import 'package:purala/starter/starter_screen.dart';

var routes = <String, WidgetBuilder>{
  StarterScreen.routeName: (_) => const StarterScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
  ResetPasswordScreen.routeName: (_) => const ResetPasswordScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
};