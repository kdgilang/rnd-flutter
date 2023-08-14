import 'package:flutter/material.dart';
import 'package:purala/presentation/features/category/category_screen.dart';
import 'package:purala/presentation/features/home/home_screen.dart';
import 'package:purala/presentation/features/reset-password/ui/reset_password_screen.dart';
import 'package:purala/presentation/features/signin/ui/signin_screen.dart';
import 'package:purala/presentation/features/product/product_form_screen.dart';
import 'package:purala/presentation/features/product/product_screen.dart';
import 'package:purala/presentation/features/starter/ui/starter_screen.dart';
import 'package:purala/presentation/features/stock/stock_screen.dart';
import 'package:purala/presentation/features/supplier/supplier_form_screen.dart';
import 'package:purala/presentation/features/supplier/supplier_screen.dart';
import 'package:purala/presentation/features/user/user_form_screen.dart';
import 'package:purala/presentation/features/user/user_screen.dart';

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