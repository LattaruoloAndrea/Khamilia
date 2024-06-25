import 'package:gemini_app/components/message_class.dart';

class GeminyService {

  Future<dynamic> processUserInput(dynamic input){
    //TODO this is the call to geminy AI
    // "sender":false add the "sender" : false, to the map
    return input;
  }

  Future<EmotionCategorizeClass> categolizeListOfEmotions(
      List<String> emotions) async {
    await Future.delayed(const Duration(seconds: 2));
    var ll = {
      "input": [
        "joy",
        "anger",
        "fear",
        "curiosity",
        "shame",
        "gratitude",
        "boredom"
      ],
      "type": "emotion-categorize",
      "output": [
        {
          "emotion": "joy",
          "evaluation": "10",
          "description": "A feeling of happiness, contentment, and pleasure.",
          "category": "Basic Emotion"
        },
        {
          "emotion": "anger",
          "evaluation": "2",
          "description":
              "A feeling of intense displeasure, hostility, and aggression.",
          "category": "Basic Emotion"
        },
        {
          "emotion": "fear",
          "evaluation": "2",
          "description": "A feeling of apprehension, worry, and anxiety.",
          "category": "Basic Emotion"
        },
        {
          "emotion": "curiosity",
          "evaluation": "7",
          "description":
              "A feeling of intrigue, interest, and inquisitiveness.",
          "category": "Cognitive Emotion"
        },
        {
          "emotion": "shame",
          "evaluation": "2",
          "description":
              "A feeling of embarrassment, humiliation, and remorse.",
          "category": "Social Emotion"
        },
        {
          "emotion": "gratitude",
          "evaluation": "9",
          "description":
              "A feeling of thankfulness, appreciation, and indebtedness.",
          "category": "Social Emotion"
        },
        {
          "emotion": "boredom",
          "evaluation": "3",
          "description":
              "A feeling of uninterest, restlessness, and lack of stimulation.",
          "category": "Social Emotion"
        }
      ]
    };
    EmotionCategorizeClass b = EmotionCategorizeClass(ll);
    return b;
  }

  Future<GroupClass> groupActivities(List<String> activities) async {
    await Future.delayed(const Duration(seconds: 2));
    var ll = {
      // "input": [
      //   "Go to a museum",
      //   "Learn about history",
      //   "Admire the art",
      //   "Take photos"
      // ],
      // "type": "group-activities",
      "Physical Activities": [],
      "Entertainment": ["Go to a museum", "Admire the art"],
      "Learning & Development": ["Learn about history"],
      "Work & Chores": [],
      "Social & Personal": ["Take photos"]
    };
    GroupClass b = GroupClass(ll);
    return b;
  }

}
