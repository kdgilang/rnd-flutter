import 'package:flutter/material.dart';
import 'package:purala/constants/color_constants.dart';
import 'package:purala/providers/merchant_provider.dart';
import 'package:purala/repositories/merchant_repository.dart';
import 'package:purala/starter/starter_screen.dart';
import 'package:purala/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_API_URL'] ?? "",
    anonKey: dotenv.env['SUPABASE_API_KEY'] ?? "",
  );

  final merchantRepository = MerchantRepository();
  var merchant = await merchantRepository.getOne(int.parse(dotenv.env['MERCHANT_ID'] ?? ""));
  MerchantProvider.set(merchant);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const MaterialColor primaryColor = MaterialColor(
    ColorConstants.primaryHex,
    <int, Color>{
      50: Color(0x0D002855),
      100: Color(0x26b3b3b3),
      200: Color(0x4D808080),
      300: Color(0x664d4d4d),
      400: Color(0x80262626),
      500: Color(0x99000000),
      600: Color(0xB3000000),
      700: Color(0xD9000000),
      800: Color(0xF2000000),
      900: ColorConstants.primary,
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Purala POS',
      restorationScopeId: "root",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColorLight: Colors.black12,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: Colors.grey, 
          displayColor: Colors.grey,
        ),
      ), // standard dark theme
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primaryColorLight: ColorConstants.grey,
        fontFamily: 'Effra',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: ColorConstants.primary, 
          displayColor: ColorConstants.primary, 
        ),
      ),
      home: const StarterScreen(),
      routes: routes,
    );
  }
}
