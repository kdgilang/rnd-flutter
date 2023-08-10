import 'package:flutter/material.dart';
import 'package:purala/presentations/features/category/category_screen.dart';
import 'package:purala/presentations/features/home/home_screen.dart';
import 'package:purala/presentations/features/reset-password/ui/reset_password_screen.dart';
import 'package:purala/presentations/features/signin/ui/auth_screen.dart';
import 'package:purala/presentations/features/product/product_form_screen.dart';
import 'package:purala/presentations/features/product/product_screen.dart';
import 'package:purala/presentations/features/starter/ui/starter_screen.dart';
import 'package:purala/presentations/features/stock/stock_screen.dart';
import 'package:purala/presentations/features/supplier/supplier_form_screen.dart';
import 'package:purala/presentations/features/supplier/supplier_screen.dart';
import 'package:purala/presentations/features/user/user_form_screen.dart';
import 'package:purala/presentations/features/user/user_screen.dart';

var routes = <String, WidgetBuilder>{
  StarterScreen.routeName: (_) => const StarterScreen(),
  AuthScreen.routeName: (_) => const AuthScreen(),
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