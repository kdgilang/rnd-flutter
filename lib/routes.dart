import 'package:flutter/material.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/signin/signin_screen.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (_) => const HomeScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
};