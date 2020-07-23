import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Stream<String> getWeather() async* {
    var weather = "";
    await Future.delayed(Duration(seconds: 3));
    weather = "Sunny";
    yield weather;
    await Future.delayed(Duration(seconds: 3));
    weather = "Cloudy";
    yield weather;
    await Future.delayed(Duration(seconds: 3));
     weather = "Rainy";
    yield weather;
  }


  @override
  Widget build(BuildContext context) {
    // final showWeather = getWeather().listen((event) { });
    // print(showWeather.runtimeType);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Forecast'),
        ),
        body: StreamBuilder<String>(
          stream: getWeather(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child:CircularProgressIndicator());
            }
            return Center(
              child: Text(snapshot.data,
              style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),)); 
          },),
      ),
    );
  }
}