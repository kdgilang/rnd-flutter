import 'package:flutter/material.dart';
import 'package:hostplus/src/shared/screens/home.dart';
import 'package:hostplus/src/shared/screens/signin.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (_) => const HomeScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
};