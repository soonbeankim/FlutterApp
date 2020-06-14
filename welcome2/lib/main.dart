import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//       theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My app'),
          backgroundColor: Colors.blueGrey[900] ,
        ),
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Center(
          child: Text(
            'Welcome2',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      RaisedButton(
        child: Text('RaisedButton', style: TextStyle(fontSize: 24)),
        color: darkBlue, onPressed: () {  },
      ),
    ], crossAxisAlignment: CrossAxisAlignment.end);
  }
}
