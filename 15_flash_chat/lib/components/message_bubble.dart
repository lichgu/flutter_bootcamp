import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';

DateFormat dateFormat = DateFormat('yyyy-MM-dd'); // 'yyyy-MM-dd HH:mm:ss'

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.sender,
    required this.timestamp,
    required this.message,
    required this.isMe,
    required this.lastSender,
    required this.nextSender,
    required this.nextTimestamp,
  });

  final String sender;
  final Timestamp timestamp;
  final String message;
  final bool isMe;
  final String lastSender;
  final String nextSender;
  final Timestamp nextTimestamp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        10.0,
        5.0,
        10.0,
        sender != lastSender ? 15.0 : 5.0,
      ),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (dateFormat.format(timestamp.toDate()) !=
              dateFormat.format(nextTimestamp.toDate())) ...[
            Center(
              child: Text(
                dateFormat.format(timestamp.toDate()),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: kPrimaryColorLight,
                ),
              ),
            ),
          ],
          if (sender != nextSender) ...[
            Text(
              sender,
              style: const TextStyle(
                fontSize: 12.0,
                color: kPrimaryColorLight,
              ),
            ),
          ],
          Material(
            borderRadius: BorderRadius.only(
              topLeft: isMe ? const Radius.circular(20.0) : Radius.zero,
              topRight: isMe ? Radius.zero : const Radius.circular(20.0),
              bottomLeft: const Radius.circular(20.0),
              bottomRight: const Radius.circular(20.0),
            ),
            elevation: 5.0,
            color: isMe ? kPrimaryColor : Colors.grey.shade800,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
