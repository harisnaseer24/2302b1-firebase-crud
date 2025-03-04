import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/addproducts.dart';
import 'package:firebase_crud/auth.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
final SharedPreferences prefs = await SharedPreferences.getInstance();
bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
bool isAdmin = prefs.getBool("isAdmin") ?? false;
print(isLoggedIn);


  runApp(MyApp(isLoggedIn:isLoggedIn,isAdmin:isAdmin));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isAdmin;

  const MyApp({super.key,required this.isLoggedIn, required this.isAdmin});

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
      home: Login(),
      routes: {
        '/signup':(context)=>Signup(),
       
        '/products':(context)=>isLoggedIn ? MyProductsPage() : Login(),
        '/add':(context)=>(isLoggedIn && isAdmin) ? AddProductPage() : Login(),
      },
    );
  }
}

