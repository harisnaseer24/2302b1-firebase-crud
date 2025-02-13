import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
   CollectionReference products= FirebaseFirestore.instance.collection('products');
  TextEditingController titleController=TextEditingController();
  TextEditingController desController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController imageController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Add new product"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context,"/add");
            }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: ListView(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter the title of the product",
                ),
              ),
              TextField(
                controller: desController,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter the description of the product",
                ),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Enter the price of the product",
                ),
              ),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                  labelText: "Image URL",
                  hintText: "Enter the image URL of the product",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add the product to the database

                  products.add({
                    'title':titleController.text,
                    'description':desController.text,
                    'price':double.parse(priceController.text),
                    'image':imageController.text,

                    
                  }).then((value) => {
                    titleController.clear(),
                    desController.clear(),
                    priceController.clear(),
                    imageController.clear(),
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added successfully"),)) ,

                    Navigator.pop(context),
                  }).catchError((error) => {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add product"),))
                  });
                },
                child: Text("Add product"),
              ),
            ],
          ),
        ),
      )
      ,
    );
  }
}