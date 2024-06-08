import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamController current_message= new StreamController(sync: true);
  List messages = [];

  processInput(userInput){
    //TODO add geminy call here
    return userInput;
  }
  
  sendMessage(userInput){
    // final String currentUserId = _auth.currentUser!.uid;
    // final String currentUserEmail = _auth.currentUser!.email!;
    // final Timestamp timestamp = Timestamp.now();
    messages.add({'type': userInput['type'],'input': true});
    current_message.add(messages);
    messages.add({'type': userInput['type'],'input': false});
    current_message.add(messages);
    // current_message.add(processInput({'text': userInput['text'],'input': false}));
  }

  Stream getStream(){
    return current_message.stream; 
  }

}