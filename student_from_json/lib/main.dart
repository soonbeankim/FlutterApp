import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Future<List<String>> searchRepositories() async {
    final url = 'https://api.github.com/search/repositories?q=flutter';

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw ('Request failed with status: ${response.statusCode}.');
    }
    //응답 성공
    final jsonResponse = convert.jsonDecode(response.body);
    final items = jsonResponse['items'];

    // final result = <String>[];
    // for (var i = 0; i < items.length; i++) {
    //   result.add(items[i]['name']);
    // }

    //print('get data $result.');
    // final r = items.map((item) => item['name'] as String).toList();
    return List<String>.from(items.map((item) => item['name']).toList());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('get real data'),
            ),
            body: FutureBuilder<List<String>>(
                future: searchRepositories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //위에는 금방 쉬운거, 아래는 복잡한 처리
                    return CircularProgressIndicator();
                  }
                 return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          child: Center(child: Text(snapshot.data[index])),
                        );
                      });
                })));
  }
}