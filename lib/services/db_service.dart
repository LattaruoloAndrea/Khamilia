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
    int timestampStart = timeService.getdateStartDay(timeService.fromString(start));
    int timestampEnd = timeService.getdateEndDay(timeService.fromString(end));
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
    String description ="";
    List<String> activities = [];
    List<String> emotions = [];
    for(var el in querySnapshot.docs){
      ActivitiesClass temp = el.data();
      activities.addAll(temp.activities!);
      emotions.addAll(temp.emotions!);
      description += "${temp.description!}*@#@@#*"; //TODO add timestemp to see to wich description belong each day 
    }
    ActivitiesClass result = ActivitiesClass(activities: activities,description: description,emotions: emotions);
    return result;
  }

  Future<PeriodicyDataClass> loadPeriodicy() async {
    var path = "usersData/${getUserUIDD()}/periodicActivities";
    var querySnapshot = await db
        .collection(path)
        .withConverter(
            fromFirestore: PeriodicyDataClass.fromFirestore,
            toFirestore: (PeriodicyDataClass activity, _) =>
                activity.toFirestore())
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      var id = querySnapshot.docs.first.id;
      PeriodicyDataClass l = querySnapshot.docs.first.data();
      l.docId = id;
      return l;
    } else {
      PeriodicyDataClass l = PeriodicyDataClass(
          monday: [],
          tuesday: [],
          wednesday: [],
          thursday: [],
          friday: [],
          saturday: [],
          sunday: []);
      String id = await savePeriodicy(l);
      l.docId = id;
      return l;
    }
  }

  Future<String> savePeriodicy(PeriodicyDataClass data) async {
    if (data.docId!.isEmpty) {
      // First time
      var path = "usersData/${getUserUIDD()}/periodicActivities";
      var doc = await db.collection(path).add(data.toFirestore());
      return doc.id;
    } else {
      //updates
      var path = "usersData/${getUserUIDD()}/periodicActivities";
      var doc = db.collection(path).doc(data.docId!);
      var pp = data.toFirestore();
      doc.set(pp);
      return data.docId!;
    }
  }

  Future<ActivitiesClass> getTodayPeriodicyItem(int timestamp) async {
    var path = "usersData/${getUserUIDD()}/activities";
    var querySnapshot = await db
        .collection(path)
        .where("timestamp", isEqualTo: timestamp)
        .where("periodicActivity", isEqualTo: true)
        .withConverter(
            fromFirestore: ActivitiesClass.fromFirestore,
            toFirestore: (ActivitiesClass activity, _) =>
                activity.toFirestore())
        .get();
    return querySnapshot.docs.first.data();
  }

  Future<String> saveDailyOccurence(ActivitiesClass activity) async {
    //SAVE A DOCUMENT FIRST TIME
    var path = "usersData/${getUserUIDD()}/activities";
    var doc = await db.collection(path).add(activity.toFirestore());
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

  Future<String> changeDateOnActivity(ActivitiesClass activity) async {
    deleteActivity(activity.docId);
    String docId = await saveDailyOccurence(activity);
    return docId;
  }

  deleteActivity(String docId) {
    var path = "usersData/${getUserUIDD()}/activities";
    db.collection(path).doc(docId).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  getData(timestampStart, timestampEnd) {}

  Future<String> savePeriodicActivityOnce(ActivitiesClass activiy) async {
    var path = "usersData/${getUserUIDD()}/activities";
    String createdId = await periodicyDailyAlreadySaved(activiy.timestamp!);
    if (createdId.isEmpty) {
      //create new data
      String docId = await saveDailyOccurence(activiy);
      createdId = docId;
    }
    return createdId;
  }

  Future<String> periodicyDailyAlreadySaved(int timestamp) async {
    //DateTime date = timeService.fromTimestapToDateTime(timestamp);
    //int timestampStart = timeService.getdateStartDay(date);
    //int timestampEnd = timeService.getdateEndDay(date);
    var path = "usersData/${getUserUIDD()}/activities";
    var querySnapshot = await db
        .collection(path)
        .where("timestamp", isEqualTo: timestamp)
        //.where("timestamp", isLessThan: timestampEnd)
        //.where("periodicActivity", isEqualTo: true)
        .orderBy("timestamp", descending: true)
        .limit(1)
        .withConverter(
            fromFirestore: ActivitiesClass.fromFirestore,
            toFirestore: (ActivitiesClass activity, _) =>
                activity.toFirestore())
        .get();
    if (querySnapshot.docs.isEmpty) {
      return "";
    } else {
      return querySnapshot.docs.first.id;
    }
  }

  Future<ActivitiesClass> getActivityFromDocId(String docId) async{
    var path = "usersData/${getUserUIDD()}/activities";
    var act = await db
        .collection(path)
        .doc(docId)
        .withConverter(
            fromFirestore: ActivitiesClass.fromFirestore,
            toFirestore: (ActivitiesClass activity, _) =>
                activity.toFirestore())
        .get();
    return act.data()!;
  }


  Future<dynamic> deleteAllDataFromAccount() async{
    var path = "usersData";
    var docId = getUserUIDD();
    db.collection(path).doc(docId).delete().then(
          (doc) => print("Data for account deleted!"),
          onError: (e) => print("Error on deleting account $e"),
        );
  }

}
