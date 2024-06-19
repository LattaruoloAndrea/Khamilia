import 'package:flutter/material.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/db_service.dart';
// import 'package:gemini_app/components/shimmering_component.dart';
import 'package:gemini_app/services/gemini_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PeriodicyDataClass{
  List<String>? monday;
  List<String>? tuesday;
  List<String>? wednesday;
  List<String>? thursday;
  List<String>? friday;
  List<String>? saturday;
  List<String>? sunday;
  PeriodicyDataClass(dynamic message){
    try{ monday= message['monday'];}catch(e){monday=[];}
    try{ tuesday= message['tuesday'];}catch(e){tuesday=[];}
    try{ wednesday= message['wednesday'];}catch(e){wednesday=[];}
    try{ thursday= message['thursday'];}catch(e){thursday=[];}
    try{ friday= message['friday'];}catch(e){friday=[];}
    try{ saturday= message['saturday'];}catch(e){saturday=[];}
    try{ sunday= message['sunday'];}catch(e){sunday=[];}
  }

  setActivity(String day,String activity){

  }

  removeActivity(String day,String activity){

  }

}

class SetPeriodicyComponent extends StatefulWidget {
  // final

  SetPeriodicyComponent({super.key});

  @override
  State<SetPeriodicyComponent> createState() => _SetPeriodicyComponentState();
}

class _SetPeriodicyComponentState extends State<SetPeriodicyComponent> {
  late Future<PeriodicyDataClass> data;
  DbService db = DbService();

  @override
  void initState() {
    data = db.loadPeriodicy();
  }

  openModalFor() {}

  modifyAction(){}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
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
                      Row(children: [
                      Text(
                        "Periodic activity",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),IconButton(onPressed: modifyAction, icon: Icon(Icons.edit))
                      ],)
,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(),
                      ),
                      ExpansionTile(title: Text("Monday",style: TextStyle(fontWeight: FontWeight.w600),),children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                      children: List<Widget>.generate(
                        snapshot.data!.monday!.length,
                        (int idx) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              shape: StadiumBorder(side: BorderSide()),
                              // onDeleted: () {
                              //   setState(() {
                              //     removeActivity(widget.activitiesClass.activities![idx]);
                              //   });
                              // },
                              label:
                                  Text(snapshot.data!.monday![idx]),
                            ),
                          );
                        },
                      ).toList(),
                    )
                      ],),
                      ExpansionTile(title: Text("Tuesday",style: TextStyle(fontWeight: FontWeight.w600))),
                      ExpansionTile(title: Text("Wednsday",style: TextStyle(fontWeight: FontWeight.w600))),
                      ExpansionTile(title: Text("Thurday",style: TextStyle(fontWeight: FontWeight.w600))),
                      ExpansionTile(title: Text("Friday",style: TextStyle(fontWeight: FontWeight.w600))),
                      ExpansionTile(title: Text("Saturday",style: TextStyle(fontWeight: FontWeight.w600))),
                      ExpansionTile(title: Text("Sunday",style: TextStyle(fontWeight: FontWeight.w600))),
                      // ListView()
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
}
