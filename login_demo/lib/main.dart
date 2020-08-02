import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Sign in';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: SignInWidget(),
      ),
    );
  }
}

class SignInWidget extends StatefulWidget {
  SignInWidget({Key key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Enter your ID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: pwController,
              decoration: const InputDecoration(
                hintText: 'Enter your PW',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: RaisedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text(
                      'ID:' + idController.text + ', PW:' + pwController.text),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                );
                Scaffold.of(context).showSnackBar(snackBar);
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
