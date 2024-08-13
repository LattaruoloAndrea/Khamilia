import 'package:gemini_app/components/message_class.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:io';
import 'dart:convert';

const apiKey =
    "AIzaSyABuw9itBZM0GJJx9Q32337IoKjdNpuwXU"; // I know it should not go here but it was a demo and for now it's fine

// https://ai.google.dev/gemini-api/docs/oauth

class GeminyService {
  final model = GenerativeModel(
    model:
        //'gemini-1.5-flash',
        'tunedModels/khamiliav01-rrqdl4gzetgb', // here goes the ID of the tuned model gemini-1.5-flash
        // com.lattaruolo.gemini.khamilia
        // 84:3C:09:35:A3:C4:AB:E3:60:38:86:D4:16:18:B6:8F:3D:17:1E:B6
    apiKey: apiKey,
    // safetySettings: Adjust safety settings
    // See https://ai.google.dev/gemini-api/docs/safety-settings
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
  );

  Future<Map<String, dynamic>> callToGeminy(String input) async {
    //final tokenCount = await model.countTokens([Content.text('prompt')]);
    //print('Token count: ${tokenCount.totalTokens}');
    //final content = Content.text(input);
    var content = [Content.text(input)];
    var geminyResponse = "";
    model
        .generateContent(content)
        .then((response) => geminyResponse = response.text!)
        .catchError((onError) =>
            geminyResponse = "{'error': 'geminy service: $onError'}");
    // https://www.youtube.com/watch?v=VwpDvvNjN2I
    var counter = 0;
    while (geminyResponse.isEmpty && counter <= 20) {
      //await max 20 seconds then timeout error
      await Future.delayed(const Duration(seconds: 1));
      counter += 1;
    }
    if (counter >= 20) {
      geminyResponse = "{'error': 'timeout'}"; // timeout error
    }
    try {
      Map<String, dynamic> bResponse = json.decode(geminyResponse);
      return bResponse;
    } catch (e) {
      return {
        'error':
            'message not json convertable. Message from geminy: "$geminyResponse"'
      };
    }
  }

  Future<dynamic> processUserInput(dynamic input) {
    //TODO this is the call to geminy AI
    return callToGeminy(input);
  }

  Future<EmotionCategorizeClass> categolizeListOfEmotions(
      List<String> emotions) async {
    String input =
        ' Given a list of emotions provide a number between 1 to 10 where 1 means a negative emotion 5 in a neutral emotion an 10 is a positive emotion: ###input:${emotions.toList()}### ###output: [{"emotion":"emotion1","evaluation":"value for emotion1","decription":"emotion description","category":"Emotion1 category" },{"emotion":"emotion3","evaluation":"value for emotion3","decription":"emotion description","category":"Emotion3 category"},{"emotion":"emotion2","evaluation":"value for emotion2","decription":"emotion description","category":"Emotion2 category"}] ###';
    Map<String, dynamic> res = {};
    //Map<String, dynamic> res = callToGeminy(input);
    if (res.containsKey('error')) {
      res = {"output": []};
    }
    // await Future.delayed(const Duration(seconds: 2));
    // var ll = {
    //   "input": [
    //     "joy",
    //     "anger",
    //     "fear",
    //     "curiosity",
    //     "shame",
    //     "gratitude",
    //     "boredom"
    //   ],
    //   "type": "emotion-categorize",
    //   "output": [
    //     {
    //       "emotion": "joy",
    //       "evaluation": "10",
    //       "description": "A feeling of happiness, contentment, and pleasure.",
    //       "category": "Basic Emotion"
    //     },
    //     {
    //       "emotion": "anger",
    //       "evaluation": "2",
    //       "description":
    //           "A feeling of intense displeasure, hostility, and aggression.",
    //       "category": "Basic Emotion"
    //     },
    //     {
    //       "emotion": "fear",
    //       "evaluation": "2",
    //       "description": "A feeling of apprehension, worry, and anxiety.",
    //       "category": "Basic Emotion"
    //     },
    //     {
    //       "emotion": "curiosity",
    //       "evaluation": "7",
    //       "description":
    //           "A feeling of intrigue, interest, and inquisitiveness.",
    //       "category": "Cognitive Emotion"
    //     },
    //     {
    //       "emotion": "shame",
    //       "evaluation": "2",
    //       "description":
    //           "A feeling of embarrassment, humiliation, and remorse.",
    //       "category": "Social Emotion"
    //     },
    //     {
    //       "emotion": "gratitude",
    //       "evaluation": "9",
    //       "description":
    //           "A feeling of thankfulness, appreciation, and indebtedness.",
    //       "category": "Social Emotion"
    //     },
    //     {
    //       "emotion": "boredom",
    //       "evaluation": "3",
    //       "description":
    //           "A feeling of uninterest, restlessness, and lack of stimulation.",
    //       "category": "Social Emotion"
    //     }
    //   ]
    // };
    EmotionCategorizeClass b = EmotionCategorizeClass(res);
    return b;
  }

  Future<GroupClass> groupActivities(List<String> activities) async {
    String input =
        'group together this list of activities  ###${activities.toString()}### across these categories: ["Physical Activities","Entertainment","Learning & Development", "Work & Chores", Social & Personal]. The format of the grouping is {"input":["activity1","activity2","activity3",....],"type":"group-activities","Physical Activities":["activity1"],"Entertainment": [], "Learning & Development":["activity2","activity3"],"Work & Chores":[],"Social & Personal":["activity4","activity5"]}';
    //Map<String, dynamic> res = await callToGeminy(input);
    Map<String, dynamic> res = {'error':'Not implemented yet'};
    if (res.containsKey('error')) {
      res = {
        "Physical Activities": [],
        "Entertainment": [],
        "Learning & Development": [],
        "Work & Chores": [],
        "Social & Personal": []
      };
    }
    // await Future.delayed(const Duration(seconds: 2));
    // var res = {
    //   // "input": [
    //   //   "Go to a museum",
    //   //   "Learn about history",
    //   //   "Admire the art",
    //   //   "Take photos"
    //   // ],
    //   // "type": "group-activities",
    //   "Physical Activities": [],
    //   "Entertainment": ["Go to a museum", "Admire the art"],
    //   "Learning & Development": ["Learn about history"],
    //   "Work & Chores": [],
    //   "Social & Personal": ["Take photos"]
    // };
    GroupClass b = GroupClass(res);
    return b;
  }
}
