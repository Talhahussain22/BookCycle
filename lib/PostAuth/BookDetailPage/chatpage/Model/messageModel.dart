import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final Timestamp? timestamp;
  String status;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    this.timestamp,
    required this.status
  });

  factory Message.fromDoc(DocumentSnapshot doc) {
    final d = doc.data()! as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: d['senderId'],
      text: d['text'],
      timestamp: d['timestamp'],
      status: d['status']
    );
  }

  Map<String, dynamic> toMap() => {
    'senderId': senderId,
    'text': text,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
