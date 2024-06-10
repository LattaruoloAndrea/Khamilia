import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/components/message_class.dart';

class ChatService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamController<List<MessageClass>> current_message= new StreamController();
  List<MessageClass> messages = [];

  processInput(userInput){
    //TODO add geminy call here
    return {'type': 'text','input':userInput['type']};
  }

  add_input(user_input){
    final DateTime timestamp = DateTime.now();
    messages.add(MessageClass({'type': 'text','input':user_input['type'],'sender': true,'timestamp':timestamp}));
    current_message.add(messages);
  }
  
  sendMessage(userInput){
    var k = processInput(userInput);
    k['sender'] = false;
    final DateTime timestamp = DateTime.now();
    k['timestamp'] = timestamp;
    messages.add(MessageClass(k));
    current_message.add(messages);
  }

  Stream getStream(){
    return current_message.stream; 
  }

}