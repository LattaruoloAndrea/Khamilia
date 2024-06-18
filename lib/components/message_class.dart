// ignore_for_file: empty_catches

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum ErrorType {
  warningMissingEmotionsOnActivityType(
      value: -3, errorMsg: "There is no emotions", msgForUser: ""),
  warningMissingSender(
      value: -2, errorMsg: "There is no sender", msgForUser: ""),
  warningMissingInput(value: -1, errorMsg: "There is no input", msgForUser: ""),
  errorGeminiResponseNoType(value: 0, errorMsg: "", msgForUser: ""),
  errorMissingActivitiesOnActivityType(
      value: 1,
      errorMsg: "Geminy AI did not provide the list of activities",
      msgForUser: ""),
  errorMissingStartOnQueryType(
      value: 2,
      errorMsg: "Geminy AI did not provide the start date from the query",
      msgForUser: ""),
  errorMissingTimeOnNotificationType(
      value: 3,
      errorMsg:
          "Geminy AI did not provide the time from the notification settings",
      msgForUser: ""),
  errorMissingDataFromPeriodicyType(
      value: 4,
      errorMsg:
          "Geminy AI did not provide the data from the periodicty settings",
      msgForUser: ""),
  errorMissingKindInDataForPeriodicyType(
      value: 5,
      errorMsg: "Geminy AI did not provide the kind in the data",
      msgForUser: ""),
  errorMissingAtLeastOneDayInDataForPeriodicyType(
      value: 6,
      errorMsg: "Geminy AI did not provide the day in data",
      msgForUser: ""),
  errorMissingOutputInEmotionCategorizationType(
      value: 7,
      errorMsg:
          "Geminy AI did not provide the ouptut in emotions-categorization",
      msgForUser: "");

  const ErrorType({
    required this.value,
    required this.errorMsg,
    required this.msgForUser,
  });

  final int value;
  final String errorMsg;
  final String msgForUser;
}

class MessageClass {
  String? type;
  String? input;
  bool? sender;
  DateTime? timestamp;

  ActivitiesClass? activitiesClass;
  AddActivitiesClass? addActivitiesClass;
  GroupClass? groupClass;
  QueryClass? queryClass;
  NotificationClass? notificationClass;
  PeriodicyClass? periodicyClass;
  EmotionCategorizeClass? emotionCategorizeClass;
  SupportClass? supportClass;
  ErrorType? errorType;

  isCorrect() {
    if (errorType != null && errorType!.value >= 0) {
      return false;
    }
    return true;
  }

  MessageClass(dynamic message) {
    try {
      type = message['type'];
    } catch (e) {
      errorType = ErrorType.errorGeminiResponseNoType;
    }
    try {
      input = message['query'];
    } catch (e) {
      errorType = ErrorType.warningMissingInput;
    }
    try {
      sender = message['sender'];
    } catch (e) {
      errorType = ErrorType.warningMissingSender;
    }
    try {
      timestamp = message['timestamp'];
    } catch (e) {}
    switch (type) {
      case 'text':
        break;
      case 'ai-text':
        break;
      case 'activities':
        try {
          activitiesClass = ActivitiesClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'add-activities':
        try {
          addActivitiesClass = AddActivitiesClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'group':
        try {
          groupClass = GroupClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'query':
        try {
          queryClass = QueryClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'set-time':
        try {
          notificationClass = NotificationClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'set-periodicy':
        try {
          periodicyClass = PeriodicyClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'emotion-categorize':
        try {
          emotionCategorizeClass = EmotionCategorizeClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      case 'support':
        try {
          supportClass = SupportClass(message);
        } on ErrorType catch (e) {
          errorType = e;
        }
      default:
        break;
    }
  }
}

class ActivitiesClass {
  List<String>? emotions;
  List<String>? activities;
  bool yesterday = false; //if false it refers to today
  ActivitiesClass(dynamic message) {
    emotions = [];
    activities = [];
    try {
      // List<String> b = message['activities'];
      activities = message['activities'];
    } catch (e) {
      throw ErrorType.errorMissingActivitiesOnActivityType;
    }
    try {
      emotions = message['emotions'];
    } catch (e) {
      print("object");
    } //throw ErrorType.warningMissingEmotionsOnActivityType;
    try {
      yesterday = message['time'] == 'yesterday';
    } catch (e) {}
  }
}

class AddActivitiesClass {
  List<String>? emotions;
  List<String>? activities;
  bool yesterday = false; //if false it refers to today
  AddActivitiesClass(dynamic message) {
    emotions = [];
    activities = [];
    try {
      activities = message['activities'];
    } catch (e) {
      throw ErrorType.errorMissingActivitiesOnActivityType;
    }
    try {
      emotions = message['emotions'];
    } catch (e) {} //throw ErrorType.warningMissingEmotionsOnActivityType;
    try {
      yesterday = message['time'] == 'yesterday';
    } catch (e) {}
  }
}

class GroupClass {
  List<String>? pyshicalActivities;
  List<String>? entertainment;
  List<String>? learningDevelopment;
  List<String>? workChores;
  List<String>? socialPerson;
  GroupClass(dynamic message) {
    pyshicalActivities = [];
    entertainment = [];
    learningDevelopment = [];
    workChores = [];
    socialPerson = [];
    try {
      pyshicalActivities = message['Physical Activities'];
    } catch (e) {pyshicalActivities = [];}
    try {
      entertainment = message['Entertainment'];
    } catch (e) {entertainment = [];}
    try {
      learningDevelopment = message['Learning & Development'];
    } catch (e) {learningDevelopment = [];}
    try {
      workChores = message['Work & Chores'];
    } catch (e) {workChores = [];}
    try {
      socialPerson = message['Social & Personal'];
    } catch (e) {socialPerson = [];}
  }
}

class QueryClass {
  String? start;
  String? end;
  QueryClass(dynamic message) {
    start = "";
    end = "";
    try {
      start = message['start'];
    } catch (e) {
      throw ErrorType.errorMissingStartOnQueryType;
    }
    try {
      end = message['end'];
    } catch (e) {
      end = start;
    }
  }
}

class NotificationClass {
  String? time;
  NotificationClass(dynamic message) {
    try {
      time = message['time'];
    } catch (e) {
      throw ErrorType.errorMissingStartOnQueryType;
    }
  }
}

class PeriodicyClass {
  List<OperationOnWeekClass>? data;
  PeriodicyClass(dynamic message) {
    data = [];
    List<dynamic> l = [];
    try {
      l = message['data'];
    } catch (e) {
      throw ErrorType.errorMissingDataFromPeriodicyType;
    }
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
    bool atLeastOne = false;
    try {
      kind = message['kind'];
    } catch (e) {
      throw ErrorType.errorMissingKindInDataForPeriodicyType;
    }
    try {
      monday = message['monday'];
      atLeastOne = true;
    } on () {}
    try {
      tuesday = message['tuesday'];
      atLeastOne = true;
    } on () {}
    try {
      wednesday = message['wednesday'];
      atLeastOne = true;
    } on () {}
    try {
      thursday = message['thursday'];
      atLeastOne = true;
    } on () {}
    try {
      friday = message['friday'];
      atLeastOne = true;
    } on () {}
    try {
      saturday = message['saturday'];
      atLeastOne = true;
    } on () {}
    try {
      sunday = message['sunday'];
      atLeastOne = true;
    } on () {}
    if (!atLeastOne) {
      throw ErrorType.errorMissingAtLeastOneDayInDataForPeriodicyType;
    }
  }
}

class EmotionCategorizeClass {
  List<EmotionEvaluationClass>? listEmotions;
  EmotionCategorizeClass(dynamic message) {
    listEmotions = [];
    List<dynamic> l = [];
    try {
      l = message['output'];
    } catch (e) {}

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
    try {
      emotion = message['emotion'];
    } catch (e) {
      emotion = "Not provided";
    }
    try {
      evaluation = int.parse(message['evaluation']);
    } catch (e) {
      evaluation = -1;
    }
    try {
      description = message['description'];
    } catch (e) {
      description = "Not provided";
    }
    try {
      category = message['category'];
    } catch (e) {
      category = "Not provided";
    }
  }
}

class SupportClass {
  String? value; // help tutorial
  SupportClass(dynamic message) {
    try {
      value = message['value'];
    } catch (e) {
      value = "help";
    }
  }
}
