// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gemini_app/components/message_class.dart';

// class ChatService{

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   StreamController<List<MessageClass>> current_message= StreamController();
//   List<MessageClass> messages = [];

//   Map<String, dynamic> processInput(userInput){
//     //TODO add geminy call here
//     //var res = {'type': 'text','query':userInput['type']};
//     //var res = {"query": "I woke up feeling energized, had a quick breakfast, went for a run, and started working on a new project. I felt motivated and focused.", "type": "activities", "activities": ["woke up early", "had breakfast", "went for a run", "started working on a new project"], "emotions": ["energized", "motivated", "focused"], "time": "today"};
//     //var res  ={ "query": "Get the number of new leads generated between August 1st, 2024 and August 10th, 2024.", "type": "query","start": "2024-08-01","end": "2024-08-10","sender":false};
//     //var res  = {"type":"error","sender":false};
//     var res  = {"query":"Could you help me install this software?", "type":"support","sender":false};
//     return res;
//   }

//   add_input(user_input){
//     final DateTime timestamp = DateTime.now();
//     messages.add(MessageClass({'type': 'ai-text','query':user_input['type'],'sender': true,'timestamp':timestamp}));
//     current_message.add(messages);
//   }
  
//   sendMessage(userInput){
//     Map<String, dynamic> k = processInput(userInput);
//     k['sender'] = false;
//     final DateTime timestamp = DateTime.now();
//     k['timestamp'] = timestamp;
//     messages.add(MessageClass(k));
//     current_message.add(messages);
//   }

//   Stream getStream(){
//     return current_message.stream; 
//   }

// }




import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:gemini_app/services/signleton_messages.dart';

class ChatService{
  // static final instace = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GeminyService geminyService = GeminyService();
  final DbService db = DbService();
  StreamController<List<MessageClass>> current_message= new StreamController();
  // List<MessageClass> messages = [];
  SignletonMessages singletonMessages = SignletonMessages.instance;


  Map<String, dynamic> processInput(userInput){
    //TODO add geminy call here
    //var res = {'type': 'text','query':userInput['type']};
    //var res = {"query": "I woke up feeling energized, had a quick breakfast, went for a run, and started working on a new project. I felt motivated and focused.", "type": "activities", "activities": ["woke up early", "had breakfast", "went for a run", "started working on a new project"], "emotions": ["energized", "motivated", "focused"], "time": "today"};
    var res  ={ "query": "Get the number of new leads generated between August 1st, 2024 and August 10th, 2024.", "type": "query","start": "2024-08-01","end": "2024-08-10","sender":false};
    // var res  = {"type":"error","sender":false};
    // var res  = {"query":"Could you help me install this software?", "type":"support","sender":false};
    //geminyService.processUserInput(res);
    return res;
  }

  addInput(user_input){
    final DateTime timestamp = DateTime.now();
    singletonMessages.add(MessageClass({'type': 'ai-text','query':user_input['type'],'sender': true,'timestamp':timestamp}));
    current_message.add(singletonMessages.get());
  }
  
  sendMessage(userInput) async{
    Map<String, dynamic> k = processInput(userInput);
    k['sender'] = false;
    final DateTime timestamp = DateTime.now();
    k['timestamp'] = timestamp;
    MessageClass message = MessageClass(k);
    MessageClass correct_message = await performTranformationOnMessageClass(message);
    singletonMessages.add(correct_message);
    current_message.add(singletonMessages.get());
  }

  Future<MessageClass> performTranformationOnMessageClass(MessageClass p) async {
    p.sender =false;
    if(p.type == "query"){
        ActivitiesClass activities = await db.queryFromTo(p.queryClassEasy!.start!,p.queryClassEasy!.end!);
        EmotionCategorizeClass emotions =  await geminyService.categolizeListOfEmotions(activities.emotions!);
        GroupClass group = await geminyService.groupActivities(activities.activities!);
        EmotionQueryClass classEmotions = EmotionQueryClass();
        ActivityQueryClass classActivities = ActivityQueryClass();
        classEmotions.floatingHeroTag = DateTime.now().microsecondsSinceEpoch.toString();
        classActivities.createChartData(group);
        classEmotions.createChartData(emotions);
        QueryClassToMessage queryClass = QueryClassToMessage(classEmotions,classActivities,p.queryClassEasy!);
        p.queryClassEasy = null;
        p.queryClassToMessage = queryClass;
    }
    return p;
  }

  Stream getStream(){
    return current_message.stream; 
  }

}