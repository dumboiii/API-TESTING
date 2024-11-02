import 'dart:convert';

import 'package:api/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
class HomeThree extends StatefulWidget {
  const HomeThree({super.key});

  @override
  State<HomeThree> createState() => _HomeThreeState();
}

class _HomeThreeState extends State<HomeThree> {
  List <ModelUser> userlist=[];

  Future<List<ModelUser>> getusers() async{
    final response= await https.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data= jsonDecode(response.body.toString());

    if (response.statusCode ==200) {
      for (Map<String,dynamic>  item in data) {
          userlist.add(ModelUser.fromJson(item));
        
      }
      return userlist;
    }else{
      return Future.error('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: Column(

        children: [

          Expanded(child: 
          FutureBuilder(
            future: getusers(),
           builder: (context,AsyncSnapshot <List<ModelUser>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }else{
              return ListView.builder(
          itemCount: userlist.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 8.0,
                
              child: Column(
                children: [
                 ResuableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                 ResuableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                 ResuableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                 ResuableRow(title: 'City', value: snapshot.data![index].address!.city.toString()),
                 ResuableRow(title: 'Street', value: snapshot.data![index].address!.street.toString()),
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