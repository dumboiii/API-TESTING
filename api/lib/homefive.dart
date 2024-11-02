import 'dart:convert';

import 'package:api/models/productmodels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductModels extends StatefulWidget {
  const ProductModels({super.key});

  @override
  State<ProductModels> createState() => _ProductModelsState();
}

class _ProductModelsState extends State<ProductModels> {
 
 Future<List<ProductModel>>  getProducts() async {
  final response = await http.get(Uri.parse('https://webhook.site/490cf816-c437-4b84-b9a0-911dec653282'));
   var data= jsonDecode(response.body.toString());

   if (response.statusCode==200) {
      return List<ProductModel>.from(data.map((item) => ProductModel.fromJson(item)));
   }else{
     throw Exception('Failed to load products');
   }
 }

 
 
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home FOUR'),
        backgroundColor: Colors.deepPurple,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: FutureBuilder<List<ProductModel>>(future: getProducts(), builder:(context,snapshot){
            if (snapshot.hasData) {
              return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
                  return Column(
                    children: [
                      Text(index.toString())
                    ]
                  );
              },
            );
            } else {
              return const Center(child: CircularProgressIndicator());
              
            }
            
            
            
          } ))
        ],
        
        
        )
      )
      );
  }
  }
