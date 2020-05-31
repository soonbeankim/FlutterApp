import 'package:flutter/material.dart';

final List<int> students = <int>[for(var i=1; i<=100; i+=1) i];
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Students List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        
        body: ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: students.length,
  itemBuilder: (BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Center(child: Text('Student ${students[index]}')),
    );
  }
),
      ),
    );
  }
}