import 'package:flutter/material.dart';
import 'package:hostplus/src/shared/screens/home.dart';
import 'package:hostplus/src/shared/screens/signin.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.id: (_) => const HomeScreen(),
  SigninScreen.id: (_) => const SigninScreen(),
};