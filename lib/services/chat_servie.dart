import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';
import 'package:gemini_app/services/db_service.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:gemini_app/services/signleton_messages.dart';
import 'package:gemini_app/services/current_day_service.dart';

class ChatService {
  // static final instace = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CurrentDayService timeService = CurrentDayService();
  final GeminyService geminyService = GeminyService();
  final DbService db = DbService();
  StreamController<List<MessageClass>> current_message = new StreamController();
  // List<MessageClass> messages = [];
  SignletonMessages singletonMessages = SignletonMessages.instance;

  Future<Map<String, dynamic>> processInput(userInput) async{
    //TODO add geminy call here
    //Map<String, dynamic> res = await geminyService.callToGeminy(userInput);
    // Today I went to buy groceries heded to the gym and I left a bit numb and sad
    //var res = {'type': 'text','query':userInput['type']};
    // var res = {
    //   "query":
    //       "I woke up feeling energized, had a quick breakfast, went for a run, and started working on a new project. I felt motivated and focused.",
    //   "type": "activities",
    //   "activities": [
    //     "woke up early",
    //     "had breakfast",
    //     "went for a run",
    //     "started working on a new project"
    //   ],
    //   "emotions": ["energized", "motivated", "focused"],
    //   "time": "today"
    // };
    // var res  ={ "query": "Get the number of new leads generated between August 1st, 2024 and August 10th, 2024.", "type": "query","start": "2024-08-01","end": "2024-08-10","sender":false};
    //var res  = {"type":"error","sender":false};
    //var res  = {"query":"Could you help me install this software?", "type":"support","sender":false};
    var res =   {"query": "I completed a 100 meter freestyle in 1 minute and 10 seconds","type":"progression",    "category": "swimming",    "task": "freestyle",  "parameter1": {"name": "style", "value": "freestyle"},    "parameter2": {"name": "distance", "value": "100"},    "result": "70",    "mesureUnit": "seconds"};
    //geminyService.processUserInput(res);
    print(res);
    return res;
  }

  addInput(user_input) {
    final DateTime timestamp = DateTime.now();
    singletonMessages.add(MessageClass({
      'type': 'text',
      'query': user_input['type'],
      'sender': true,
      'timestamp': timestamp
    }));
    current_message.add(singletonMessages.get());
  }

  sendMessage(userInput) async {
    Map<String, dynamic> k = await processInput(userInput);
    k['sender'] = false;
    final DateTime date = timeService.currentDate();
    k['timestamp'] = date;
    MessageClass message = MessageClass(k);
    MessageClass correctMessage =
        await performTranformationOnMessageClass(message);
    String docId = await saveToDb(correctMessage, date);
    addDocIdToMessage(correctMessage, docId);
    singletonMessages.add(correctMessage);
    current_message.add(singletonMessages.get());
  }

  Future<MessageClass> performTranformationOnMessageClass(
      MessageClass p) async {
    p.sender = false;
    if (p.type == "query") {
      ActivitiesClass activities = await db.queryFromTo(
          p.queryClassEasy!.start!, p.queryClassEasy!.end!);
      EmotionCategorizeClass emotions =
          await geminyService.categolizeListOfEmotions(activities.emotions!);
      GroupClass group =
          await geminyService.groupActivities(activities.activities!);
      EmotionQueryClass classEmotions = EmotionQueryClass();
      ActivityQueryClass classActivities = ActivityQueryClass();
      classEmotions.floatingHeroTag =
          DateTime.now().microsecondsSinceEpoch.toString();
      classActivities.createChartData(group);
      classEmotions.createChartData(emotions);
      QueryClassToMessage queryClass = QueryClassToMessage(
          classEmotions, classActivities, p.queryClassEasy!);
      p.queryClassEasy = null;
      p.queryClassToMessage = queryClass;
    }
    if(p.type =='progression'){
      // TODO fetch data
    }
    return p;
  }

  Future<String> saveToDb(MessageClass p, date) async {
    if (p.type == "activities") {
      int correctTimestamp = timeService.getdateHalfDay(date);
      if (p.activitiesClass!.yesterday) {
        // change the timestemp to yesterday timestamp
        var yesterday = timeService.getYesterdayDate(date);
        correctTimestamp = timeService.getdateHalfDay(yesterday);
      }
      p.activitiesClass!.timestamp = correctTimestamp;
      String id = await db.saveDailyOccurence(p.activitiesClass!);
      return id;
    }
    if(p.type =='progressions'){
      
    }
    return "";
  }

  addDocIdToMessage(MessageClass message, String docId) {
    if (message.type == "activities") {
      message.activitiesClass!.docId = docId;
    }
  }

  Stream getStream() {
    return current_message.stream;
  }

  getDailyPeriodicActivities() async {
    if (singletonMessages.messages.isEmpty) {
      String day = timeService.getDayOfTheWeek();
      final DateTime date = timeService.currentDate();
      int timestampPerDb = timeService.getTimeForPeriodicService();
      String createdId = await db.periodicyDailyAlreadySaved(timestampPerDb);
      ActivitiesClass periodicActivity = ActivitiesClass();
      if (createdId.isEmpty) {
        // First time
        PeriodicyDataClass periodicy = await db.loadPeriodicy();
        List<String> activitiesPerToday = periodicy.getDay(day);
        periodicActivity = ActivitiesClass(
            activities: activitiesPerToday,
            emotions: [],
            timestamp: timestampPerDb,
            description: "",
            periodicActivity: true);
        String id = await db.savePeriodicActivityOnce(periodicActivity);
        periodicActivity.docId = id;
      } else {
        //already created
        periodicActivity = await db.getActivityFromDocId(createdId);
        periodicActivity.docId = createdId;
      }
      Map<String, dynamic> k = {};
      k['sender'] = false;
      k['type'] = 'dailyActivity';
      k['timestamp'] = date;
      k['activity'] = periodicActivity;
      MessageClass message = MessageClass(k);
      singletonMessages.add(message);
      current_message.add(singletonMessages.get());
    }
  }
}
