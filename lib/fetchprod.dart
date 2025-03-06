import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductAPI extends StatefulWidget {
  const ProductAPI({super.key});
  @override
  State<ProductAPI> createState() => _ProductAPIState();
}

class _ProductAPIState extends State<ProductAPI> {
getProducts()async{
  var url=Uri.parse('https://dummyjson.com/products');
  var response=await http.get(url);
  // print(response.body);
  return jsonDecode(response.body);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
        title: Text("Products from API"),
      ),
   body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Ensuring the data is correctly cast to a Map<String, dynamic>
              var data = snapshot.data as Map<String, dynamic>;
              var products = data['products'] as List<dynamic>;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return ListTile(
                    title: Text(product['title'].toString()),
                    subtitle: Text(product['price'].toString()),
                    leading: Image.network(product['images'][0]),
                  );
                },
              );
            } else {
              return Center(child: Text("No data available"));
            }
          },
        ),
      ),

    );
  }
}