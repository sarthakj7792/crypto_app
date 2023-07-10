import 'package:crypto_app/dependency_injection.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

Future<void> main() async {
  Injector.configure(Flavor.PROD);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
    );
  }
}
