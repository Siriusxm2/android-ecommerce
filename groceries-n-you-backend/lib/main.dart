import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gny_backend/screens/new_product_page.dart';
import 'package:gny_backend/screens/products_page.dart';
import 'package:material_color_generator/material_color_generator.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Groceries 'N' You Backend",
      theme: ThemeData(
        primarySwatch: generateMaterialColor(
          color: const Color(0xff699BFF),
        ),
      ),
      getPages: [
        GetPage(name: '/allProducts', page: () => ProductsPage()),
        GetPage(name: '/allProducts/new', page: () => NewProductPage()),
      ],
      home: const HomeScreen(),
    );
  }
}
