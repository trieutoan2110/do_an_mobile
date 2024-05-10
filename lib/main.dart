import 'package:do_an_mobile/providers/AuthProvider.dart';
import 'package:do_an_mobile/providers/cart_provider.dart';
import 'package:do_an_mobile/providers/checkout_provider.dart';
import 'package:do_an_mobile/providers/favorite_product_provider.dart';
import 'package:do_an_mobile/providers/home_provider.dart';
import 'package:do_an_mobile/providers/info_provider.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => InforProvider()),
      ChangeNotifierProvider(create: (context) => CheckOutProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteProvider())
    ],
    child: const MaterialApp (
      debugShowCheckedModeBanner: false,
      home: MainView()
    ),);
  }
}
