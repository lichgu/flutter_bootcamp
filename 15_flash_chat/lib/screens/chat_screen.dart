import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/utils/constants.dart';
import '../components/message_bubble.dart';
import '../utils/auth.dart';
import '../utils/dao.dart';
import 'login_screen.dart';

Dao dao = Dao();
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Auth _authHandler = Auth();
  final TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      loggedInUser = await _authHandler.getCurrentUser();
    } catch (e) {
      print(e);
    }
  }

  /*void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }
  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            onPressed: () {
              _authHandler.handleSignOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  ModalRoute.withName(WelcomeScreen.id));
            },
            icon: const Icon(Icons.close),
          ),
        ],
        title: const Text('⚡ ️Chat'),
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: Colors.grey.shade700,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: kPrimaryColor,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (messageTextController.text.isNotEmpty) {
                        dao.addMessage(messageTextController.text,
                            loggedInUser.displayName!);
                        messageTextController.clear();
                      }
                    },
                    child: const Text(
                      'send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: dao.getMessagesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            ),
          );
        }
        List<MessageBubble> messageBubbles = [];
        if (snapshot.data!.docs.isNotEmpty) {
          int counter = 0;
          String lastSender = '';
          String messageSender = '';
          String nextSender = snapshot.data!.docs[counter]['sender'];
          for (var doc in snapshot.data!.docs
              .sublist(0, snapshot.data!.docs.length - 1)) {
            lastSender = messageSender;
            messageSender = nextSender;
            nextSender = snapshot.data!.docs[counter + 1]['sender'];
            messageBubbles.add(
              MessageBubble(
                sender: messageSender,
                timestamp: doc['ts'],
                message: doc['text'],
                isMe: loggedInUser.displayName == messageSender,
                lastSender: lastSender,
                nextSender: nextSender,
                nextTimestamp: snapshot.data!.docs[counter + 1]['ts'],
              ),
            );
            counter++;
          }
          messageBubbles.add(
            MessageBubble(
              sender: nextSender,
              timestamp: snapshot.data!.docs[counter]['ts'],
              message: snapshot.data!.docs[counter]['text'],
              isMe: loggedInUser.displayName == nextSender,
              lastSender: messageSender,
              nextSender: '',
              nextTimestamp: Timestamp(0, 0),
            ),
          );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
