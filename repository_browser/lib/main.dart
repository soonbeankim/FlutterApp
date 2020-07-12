import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<List<Repository>> searchRepositories() async {
    final url = 'https://api.github.com/search/repositories?q=flutter';
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw ('Request failed with status: ${response.statusCode}.');
    }

    final jsonResponse = convert.jsonDecode(response.body);
    final items = jsonResponse['items'];

    return List<Repository>.from(items.map((item) {
    
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
                    return Center(child: CircularProgressIndicator()); 
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        snapshot.data[index].commitUrl)));
                          },
                        );
                      });
                })));
  }
}

class DetailScreen extends StatelessWidget {
  final String commitsUrl;
  DetailScreen(this.commitsUrl);

  Future <List<String>> searchCommitsMessage() async {
    print(' start !!! ${commitsUrl}');
    final url = commitsUrl.substring(0, commitsUrl.indexOf('{'));
    print(url);
    //String result = s.substring(0, s.indexOf('.'));
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw ('Request failed with status: ${response.statusCode}.');
    }
    final jsonResponse = convert.jsonDecode(response.body);
    return List<String>.from(jsonResponse.map((item)=> item['commit']['message']).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('commits'),
        ),
        body: FutureBuilder<List<String>>(
          future: searchCommitsMessage(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator()); 
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(
                      child: Text(snapshot.data[index]),
                    ),
                  );
                });
          },
        ));
  }
}
