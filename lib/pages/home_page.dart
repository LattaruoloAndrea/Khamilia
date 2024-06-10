import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_chat.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/my_textfield.dart';
import 'package:gemini_app/components/user_input_chat.dart';
import 'package:gemini_app/pages/setting_page.dart';
import 'package:gemini_app/services/auth_service.dart';
import 'package:gemini_app/services/chat_servie.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
// https://ai.google.dev/gemini-api/docs/get-started/tutorial?lang=dart

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      var message = {'type': _messageController.text, 'sender': false};
      await _chatService.add_input(message);
      var response = await _chatService.sendMessage(message);
      _scrollToBottom();
      _messageController.clear();
    }
  }

   _scrollToBottom(){
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Kamilia",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            backgroundColor: Colors.pink[300]),
        drawer: MyDrawer(),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/flamingo_screen.png"),
              // fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(child: Text('Welcome, you are logged in')),
              Expanded(child: _buildMessageList()),
              // https://lottiefiles.com/animations/flamingo-v2lht2pMje
              // Center(child: Lottie.asset("lib/images/flamingo.json")),
              UserInputChat(
                  controller: _messageController,
                  onPressed: sendMessage,
                  onPressedMic: sendMessage),
              SizedBox(height: 40),
            ],
          ),
        )));
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MessageChat(
                message: MessageClass({
              'type': 'error',
              'sender': false,
              'input': 'There was an error'
            }));
          }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Text('Loading ...');
          // }
          if (snapshot.data != null) {
            List<MessageClass> p = snapshot.data!;
            return ListView(
              controller: _scrollController,
              children: p.map((el) => _buildMessagesItem(el)).toList(),
              // .toList(),
            );
          }
          else{
            return ListView();
          }
        });
  }

  Widget _buildMessagesItem(MessageClass message) {
    // Map<String, dynamic> data = message as Map<String, dynamic>;
    var alignment =
        (message.sender!) ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        children: [
          MessageChat(
            message: message,
          )
        ],
      ),
    );
  }
}
