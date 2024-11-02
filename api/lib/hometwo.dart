import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeTwo extends StatefulWidget {
  const HomeTwo({super.key});

  @override
  State<HomeTwo> createState() => _HomeTwoState();
}

class _HomeTwoState extends State<HomeTwo> {
 
List <Photos> photoslist = [];
Future<List<Photos>> getPhotos() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var jsonData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (Map <String, dynamic> i in jsonData) {
      int id = i['id'] != null ? i['id'] : 0; 
      Photos photos=Photos(url: i['url'], title: i['title'],id: id);
      photoslist.add(photos);
    }
    return  photoslist;
  }
  
  else
  {
    return  photoslist;
  }
}


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title:const Text('Home Two',style: TextStyle(
          fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Expanded(
                child: FutureBuilder(future: getPhotos(), builder: (context,AsyncSnapshot  <List <Photos>>  snapshot)
                {
                  return ListView.builder(
                    itemCount: photoslist.length,
                    itemBuilder: ((context, index) {
                    return  ListTile(
                      leading: CircleAvatar(
                          onBackgroundImageError: (error, stackTrace) {
      // Optional: You can log or handle the error if needed
                                                  },
                                   child: Icon(Icons.error),
                        backgroundImage:NetworkImage (snapshot.data![index].url.toString()
                        
                        ),
                    
                      
                      ),
                      subtitle:Text(snapshot.data![index].id.toString() ) ,
                      title:Text(snapshot.data![index].title.toString() ),
                    );
                  }
                  )
                
                  );
                }
                ),
              )
          ],
        ),
      ),
    );
  }
}

class Photos{
 String url , title ;
 int id;
 Photos({required this.url,required this.title,required this.id});
}