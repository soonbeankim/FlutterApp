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
    return Column(
  children: <Widget>[
    Expanded(
              child: Text(''),
            ),
Expanded(
              child: Text('Welcome',style:TextStyle(fontSize:24)),
            ),
 
RaisedButton(
                        child: Text('RaisedButton', style: TextStyle(fontSize: 24)),
                   
                    ),


  ],
);
  }
}
