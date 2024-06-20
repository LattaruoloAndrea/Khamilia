import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';
// import 'package:gemini_app/components/shimmering_component.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

enum WeekDays {
  monday(label: "Monday", key: "monday", acronim:"M"),
  tuesday(label: "Tuesday", key: "tuesday", acronim:"Tu"),
  wednesday(label: "Wednesday", key: "wednesday", acronim:"W"),
  thursday(label: "Thursday", key: "thursday", acronim:"Th"),
  friday(label: "Friday", key: "friday", acronim:"F"),
  saturday(label: "Saturday", key: "saturday", acronim:"Sa"),
  sunday(label: "Sunday", key: "sunday", acronim:"Su");

  const WeekDays({
    required this.label,
    required this.key,
    required this. acronim,
  });

  final String label;
  final String key;
  final String acronim;
}

class PeriodicyDataClass {
  List<String>? monday;
  List<String>? tuesday;
  List<String>? wednesday;
  List<String>? thursday;
  List<String>? friday;
  List<String>? saturday;
  List<String>? sunday;
  PeriodicyDataClass(dynamic message) {
    try {
      monday = message[WeekDays.monday.key];
    } catch (e) {
      monday = [];
    }
    try {
      tuesday = message[WeekDays.tuesday.key];
    } catch (e) {
      tuesday = [];
    }
    try {
      wednesday = message[WeekDays.wednesday.key];
    } catch (e) {
      wednesday = [];
    }
    try {
      thursday = message[WeekDays.thursday.key];
    } catch (e) {
      thursday = [];
    }
    try {
      friday = message[WeekDays.friday.key];
    } catch (e) {
      friday = [];
    }
    try {
      saturday = message[WeekDays.saturday.key];
    } catch (e) {
      saturday = [];
    }
    try {
      sunday = message[WeekDays.sunday.key];
    } catch (e) {
      sunday = [];
    }
  }

  setActivity(String day, String activity) {}

  removeActivity(String day, String activity) {}
}

class SetPeriodicyComponent extends StatefulWidget {
  // final

  SetPeriodicyComponent({super.key});

  @override
  State<SetPeriodicyComponent> createState() => _SetPeriodicyComponentState();
}

class _SetPeriodicyComponentState extends State<SetPeriodicyComponent> {
  // late Future<PeriodicyDataClass> data = await db.loadPeriodicy();
  // DbService db = DbService();
  // PeriodicyDataClass data=PeriodicyDataClass({});
  // bool modify = true;
  // bool removed = false;
  // bool added = false;
  // TextEditingController controller = TextEditingController();
  // Set<WeekDays> selection = <WeekDays>{WeekDays.monday};

  // @override
  // void initState() async{
  //   // PeriodicyDataClass data = await db.loadPeriodicy();
  //   // super.initState();
  //   // data = db.loadPeriodicy();
  //   // setState(() {
      
  //   // });
  // }

  // addActivity(List<String> days, String activity) {
  //   if (controller.text.isNotEmpty) {
  //     setState(() {
  //       added = true;
  //     });
  //   }
  // }

  // removeActivity(String day, String activity) {
  //   setState(() {
  //     removed = true;
  //   });
  // }

  // openModalFor() {}

  // modifyAction() {
  //   setState(() {
  //     modify = !modify;
  //     if (removed || added) {
  //       db.savePeriodicy();
  //       added = false;
  //       removed = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Text("sdasdsdsad");
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //       future: data,
  //       builder: (ctx, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
  //           // if (false) {
  //           if (snapshot.data == null) {
  //             return Text("Data not provided");
  //           } else {
  //             return Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //               child: Card(
  //                   child: SizedBox(
  //                 // height: ,
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Text(
  //                           "Periodic activity",
  //                           style: TextStyle(
  //                               fontSize: 26, fontWeight: FontWeight.bold),
  //                         ),
  //                         IconButton(
  //                             onPressed: modifyAction,
  //                             icon:
  //                                 modify ? Icon(Icons.edit) : Icon(Icons.save))
  //                       ],
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 20),
  //                       child: Divider(),
  //                     ),
  //                     modify
  //                         ? SizedBox()
  //                         : Column(
  //                             children: [
  //                               SegmentedButton<WeekDays>(
  //                                 segments: [
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.monday, label: Text("M")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.tuesday, label: Text("Tu")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.wednesday, label: Text("W")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.thursday, label: Text("Th")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.friday, label: Text("F")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.saturday, label: Text("Sa")),
  //                                   ButtonSegment<WeekDays>(
  //                                       value: WeekDays.sunday, label: Text("Su")),
  //                                 ],
  //                                 selected: selection,
  //                                 multiSelectionEnabled: true,
  //                                 onSelectionChanged: (newSelection) {
  //                                   setState(() {
  //                                     selection = newSelection;
  //                                   });
  //                                 },
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment: MainAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     width: 20,
  //                                   ),
  //                                   Expanded(
  //                                       child: TextField(
  //                                     controller: controller,
  //                                     decoration: InputDecoration(
  //                                         hintText: "Add activity",
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.grey[600])),
  //                                   )),
  //                                   Container(
  //                                     child: IconButton.filledTonal(
  //                                       onPressed: () => addActivity([], "sd"),
  //                                       icon: Icon(Icons.add),
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                     width: 20,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                     ExpansionTile(
  //                       title: Text(
  //                         WeekDays.monday.label,
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                       ),
  //                       children: [
  //                         Wrap(
  //                           alignment: WrapAlignment.start,
  //                           children: List<Widget>.generate(
  //                             snapshot.data!.monday!.length,
  //                             (int idx) {
  //                               return Padding(
  //                                 padding: EdgeInsets.symmetric(horizontal: 5),
  //                                 child: Chip(
  //                                   shape: StadiumBorder(side: BorderSide()),
  //                                   // onDeleted: () {
  //                                   //   setState(() {
  //                                   //     removeActivity(widget.activitiesClass.activities![idx]);
  //                                   //   });
  //                                   // },
  //                                   label: Text(snapshot.data!.monday![idx]),
  //                                 ),
  //                               );
  //                             },
  //                           ).toList(),
  //                         )
  //                       ],
  //                     ),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.tuesday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.wednesday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.thursday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.friday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.saturday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     ExpansionTile(
  //                         title: Text(WeekDays.sunday.label,
  //                             style: TextStyle(fontWeight: FontWeight.w600))),
  //                     // ListView()
  //                   ],
  //                 ),
  //               )),
  //             );
  //           }
  //         } else {
  //           return Text("Loading");
  //         }
  //       });
  // }
}
