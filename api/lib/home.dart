import 'dart:convert';

import 'package:api/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List <PostManApi> post=[]; //yh issliye kiye h kyuki yh wale api me ek array tha pura aur woh bina  nm ka tha

  Future<List<PostManApi>>  getPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
           post.clear();
    for (Map <String, dynamic> i in data) {
 
      post.add(PostManApi.fromJson(i));
    }
    return post;
    } else {
      throw Exception('Failed to load posts');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text("API's",style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(future: getPosts(), builder: (context,snapshot){
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView.builder(
                        itemCount: post.length,
                        itemBuilder: (context,index)
                      {
                        return 
                             Padding(
                               padding: const EdgeInsets.all(8),
                               child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       
                                       Text('Title \n'+post[index].title.toString()),
                                       Text('Body \n'+post[index].body.toString()),
                                    ]
                                  ),
                                ),
                               ),
                             );
                        
                      }
                      );
                    }
              }),
            ),
          ],
        ),
      )
    );
  }
}