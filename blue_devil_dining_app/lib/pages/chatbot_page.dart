import 'dart:convert';

import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

final _dio = Dio();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final List<Map<String, dynamic>> messageHistoryList = [];
  final _user = types.User(id: const Uuid().v4());
  final _agent = const types.User(id: 'bot');
  final String requestUrl = "$apiUrl/chat/";

  @override
  void initState() {
    super.initState();
    // Add any initial messages if needed
    final botMessage = types.TextMessage(
      author: _agent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text:
          "Hi, welcome to Duke Dining. I am *BlueBot*, how can I assist you today?", // Assuming the reply is in 'reply' field
    );
    _messages.insert(0, botMessage);
    messageHistoryList.add({
      "message": botMessage.text,
      "author": _agent.id,
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text.trim(),
    );
    setState(() {
      _messages.insert(0, textMessage);
    });
    messageHistoryList.add({
      "message": message.text.trim(),
      "author": _user.id,
    });

    // Using Dio
    final response = await _dio.post(
      requestUrl,
      data: {
        'query': message.text,
        'message_history': messageHistoryList,
      },
    );
    final responseData = response.data as Map<String, dynamic>;
    final botMessage = types.TextMessage(
      author: _agent,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: responseData['response'], // Assuming the reply is in 'reply' field
    );
    setState(() {
      _messages.insert(0, botMessage);
    });
    messageHistoryList.add({
      "message": botMessage.text,
      "author": _agent.id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: standardSeparation),
          const Text(
            "blue bot",
            style: TextStyle(
              fontSize: standardSeparation * 2,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Chat(
              theme: const DefaultChatTheme(
                backgroundColor: backgroundColor,
                primaryColor: primaryColor,
                inputElevation: standardSeparation,
              ),
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
        ],
      ),
    );
  }
}
