import 'package:flutter/material.dart';
import 'package:hostplus/home/home_screen.dart';
import 'package:hostplus/signin/signin_screen.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (_) => const HomeScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
};