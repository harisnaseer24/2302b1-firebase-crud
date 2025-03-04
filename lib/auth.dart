import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController usernameController= TextEditingController();

  var users= FirebaseFirestore.instance.collection("users");

   signup() async{
    try {
      print('hi');
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text,
  );
  // print(credential.user.)
 await users.add({
"email":emailController.text,
"password":passwordController.text,
"username":usernameController.text,
"id":credential.user?.uid,
"role":"user",
});
  print("user created successfully");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registeration success"),)) ;
  Navigator.pushNamed(context,'/');

} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak."),)) ;
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email."),)) ;
  Navigator.pushNamed(context,'/');
    
  } 
} catch (e) {
  print(e);
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create an account"),),
      body: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
               SizedBox(height: 20,),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                label: Text("Enter your Username"),
                hintText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Enter your Email"),
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
              SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text("Enter your password"),
                hintText: "Password",
                border: OutlineInputBorder(),
              ),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                signup();
              }, child: Text("Signup")),
               GestureDetector(
                onTap: (){
                   Navigator.pushNamed(context,'/');
                },
                child: Center(child: Text("Already a user..? Login now..!",)),
              ),
            
          ],
        ),
      )
      ,
    );
  }
}


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

login()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
  var user=await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: emailController.text).get();
  String username=user.docs[0].data()["username"];

  if(user.docs[0].data()['role']=="admin"){
    prefs.setBool("isAdmin",true);
      prefs.setBool("isLoggedIn",true);
  prefs.setString("email", emailController.text);
  prefs.setString("username", username);
  prefs.setString("id", credential.user?.uid ?? "");
 

  print("admin logged in");
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signed in as ${emailController.text}"),)) ;
  Navigator.pushNamed(context,'/add');
  }else{
    prefs.setBool("isAdmin",false);
      prefs.setBool("isLoggedIn",true);
  prefs.setString("email", emailController.text);
  prefs.setString("username", username);
  prefs.setString("id", credential.user?.uid ?? "");
 

  print("user session is created");
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signed in as ${emailController.text}"),)) ;
  Navigator.pushNamed(context,'/products');

  }
  // print(user.docs[0].data()["username"]);


} on FirebaseAuthException catch (e) {

   prefs.setBool("isLoggedIn",false);
   print("user unset");
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that email."),)) ;
  Navigator.pushNamed(context,'/');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong password provided for that user."),)) ;

  }
}
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Login to your account"),),
      body: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
               SizedBox(height: 20,),

           
          
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Enter your Email"),
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
              SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                label: Text("Enter your password"),
                hintText: "Password",
                border: OutlineInputBorder(),
              ),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                login();
              }, child: Text("Login")),
              GestureDetector(
                onTap: (){
                   Navigator.pushNamed(context,'/signup');
                },
                child: Text("Not a user..? Register now..!",),
              ),
            
          ],
        ),
      )
      ,
    );;
  }
}