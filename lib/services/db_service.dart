import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';

class DbService {
  //TODO implements method insided here
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ActivitiesClass> queryFromTo(String start, String end) async {
    var listActivities = [
      ActivitiesClass({
        "query":
            "Hey Kami, I woke up early, had a quick breakfast, went for a run, and started working on a new project.",
        "type": "activities",
        "emotions": [],
        "activities": [
          "woke up early",
          "had breakfast",
          "went for a run",
          "started working on a new project"
        ],
        "time": "today"
      }),
      ActivitiesClass({
        "query":
            "today I started the day with a meditation session, which left me feeling calm and focused. I worked on some creative projects, which felt inspiring and fulfilling. I finished with a quiet evening reading, which left me feeling peaceful and content.",
        "type": "activities",
        "activities": [
          "meditation session",
          "creative projects",
          "quiet evening reading"
        ],
        "emotions": [
          "calm",
          "focused",
          "inspiring",
          "fulfilling",
          "peaceful",
          "content"
        ],
        "time": "today"
      }),
      ActivitiesClass(
        {
          "query":
              "Yesterday I had a productive meeting in the morning, which made me feel confident. I grabbed lunch with colleagues, which was enjoyable and relaxing. I finished the day with a workout, which left me feeling refreshed.",
          "type": "activities",
          "activities": [
            "productive meeting",
            "grabbed lunch with colleagues",
            "workout"
          ],
          "emotions": ["confident", "enjoyable", "relaxed", "refreshed"],
          "time": "yesterday"
        },
      ),
      ActivitiesClass({
        "query":
            "Yesterday I ran some errands, which felt productive and efficient. I managed to squeeze in a quick workout, which boosted my energy. I enjoyed a relaxing bath before bed, which left me feeling calm and peaceful.",
        "type": "activities",
        "activities": ["ran some errands", "quick workout", "relaxing bath"],
        "emotions": ["productive", "efficient", "boosted", "calm", "peaceful"],
        "time": "yesterday"
      })
    ];
    List<String> activities = [];
    List<String> emotions = [];
    for (int i = 0; i < listActivities.length; i++) {
      if (listActivities[i].activities != null &&
          listActivities[i].activities!.isNotEmpty) {
        activities.addAll(listActivities[i].activities!);
      }
      if (listActivities[i].emotions != null &&
          listActivities[i].emotions!.isNotEmpty) {
        emotions.addAll(listActivities[i].emotions!);
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    var result = ActivitiesClass({        
      "query":
            "",
        "type": "activities",
      "activities": activities,
      "emotions": emotions,
      "time": "yesterday"
    });
    return result;
  }

  Future<PeriodicyDataClass> loadPeriodicy() async {
    await Future.delayed(const Duration(seconds: 2));
    return PeriodicyDataClass({"monday":["work","gym"],"tuesday":["work","volleyball"],"wednsday":["work","gym"],"thursday":["work","volleyball"],"friday":["work","gym"],"saturday":["gym"],"sunday":["jogging"]});

  }
}
