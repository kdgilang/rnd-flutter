import 'package:flutter/material.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/auth/reset_password_screen.dart';
import 'package:purala/auth/signin_screen.dart';
import 'package:purala/starter/starter_screen.dart';
import 'package:purala/user/add_user_screen.dart';
import 'package:purala/user/user_screen.dart';

var routes = <String, WidgetBuilder>{
  StarterScreen.routeName: (_) => const StarterScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
  ResetPasswordScreen.routeName: (_) => const ResetPasswordScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
  UserScreen.routeName: (_) => const UserScreen(),
  AddUserScreen.routeName: (_) => const AddUserScreen()
};