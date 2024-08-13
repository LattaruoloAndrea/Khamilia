import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini_app/components/activity_chart_component.dart';
import 'package:gemini_app/components/emotions_component.dart';
import 'package:gemini_app/components/message_class.dart';
import 'package:gemini_app/services/current_day_service.dart';
import 'package:gemini_app/services/db_service.dart';

class ProgressionMessageComponent extends StatefulWidget {
  // final
  ProgressionClass progressionClass;

  ProgressionMessageComponent({super.key, required this.progressionClass});

  @override
  State<ProgressionMessageComponent> createState() =>
      _ProgressionMessageComponentState();
}

class _ProgressionMessageComponentState
    extends State<ProgressionMessageComponent> {
  bool modify = false;
  CurrentDayService dayService = CurrentDayService();
  DbService dbService = DbService();
  bool actualModifyActivity = false;
  TextEditingController controllerCategory = TextEditingController();
  TextEditingController controllerExercise = TextEditingController();
  TextEditingController addCategoryController = TextEditingController();
  TextEditingController addExerciseController = TextEditingController();
  TextEditingController resultValueController = TextEditingController();
  TextEditingController resultUnitMeausureController = TextEditingController();
  List<List<TextEditingController>> paramsListController = [];
  List<String> allExercises = [];

  @override
  void initState() {
    allExercises = widget.progressionClass
                            //   'backstroke',
                            //   'freestyle',
                            //   'breaststroke',
                            //   'butterfly'
                            // ], //widget.progressionClass.allCategories!
        .exercisesPerCategory![widget.progressionClass.category!]!;
    widget.progressionClass.dayTimestamp =
        dayService.getdateHalfDay(dayService.currentDate());
    resultValueController.text = widget.progressionClass.exercise!.result!;
    resultUnitMeausureController.text =
        widget.progressionClass.exercise!.resultUnitMeasure!;
  }

  modifyActivity() {
    setState(() {
      modify = true;
      resultValueController.text = widget.progressionClass.exercise!.result!;
      resultUnitMeausureController.text =
          widget.progressionClass.exercise!.resultUnitMeasure!;
      if (paramsListController.isEmpty) {
        //initialize just first time
        for (var param in widget.progressionClass.exercise!.params) {
          TextEditingController controllerValue = TextEditingController();
          TextEditingController controllerName = TextEditingController();
          controllerValue.text = param['value'];
          controllerName.text = param['name'];
          paramsListController.add([controllerName, controllerValue]);
        }
      }
    });
  }

  saveActivity() {
    if (actualModifyActivity) {
      //TODO call save in the Db
    }

    setState(() {
      modify = false;
      actualModifyActivity = false;
    });
  }

  addCategory() {
    setState(() {
      var newCategory = addCategoryController.text;
      widget.progressionClass.allCategories.add(newCategory);
      controllerCategory.text = newCategory;
      addCategoryController.text = "";
      actualModifyActivity = true;
    });
  }

  addExercise() {
    setState(() {
      var newExercise = addExerciseController.text;
      allExercises = widget
          .progressionClass.exercisesPerCategory[controllerCategory.text]!;
      allExercises.add(newExercise);
      controllerExercise.text = newExercise;
      addExerciseController.text = "";
      actualModifyActivity = true;
    });
  }

  deleteParam(param) {
    // TODO
    setState(() {
      paramsListController.remove(param);
      actualModifyActivity = true;
    });
  }

  addNewParameter() {
    setState(() {
      TextEditingController controllerValue = TextEditingController();
      TextEditingController controllerName = TextEditingController();
      paramsListController.add([controllerName, controllerValue]);
      actualModifyActivity = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Progression",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.auto_awesome_sharp,
              size: 40,
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Divider(
              thickness: 2,
              color: Colors.black,
            )),
        SizedBox(
          height: 3,
        ),
        !modify
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                              'Here is the info extracted from your message if you want to modify something edit by clicking on the edit button on the right!'),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: IconButton.filledTonal(
                              onPressed: modifyActivity,
                              icon:
                                  modify ? Icon(Icons.save) : Icon(Icons.edit),
                              color: Colors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Category:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(widget.progressionClass.category!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Exercise:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(widget.progressionClass.exercise!.name!,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Params',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  for (var param in widget.progressionClass.exercise!.params)
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('Name:'),
                            )),
                        Expanded(flex: 2, child: Text("${param['name']},")),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text('Value:'),
                            )),
                        Expanded(flex: 2, child: Text("${param['value']}"))
                      ],
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Result:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(
                              '${widget.progressionClass.exercise!.result!} ${widget.progressionClass.exercise!.resultUnitMeasure!}',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w600)))
                    ],
                  ),
                  //SizedBox(height: 10,),
                  //Row(children: [Expanded(flex: 2, child: Padding(padding: EdgeInsets.only(left: 20),child: Text('Result:'),) ),Expanded(flex: 2, child: Text("${widget.progressionClass.exercise!.result!},")),Expanded(flex: 1,child: SizedBox()),Expanded(flex: 2, child: Padding(padding: EdgeInsets.only(left: 20),child: Text('UnitMeasure:'),)),Expanded(flex: 2, child: Text("${widget.progressionClass.exercise!.resultUnitMeasure!}"))],),
                ],
              )
            : Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                            'Click on the save button to save the edits otherwise all the edits will be lost!'),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: IconButton.filledTonal(
                            onPressed: saveActivity,
                            icon: modify ? Icon(Icons.save) : Icon(Icons.edit),
                            color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Category:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownMenuExample(
                              controller: controllerCategory,
                              list: widget.progressionClass.allCategories,
                              // [
                              //   'swimming',
                              //   'gym',
                              //   'running'
                              // ], //
                              initialValue: widget.progressionClass.category!,
                            ))),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: false,
                            controller: addCategoryController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Add new category',
                            ),
                          ),
                        )),
                    //Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: IconButton.filledTonal(
                            onPressed: addCategory,
                            icon: Icon(Icons.add),
                            color: Colors.black)),
                    //Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Expanded(
                          flex: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Exercise:',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownMenuExample(
                            controller: controllerExercise,
                            list: allExercises,
                            //  [
                            //   'backstroke',
                            //   'freestyle',
                            //   'breaststroke',
                            //   'butterfly'
                            // ], //widget.progressionClass.allCategories!
                            initialValue:
                                widget.progressionClass.exercise!.name!,
                          ))),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: false,
                            controller: addExerciseController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Add new exercise',
                            ),
                          ),
                        )),
                    //Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 1,
                        child: IconButton.filledTonal(
                            onPressed: addExercise,
                            icon: Icon(Icons.add),
                            color: Colors.black)),
                    //Expanded(flex: 1, child: SizedBox()),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Params',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                for (var param in paramsListController)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                obscureText: false,
                                controller: param[0],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: TextField(
                                obscureText: false,
                                controller: param[1],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Value',
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 1,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: IconButton(
                                  onPressed: () => deleteParam(param),
                                  icon: Icon(Icons.delete),
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Add new parameter'))),
                    Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: IconButton.filledTonal(
                              onPressed: addNewParameter,
                              icon: Icon(Icons.add),
                              color: Colors.black)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Result:',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            obscureText: false,
                            controller: resultValueController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Value result',
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          obscureText: false,
                          controller: resultUnitMeausureController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Unit mesure result',
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ])
      ],
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  final List<String> list;
  final String initialValue;
  final TextEditingController controller;
  const DropdownMenuExample(
      {super.key,
      required this.list,
      required this.initialValue,
      required this.controller});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: widget.initialValue,
      controller: widget.controller,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
