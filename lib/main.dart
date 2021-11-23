import 'package:firebase/pages/add_product_page.dart';
import 'package:firebase/pages/products_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.INITIAL,
      routes: {
        Routes.INITIAL: (_) => ProductsPage(),
        Routes.ADD_PRODUCT: (_) => AddProductPage(),
      },
    );
  }
}
