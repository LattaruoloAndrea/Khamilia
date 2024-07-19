import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/components/set_periodicy_component.dart';
import 'package:gemini_app/services/current_day_service.dart';

class DbService {
  //TODO implements method insided here
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CurrentDayService timeService = CurrentDayService();

  String getUserUIDD() {
    User user = auth.currentUser!;
    String uid = user.uid;
    return uid;
  }

  Future<ActivitiesClass> queryFromTo(String start, String end) async {
    var listActivities = [
      ActivitiesClass().fromMessage({
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
      ActivitiesClass().fromMessage({
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
      ActivitiesClass().fromMessage(
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
      ActivitiesClass().fromMessage({
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
    var result = ActivitiesClass().fromMessage({
      "query": "",
      "type": "activities",
      "activities": activities,
      "emotions": emotions,
      "time": "yesterday"
    });
    return result;
  }

  Future<PeriodicyDataClass> loadPeriodicy() async {
    await Future.delayed(const Duration(seconds: 2));
    return PeriodicyDataClass({
      "monday": ["work", "gym"],
      "tuesday": ["work", "volleyball"],
      "wednesday": ["work", "gym"],
      "thursday": ["work", "volleyball"],
      "friday": ["work", "gym"],
      "saturday": ["gym"],
      "sunday": ["jogging"]
    });
  }

  Future savePeriodicy() async {
    await Future.delayed(const Duration(seconds: 2));
    // return PeriodicyDataClass({"monday":["work","gym"],"tuesday":["work","volleyball"],"wednsday":["work","gym"],"thursday":["work","volleyball"],"friday":["work","gym"],"saturday":["gym"],"sunday":["jogging"]});
  }

  Future<String> saveDailyOccurence(ActivitiesClass activity) async {
      //SAVE A DOCUMENT FIRST TIME
      var path = "usersData/${getUserUIDD()}/activities";
      var doc =await db.collection(path).add(activity.toFirestore());
      return doc.id;
  }

  Future updateDailyActivitiesActivities(
      String docId, List<String> activities) async {
    // UPDATE A DOCUMENT
    var path = "usersData/${getUserUIDD()}/activities";
    var doc = db.collection(path).doc(docId);
    doc.update({'activities': activities});
  }

  Future updateDailyActivitiesEmotions(
      String docId, List<String> emotions) async {
    // UPDATE A DOCUMENT
    var path = "usersData/${getUserUIDD()}/activities";
    var doc = db.collection(path).doc(docId);
    doc.update({'emotions': emotions});
  }

  Future dataExistsForTimeStamp(int timestamp) async {
    DateTime date = timeService.fromTimestapToDateTime(timestamp);
    int timestampStart = timeService.getdateStartDay(date);
    int timestampEnd = timeService.getdateEndDay(date);
    var path = "usersData/${getUserUIDD()}/activities";
    var querySnapshot = await db
        .collection(path)
        .where("timestamp", isGreaterThan: timestampStart)
        .where("timestamp", isLessThan: timestampEnd)
        .withConverter(
            fromFirestore: ActivitiesClass.fromFirestore,
            toFirestore: (ActivitiesClass activity, _) =>
                activity.toFirestore())
        .get();
    return querySnapshot.docChanges.first;

  }


  Future<String> changeDateOnActivity(ActivitiesClass activity) async{
    deleteActivity(activity.docId);
    String docId =await saveDailyOccurence(activity);
    return docId;
  }

  deleteActivity(String docId){
    var path = "usersData/${getUserUIDD()}/activities";
    db.collection(path).doc(docId).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  getData(timestampStart,timestampEnd){

  }

}
