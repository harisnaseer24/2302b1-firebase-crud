import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/addproducts.dart';
import 'package:firebase_crud/auth.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/products.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
    
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Signup(),
      routes: {
        '/products':(context)=>MyProductsPage(),
        '/add':(context)=>AddProductPage(),
      },
    );
  }
}

