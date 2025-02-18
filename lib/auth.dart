import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
});
  print("user created successfully");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registeration success"),)) ;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The password provided is too weak."),)) ;
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The account already exists for that email."),)) ;
    
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
              }, child: Text("Signup"))
            
          ],
        ),
      )
      ,
    );
  }
}