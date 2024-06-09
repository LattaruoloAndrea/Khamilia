// ignore_for_file: empty_catches

import 'dart:ffi';

class MessageClass {
  String? type;
  String? input;
  bool? sender;

  ActivitiesClass? activitiesClass;
  GroupClass? groupClass;
  QueryClass? queryClass;
  NotificationClass? notificationClass;
  PeriodicyClass? periodicyClass;
  EmotionCategorizeClass? emotionCategorizeClass;
  SupportClass? supportClass;


  valid_message(m) {
    return true;
  }

  MessageClass(dynamic message) {
    if (valid_message(message)){}
    try{type = message['type'];} on(){type = 'error';}
    try{input = message['input'];} on(){}
    try{sender = message['sender'];} on(){}
    switch (type) {
      case 'text':
        break;
      case 'activities':
        activitiesClass = ActivitiesClass(message);
      case 'group':
        groupClass = GroupClass(message);
      case 'query':
        queryClass = QueryClass(message);
      case 'set-time':
        notificationClass = NotificationClass(message);
      case 'set-periodicy':
        periodicyClass = PeriodicyClass(message);
      case 'emotion-categorize':
        emotionCategorizeClass = EmotionCategorizeClass(message);
      case 'support':
        supportClass = SupportClass(message);
      default:
        break;
    }
  }
}

class ActivitiesClass {
  List<String>? emotions;
  List<String>? activitises;
  ActivitiesClass(dynamic message) {
    emotions = message['emotions'];
    activitises = message['activitises'];
  }
}

class GroupClass {
  List<String>? pyshical_activities;
  List<String>? entertainment;
  List<String>? learning_development;
  List<String>? work_chores;
  List<String>? social_person;
  GroupClass(dynamic message) {
    pyshical_activities = message['Physical Activities'];
    entertainment = message['Entertainment'];
    learning_development = message['Learning & development'];
    work_chores = message['work & chores'];
    social_person = message['Social & Personal'];
  }
}

class QueryClass {
  String? start;
  String? end;
  QueryClass(dynamic message) {
    start = message['start'];
    end = message['end'];
  }
}

class NotificationClass {
  String? time;
  NotificationClass(dynamic message) {
    time = message['time'];
  }
}

class PeriodicyClass {
  List<OperationOnWeekClass>? data;
  PeriodicyClass(dynamic message) {
    data = [];
    List<dynamic> l = message['data'];
    for (int i = 0; i < l.length; i++) {
      data!.add(OperationOnWeekClass(l[i]));
    }
  }
}

class OperationOnWeekClass {
  String? kind; // add or remove
  List<String>? monday;
  List<String>? tuesday;
  List<String>? wednesday;
  List<String>? thursday;
  List<String>? friday;
  List<String>? saturday;
  List<String>? sunday;
  OperationOnWeekClass(dynamic message) {
    kind = message['kind'];
    try {
      monday = message['monday'];
    } on () {}
    try {
      tuesday = message['tuesday'];
    } on () {}
    try {
      wednesday = message['wednesday'];
    } on () {}
    try {
      thursday = message['thursday'];
    } on () {}
    try {
      friday = message['friday'];
    } on () {}
    try {
      saturday = message['saturday'];
    } on () {}
    try {
      sunday = message['sunday'];
    } on () {}
  }
}

class EmotionCategorizeClass {
  List<EmotionEvaluationClass>? listEmotions;
  EmotionCategorizeClass(dynamic message) {
    listEmotions = [];
    List<dynamic> l = message['output'];
    for (int i = 0; i < l.length; i++) {
      listEmotions!.add(EmotionEvaluationClass(l[i]));
    }
  }
}

class EmotionEvaluationClass {
  String? emotion;
  int? evaluation;
  String? description;
  String? category;
  EmotionEvaluationClass(dynamic message) {
    emotion = message['emotion'];
    evaluation = message['evaluation'];
    description = message['description'];
    category = message['category'];
  }
}

class SupportClass {
  String? value; // help tutorial
  SupportClass(dynamic message) {
    value = message['value'];
  }
}
