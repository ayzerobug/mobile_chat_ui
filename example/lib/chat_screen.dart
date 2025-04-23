import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/mobile_chat_ui.dart';

import 'util.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<User> users = [];
  late List<Message> messages;
  final rand = Random();

  @override
  void initState() async {
    super.initState();
    messages = await fetchMessages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Test")),
      body: Chat(
        user: loggedInUser,
        messages: messages,
        chatTheme:
            DefaultChatTheme(userAvatarRadius: 12, primaryColor: Colors.blue),
        authorDetailsLocation: AuthorDetailsLocation.bottom,
        hasInput: true,
        showUserAvatar: true,
      ),
    );
  }
}
