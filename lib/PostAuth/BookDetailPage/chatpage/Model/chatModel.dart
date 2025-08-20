import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat{
  String chatId;
  String bookId;
  String buyerId;
  String sellerId;
  List<String> participants;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final String? lastMessage;
  final String? lastSenderId;
  final Map<String, dynamic>? lastReadAt;

  Chat({
    required this.chatId,
    required this.bookId,
    required this.buyerId,
    required this.sellerId,
    required this.participants,
    this.createdAt,
    this.updatedAt,
    this.lastMessage,
    this.lastSenderId,
    this.lastReadAt,
  });

  factory Chat.fromDoc(DocumentSnapshot doc) {
    final d = doc.data()! as Map<String, dynamic>;
    return Chat(
      chatId: doc.id,
      bookId: d['bookId'],
      buyerId: d['buyerId'],
      sellerId: d['sellerId'],
      participants: List<String>.from(d['participants']),
      createdAt: d['createdAt'],
      updatedAt: d['updatedAt'],
      lastMessage: d['lastMessage'],
      lastSenderId: d['lastSenderId'],
      lastReadAt: (d['lastReadAt'] as Map?)?.map((k, v) => MapEntry(k as String, v)),
    );
  }

  Map<String, dynamic> toMap() => {
    'bookId': bookId,
    'buyerId': buyerId,
    'sellerId': sellerId,
    'participants': participants,
    'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    'lastMessage': lastMessage,
    'lastSenderId': lastSenderId,
    'lastReadAt': lastReadAt ?? {},
  };

}