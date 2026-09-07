import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../service/api_gemini.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatUser user1 = ChatUser(
    id: '1',
    firstName: 'me',
  );

  ChatUser user2 = ChatUser(
    id: '2',
    firstName: 'bot',
  );

  List<ChatMessage> messagesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome To AI Chat"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: DashChat(
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.pink,
          currentUserTextColor: Colors.white,
          containerColor: Colors.blue.shade100,
          textColor: Colors.black,

          avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
            return const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1677442136019-21780ecad995",
              ),
            );
          },
        ),

        currentUser: user1,

        onSend: (messages) async {
          messagesList.insert(0, messages);

          setState(() {});

          String botMessage =
              await GeminiApi().sendRequest(messages.text);

          ChatMessage reply = ChatMessage(
            user: user2,
            createdAt: DateTime.now(),
            text: botMessage,
          );

          messagesList.insert(0, reply);

          setState(() {});
        },

        messages: messagesList,
      ),
    );
  }
}