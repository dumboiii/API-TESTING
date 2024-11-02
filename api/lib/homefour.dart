import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
class HomeFour extends StatefulWidget {
  const HomeFour({super.key});

  @override
  State<HomeFour> createState() => HomeFourState();
}

class HomeFourState extends State<HomeFour> {
 
 
 var data;
  Future<void> getusers() async{
    final response= await https.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  

    if (response.statusCode==200){
       data= jsonDecode(response.body.toString());
    }
    else{
      return Future.error('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home FOUR'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: Column(

        children: [

          Expanded(child: 
          FutureBuilder(
            future: getusers(),
           builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }else{
              return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 8.0,
                
              child: Column(
                children: [
                 ResuableRow(title: 'Name', value: data![index]["name"].toString()),
                 ResuableRow(title: 'Username', value: data![index]["username"].toString()),
                 ResuableRow(title: 'Email', value:data![index]['email'].toString()),
                 ResuableRow(title: 'City', value: data![index]['address']!['city'].toString()),
                 ResuableRow(title: 'Street', value:data![index]['address']!['street'].toString()),
                ]
              ),
            );
          }
          );
            }
        
           })
          ),
                
        ],
      )),
    );
  }
}
class ResuableRow extends StatelessWidget {
final String value,title;
const ResuableRow({required this.title,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(title,style:const TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold
                       ),),
                    const   SizedBox(width: 10,),
                       Text(value,style:const TextStyle(
                        fontSize: 20,fontWeight: FontWeight.bold
                       ),),
                    ]
                   ),
    );
  }
}