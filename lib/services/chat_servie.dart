import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/components/message_class.dart';

class ChatService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamController<List<MessageClass>> current_message= new StreamController();
  List<MessageClass> messages = [];

  Map processInput(userInput){
    //TODO add geminy call here
    //var res = {'type': 'text','query':userInput['type']};
    //var res = {"query": "I woke up feeling energized, had a quick breakfast, went for a run, and started working on a new project. I felt motivated and focused.", "type": "activities", "activities": ["woke up early", "had breakfast", "went for a run", "started working on a new project"], "emotions": ["energized", "motivated", "focused"], "time": "today"};
    var res  ={ "query": "Get the number of new leads generated between August 1st, 2024 and August 10th, 2024.", "type": "query","start": "2024-08-01","end": "2024-08-10","sender":false};
    return res;
  }

  add_input(user_input){
    final DateTime timestamp = DateTime.now();
    messages.add(MessageClass({'type': 'ai-text','query':user_input['type'],'sender': true,'timestamp':timestamp}));
    current_message.add(messages);
  }
  
  sendMessage(userInput){
    Map k = processInput(userInput);
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