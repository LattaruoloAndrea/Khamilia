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
    return userInput;
  }
  
  sendMessage(userInput){
    // final String currentUserId = _auth.currentUser!.uid;
    // final String currentUserEmail = _auth.currentUser!.email!;
    // final Timestamp timestamp = Timestamp.now();
    // MessageClass(userInput);
    messages.add(MessageClass({'type': userInput['type'],'input':userInput['type'],'sender': true}));
    current_message.add(messages);
    messages.add(MessageClass({'type': userInput['type'],'input':userInput['type'],'sender': false}));
    current_message.add(messages);
    // current_message.add(processInput({'text': userInput['text'],'input': false}));
  }

  Stream getStream(){
    return current_message.stream; 
  }

}