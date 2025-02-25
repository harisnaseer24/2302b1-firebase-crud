import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  CollectionReference products= FirebaseFirestore.instance.collection('products');
  _deleteProduct(String productId)async{
    try{

await products.doc(productId).delete();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product deleted"),));

    }catch(e){
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can't delete product right now..!"),));
  }
  }
 void _editProduct(String id,String title,String description,double price,String image)
{
  TextEditingController titlecontroller =TextEditingController(text:title);
  TextEditingController descontroller =TextEditingController(text:description);
  TextEditingController pricecontroller =TextEditingController(text:price.toString());
  TextEditingController imagecontroller =TextEditingController(text:image);

  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Editing $title"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titlecontroller,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: descontroller,
            decoration: InputDecoration(labelText: "Description"),
          ),
          TextField(
            controller: pricecontroller,
            decoration: InputDecoration(labelText: "Price"),
          ),
          TextField(
            controller: imagecontroller,
            decoration: InputDecoration(labelText: "Image"),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: ()async{
          try{
            await products.doc(id).update({
              'title':titlecontroller.text,
              'description':descontroller.text,
              'price':double.parse(pricecontroller.text),
              'image':imagecontroller.text,
            });
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product updated"),));
          }catch(e){
            print(e);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Can't update product right now..!"),));
          }
        }, child: Text("Update")),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel")),
      ],
    );
  });

}



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context,"/add");
            }),
             IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("isLoggedIn",false);
              prefs.remove("email");
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
            }),
        ],
      ),

      body: 
      Center(
        child: StreamBuilder(stream: products.snapshots(), builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.active) {
           if (snapshot.hasData) {
             return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

              var product=snapshot.data!.docs[index];

                return ListTile(
                  title: Text(snapshot.data!.docs[index]['title']),
                  subtitle: Text(snapshot.data!.docs[index]['description']),
                  leading: CircleAvatar(
                    child: Image.network(snapshot.data!.docs[index]['image'],height: 40,),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text(snapshot.data!.docs[index]['price'].toString()),
                    IconButton(onPressed:  (){
                       _editProduct(product.id, product['title'], product['description'],product['price'],product['image']);
                    } ,icon: Icon(Icons.edit,color: Colors.blue,)),
                 
                 
                  IconButton(onPressed: (){
                      _deleteProduct(snapshot.data!.docs[index].id);
                    }, icon: Icon(Icons.delete,color: Colors.red,),)
                  ],),
                );
              },

             );
           } else {
             return Text("No data");
           }
           
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}