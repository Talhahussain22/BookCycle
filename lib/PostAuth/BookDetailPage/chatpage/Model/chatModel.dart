import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat{
  String chatId;
  String bookId;
  String buyerId;
  String sellerId;
  String bookimagepath;
  String booktitle;
  String ownername;
  String buyername;
  List<String> participants;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final String? lastMessage;
  final String? lastSenderId;
  final String bookprice;
  final Map<String, dynamic>? lastReadAt;

  Chat({
    required this.chatId,
    required this.bookId,
    required this.buyerId,
    required this.sellerId,
    required this.participants,
    required this.booktitle,
    required this.bookimagepath,
    required this.ownername,
    required this.buyername,
    required this.bookprice,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.lastSenderId,
    this.lastReadAt,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;

    return Chat(
      chatId: doc.id,
      bookId: d['bookId'],
      buyerId: d['buyerId'],
      sellerId: d['sellerId'],
      booktitle: d['booktitle'],
      bookimagepath: d['bookimagepath'],
      ownername: d['ownername'],
      buyername: d['buyername'],
      bookprice: d['bookprice'],
      participants: List<String>.from(d['participants']),
      createdAt: d['createdAt'] as Timestamp?,
      updatedAt: d['updatedAt'] as Timestamp?,
      lastMessage: d['lastMessage'] as String?,
      lastSenderId: d['lastSenderId'] as String?,
      lastReadAt: (d['lastReadAt'] as Map?)?.map((k, v) => MapEntry(k as String, v)),
    );
  }

  Map<String, dynamic> toMap() => {
    'bookId': bookId,
    'buyerId': buyerId,
    'sellerId': sellerId,
    'booktitle':booktitle,
    'bookimagepath':bookimagepath,
    'ownername':ownername,
    'buyername':buyername,
    'bookprice':bookprice,
    'participants': participants,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    'lastMessage': lastMessage,
    'lastSenderId': lastSenderId,
    'lastReadAt': lastReadAt ?? {},
  };

}