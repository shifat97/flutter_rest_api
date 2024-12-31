import 'package:flutter/material.dart';
import 'package:flutter_rest_api/views/product_create_screen.dart';
import 'package:flutter_rest_api/views/product_screen.dart';
// import 'package:flutter_rest_api/views/product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        home: ProductScreen(),
      ),
    );
  }
}
