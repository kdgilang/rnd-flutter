import 'package:flutter/material.dart';
import 'package:purala/category/category_screen.dart';
import 'package:purala/home/home_screen.dart';
import 'package:purala/auth/reset_password_screen.dart';
import 'package:purala/auth/signin_screen.dart';
import 'package:purala/product/product_form_screen.dart';
import 'package:purala/product/product_screen.dart';
import 'package:purala/starter/starter_screen.dart';
import 'package:purala/stock/stock_screen.dart';
import 'package:purala/supplier/supplier_form_screen.dart';
import 'package:purala/supplier/supplier_screen.dart';
import 'package:purala/user/user_form_screen.dart';
import 'package:purala/user/user_screen.dart';

var routes = <String, WidgetBuilder>{
  StarterScreen.routeName: (_) => const StarterScreen(),
  SigninScreen.routeName: (_) => const SigninScreen(),
  ResetPasswordScreen.routeName: (_) => const ResetPasswordScreen(),
  HomeScreen.routeName: (_) => const HomeScreen(),
  UserScreen.routeName: (_) => const UserScreen(),
  UserFormScreen.routeName: (_) => const UserFormScreen(),
  ProductScreen.routeName: (_) => const ProductScreen(),
  ProductFormScreen.routeName: (_) => const ProductFormScreen(),
  StockScreen.routeName: (_) => const StockScreen(),
  SupplierScreen.routeName: (_) => const SupplierScreen(),
  SupplierFormScreen.routeName: (_) => const SupplierFormScreen(),
  CategoryScreen.routeName: (_) => const CategoryScreen()
};