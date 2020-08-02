import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final sendMessageController = TextEditingController();
   final databaseReference = Firestore.instance;
  static const String _title = 'chatting';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(title: const Text(_title)),
            body: _buildBody(context)));
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('chatting').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return _buildList(context, snapshot.data.documents);
              //snapshot.data = QuerySnapshot
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

 
  void sendMessage(){
    databaseReference
        .collection("chatting")
        .add({'name': 'alex', 'message': sendMessageController.text, 'time': DateTime.now()});
  }
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView.builder(
    itemCount: snapshot.length,
    itemBuilder: (BuildContext ctxt, int index) {
    //  return Text(snapshot[index].data.toString());
    final record = Messages.fromSnapshot(snapshot[index]);

    return Container(
      child: ListTile(
        title: Text(record.message) ,
        subtitle: Text(record.time),
        trailing: Text(record.name),
      )
    );
    }
  );
}

// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//   return ListView(
//     padding: const EdgeInsets.only(top: 20.0),
//     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//   );
// }

// Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//   final record = Messages.fromSnapshot(data);

//   return Container(
//     key: ValueKey(data['name']),
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     child: 
//         ListTile(
//           title: Text(record.message),
//           trailing: Text(record.name),
//         ),
//   );
// }

class Messages {
  final String name;
  final String message;
  final String time;
  final DocumentReference reference;

  Messages.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['message'] != null),
        assert(map['time'] != null),
        name = map['name'],
        message = map['message'],
        time = map['time'].toDate().toString();

  Messages.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
