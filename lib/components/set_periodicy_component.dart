import 'package:flutter/material.dart';
import 'package:gemini_app/services/db_service.dart';

enum WeekDays {
  monday(label: "Monday", key: "monday", acronim: "M"),
  tuesday(label: "Tuesday", key: "tuesday", acronim: "Tu"),
  wednesday(label: "Wednesday", key: "wednesday", acronim: "W"),
  thursday(label: "Thursday", key: "thursday", acronim: "Th"),
  friday(label: "Friday", key: "friday", acronim: "F"),
  saturday(label: "Saturday", key: "saturday", acronim: "Sa"),
  sunday(label: "Sunday", key: "sunday", acronim: "Su");

  const WeekDays({
    required this.label,
    required this.key,
    required this.acronim,
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
    monday = [];
    tuesday = [];
    wednesday = [];
    thursday = [];
    friday = [];
    saturday = [];
    sunday = [];
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

  addActivities(List<String> days, String activity) {
    if (days.contains("monday")) {
      monday ??= [];
      monday!.add(activity);
    }
    if (days.contains("tuesday")) {
      tuesday ??= [];
      tuesday!.add(activity);
    }
    if (days.contains("wednesday")) {
      wednesday ??= [];
      wednesday!.add(activity);
    }
    if (days.contains("thursday")) {
      thursday ??= [];
      thursday!.add(activity);
    }
    if (days.contains("friday")) {
      friday ??= [];
      friday!.add(activity);
    }
    if (days.contains("saturday")) {
      saturday ??= [];
      saturday!.add(activity);
    }
    if (days.contains("sunday")) {
      sunday ??= [];
      sunday!.add(activity);
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
  //late Future<PeriodicyDataClass> data;// = await db.loadPeriodicy();
  DbService db = DbService();
  late Future<PeriodicyDataClass> currentData;
  late PeriodicyDataClass oldData;
  bool modify = true;
  bool removed = false;
  bool added = false;
  bool expandAll = false;
  late ExpansionTileController mondayController;

  @override
  void initState() {
    mondayController = ExpansionTileController();
    currentData = db.loadPeriodicy();
    currentData.then(setOldData);
  }

  setOldData(PeriodicyDataClass data) {
    oldData = data;
  }

  addActivity(List<String> days, String activity) {
    setState(() {
      added = true;
      currentData.then((x) => {x.addActivities(days, activity)});
    });
  }

  removeActivity(String day, String activity) {
    setState(() {
      removed = true;
    });
  }

  expand() {
    setState(() {
      expandAll = !expandAll;
      if (expandAll) {
        mondayController.collapse();
      } else {
        mondayController.expand();
      }
    });
  }

  openModalFor() {}

  saveModifications() {
    setState(() {
      modify = !modify;
      if (removed || added) {
        currentData.then((x) => {oldData = x});
        db.savePeriodicy();
        added = false;
        removed = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Modifications saved!")));
      }
    });
  }

  discardModifications() {
    setState(() {
      currentData.then((x) => {x = oldData});
      added = false;
      removed = false;
      modify = !modify;
    });
  }

  //   @override
  // Widget build(BuildContext context) {
  //   return Text("data");
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: currentData,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if (false) {
            if (snapshot.data == null) {
              return Text("Data not provided");
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Card(
                    child: SizedBox(
                  // height: ,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Periodic activity",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                          modify
                              ? IconButton(
                                  onPressed: saveModifications,
                                  icon: Icon(Icons.edit))
                              : Row(
                                  children: [
                                    IconButton(
                                        onPressed: saveModifications,
                                        icon: Icon(Icons.save)),
                                    // IconButton(
                                    //     onPressed: discardModifications,
                                    //     icon: Icon(Icons.undo))
                                  ],
                                ),
                          Expanded(child: Container()),
                          // IconButton(
                          //   onPressed: expand,
                          //   icon: expandAll? Icon(Icons.keyboard_double_arrow_down): Icon(Icons.keyboard_double_arrow_up))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      modify
                          ? SizedBox()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                AddPeriodicyComponent(
                                  addData: addActivity,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                      _personalTile(WeekDays.monday, snapshot.data!.monday!),
                      _personalTile(WeekDays.tuesday, snapshot.data!.tuesday!),
                      _personalTile(
                          WeekDays.wednesday, snapshot.data!.wednesday!),
                      _personalTile(
                          WeekDays.thursday, snapshot.data!.thursday!),
                      _personalTile(WeekDays.friday, snapshot.data!.friday!),
                      _personalTile(
                          WeekDays.saturday, snapshot.data!.saturday!),
                      _personalTile(WeekDays.sunday, snapshot.data!.sunday!),
                    ],
                  ),
                )),
              );
            }
          } else {
            return Text("Loading");
          }
        });
  }

  Widget _personalTile(WeekDays day, List<String> activities) {
    return ExpansionTile(
      // controller: mondayController,
      title: Text(
        day.label,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          children: List<Widget>.generate(
            activities.length,
            (int idx) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: !modify
                    ? Chip(
                        shape: StadiumBorder(side: BorderSide()),
                        onDeleted: () {
                          setState(() {
                            removeActivity(day.label, activities[idx]);
                          });
                        },
                        label: Text(activities[idx]),
                      )
                    : Chip(
                        shape: StadiumBorder(side: BorderSide()),
                        label: Text(activities[idx]),
                      ),
              );
            },
          ).toList(),
        )
      ],
    );
  }
}

class AddPeriodicyComponent extends StatefulWidget {
  // final
  Function addData;
  AddPeriodicyComponent({super.key, required this.addData});

  @override
  State<AddPeriodicyComponent> createState() => _AddPeriodicyComponent();
}

class _AddPeriodicyComponent extends State<AddPeriodicyComponent> {
  TextEditingController controller = TextEditingController();
  Set<WeekDays> selection = <WeekDays>{WeekDays.monday};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  addActivity() {
    if (controller.text.isNotEmpty) {
      widget.addData(
          selection.toList(growable: false).map((x) => x.key).toList(),
          controller.text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                    "Add your periodic activities selecting the days of the week from monday to sunday then type the activity and add it! You can also remove the activies by clicking on them. When finished click on the save icon in order to save all the modifications."),
              ),
              SegmentedButton<WeekDays>(
                segments: [
                  ButtonSegment<WeekDays>(
                      value: WeekDays.monday, label: Text("M")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.tuesday, label: Text("T")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.wednesday, label: Text("W")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.thursday, label: Text("T")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.friday, label: Text("F")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.saturday, label: Text("S")),
                  ButtonSegment<WeekDays>(
                      value: WeekDays.sunday, label: Text("S")),
                ],
                selected: selection,
                multiSelectionEnabled: true,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    selection = newSelection;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: "Add activity",
                        hintStyle: TextStyle(color: Colors.grey[600])),
                  )),
                  Container(
                    child: IconButton.filledTonal(
                      onPressed: addActivity,
                      icon: Icon(Icons.add),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
