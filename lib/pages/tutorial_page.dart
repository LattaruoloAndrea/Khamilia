import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/delete_account_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/select_language_component.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lottie/lottie.dart';

class TutorialPageSlide {
  final String name;
  final String description;
  final String description2;
  final String imagePath;
  final int index;
  bool isEnd = false;
  final Color color;
  TutorialPageSlide({
    required this.name,
    required this.description,
    required this.description2,
    required this.imagePath,
    required this.color,
    required this.index,
  });
}

class TutorialPage extends StatefulWidget {
  TutorialPage();

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  //TutorialPage({super.key});
  int currentIndex = 0;

  finishTutorial(){
    localStorage.setItem("firstLogin", "firstLogin");
  }

  @override
  Widget build(BuildContext context) {
    TutorialPageSlide pageOne = TutorialPageSlide(
        name: "Welcome",
        description: "On thi app you can do different stuff...",
        description2: "",
        imagePath: "lib/images/welcome.png",
        index: 0,
        color: Colors.yellow.shade300);
    TutorialPageSlide pageTwo = TutorialPageSlide(
        name: "Activities",
        description: "With the activities ...",
        description2: "",
        imagePath: "lib/images/activities.png",
        index: 1,
        color: Colors.green.shade300);
    TutorialPageSlide pageThree = TutorialPageSlide(
        name: "Progressions",
        description: "With the activities ...",
        description2: "",
        imagePath: "lib/images/welcome.png",
        index: 2,
        color: Colors.blue.shade300);
    TutorialPageSlide pageFour = TutorialPageSlide(
        name: "Using the khami chat",
        description: "With the chat is possible ...",
        description2: "",
        imagePath: "lib/images/welcome.png",
        index: 3,
        color: Colors.orange.shade300);
    TutorialPageSlide pageFive = TutorialPageSlide(
        name: "End",
        description: "With the activities ...",
        description2: "",
        imagePath: "lib/images/welcome.png",
        index: 4,
        color: Colors.pink.shade300);
    pageFive.isEnd = true;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CarouselSlider(
          options: CarouselOptions(
              height: MediaQuery.sizeOf(context).height,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              enableInfiniteScroll: true,
              viewportFraction: 1.03),
          items: [pageOne, pageTwo, pageThree, pageFour, pageFive]
              .map((TutorialPageSlide i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: i.color),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              i.name,
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                          "${i.description}, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 1,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: 200,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Image.asset(i.imagePath,),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Text(
                                          "${i.description2}, description2"),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: i.isEnd ? Text("END") : SizedBox(),
                        ),
                        Expanded(
                            flex: 1,
                            child: DotsIndicator(
                              dotsCount: 5,
                              position: currentIndex,
                            ))
                      ],
                    ));
              },
            );
          }).toList(),
        ));
  }
}
