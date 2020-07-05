import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class Repository {
  String name;
  String commitUrl;
}

class MyApp extends StatelessWidget {
  
  Future<List<Repository>> searchRepositories() async{

    final url = 'https://api.github.com/search/repositories?q=flutter';
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw ('Request failed with status: ${response.statusCode}.');
    }
    
    final jsonResponse = convert.jsonDecode(response.body);
    final items = jsonResponse['items'];
    
    return List<Repository>.from(items.map((item) { 
      // final myRepo = Repository();
      // myRepo.name = item['name'];
      // myRepo.commitUrl = item['commits_url'];
      // return myRepo;
      return Repository()
        ..name = item['name']
        ..commitUrl = item['commits_url'];
    }).toList());
    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('repositories'),
            ),
            body: FutureBuilder<List<Repository>>(
                future: searchRepositories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                 return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
      
                            title: Text(snapshot.data[index].name),
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                builder:(context)=> DetailScreen(snapshot.data[index].commitUrl) ));
                            },
                        );});
                      })));
  }
}
class DetailScreen extends StatelessWidget{
 final String commitsUrl;
  DetailScreen(this.commitsUrl);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('commits'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(commitsUrl),
      ),
    );
  }
}