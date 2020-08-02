import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'chatting';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: _buildBody(context)));
  }

  final sendMessageController = TextEditingController();

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('chatting').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return _buildList(context, snapshot.data.documents);
            },
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: sendMessageController,
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  sendMessage();
                  sendMessageController.clear();
                }),
          ],
        )
      ],
    );
  }

  final databaseReference = Firestore.instance;
  void sendMessage() async {
    print(sendMessageController);
    databaseReference
        .collection("chatting")
        .add({'name': '대훈', 'message': sendMessageController.text});
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Messages.fromSnapshot(data);

  return Container(
    key: ValueKey(record.name),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(record.message),
          trailing: Text(record.name),
        ),
      ],
    ),
  );
}

class Messages {
  final String name;
  final String message;
  final DocumentReference reference;

  Messages.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['message'] != null),
        name = map['name'],
        message = map['message'];

  Messages.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
