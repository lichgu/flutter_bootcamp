import 'package:cloud_firestore/cloud_firestore.dart';

class Dao {
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessagesStream() {
    return FirebaseFirestore.instance
        .collection('messages')
        .orderBy('ts', descending: true)
        .snapshots();
  }

  void addMessage(String text, String sender) {
    FirebaseFirestore.instance.collection('messages').add({
      'text': text,
      'sender': sender,
      'ts': Timestamp.now(),
    });
  }
}
