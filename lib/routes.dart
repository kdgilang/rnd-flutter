import 'package:flutter/material.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/signin/signin_screen.dart';
import 'package:purala/starter/starter_screen.dart';

var routes = <String, WidgetBuilder>{
  StarterScreen.routeName: (_) => const StarterScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
};