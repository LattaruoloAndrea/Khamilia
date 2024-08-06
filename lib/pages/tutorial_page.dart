import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/delete_account_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/select_language_component.dart';
import 'package:gemini_app/pages/home_page.dart';
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

  finishTutorial() {
    localStorage.setItem("firstLogin", "firstLogin");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    TutorialPageSlide pageOne = TutorialPageSlide(
        name: "A journey starts",
        description:
            "Khamilia is your personal journal assistant, it will help you track events of your life and you will be able to look and analyze your data, we will try to provide also some insights of your daily life. So ready to begin?",
        description2:
            "We suggest to give a quick look at this tutorial but in case you can always look at it by asking for help in chat.",
        imagePath: "lib/images/welcome.png",
        index: 0,
        color: Colors.yellow.shade300);
    TutorialPageSlide pageTwo = TutorialPageSlide(
        name: "Activities and emotions",
        description:
            "Everybody it's always busy running errands balancing work and social life going through a rollerkoster of emotions. With Khami you can keep track of your activities and emotions!",
        description2:
        // Remember you can log the your day or yesterday,you cannot go any further back. In the chat type something like: 'Today after leaving for work I went for a jog and after met with some friends even thought I was tired I was happy to see my friends' then you can be as describing or syntetic as you want. You can keep track of your periodic activities all these activities that occur periodically in your life like work, sports, ect. N.B. periodic activities will be saved just if you enter the app, if you don't they will not be saved!
            "You can log the activities/emotions for the current day or the past day, no other days will be taken, to log you can type on the chat: 'Today I did this activities and I felt in this way then that ect...'. Use periodic activities to log your routine activies,those are saved when you enter the chat.",
        imagePath: "lib/images/activities.jpg",
        index: 1,
        color: Colors.green.shade300);
    TutorialPageSlide pageThree = TutorialPageSlide(
        name: "Progressions",
        description: "If we're talking about sports there are exercices which we repeat periodically maybe over the time we want to see the progress that we did.",
        description2: "In the chat type something like: 'For my progression in the running today I completed the 5km in 27 minutes and 20 seconds', your should provide a categogy to which the progression belongs, like running,swimming,cym, ect...Also it is possible to track one execise per time as for now so keep it in mind!",
        imagePath: "lib/images/progression.png",
        index: 2,
        color: Colors.blue.shade300);
    TutorialPageSlide pageFour = TutorialPageSlide(
        name: "Using the khami chat",
        description: "With the chat is possible record your daily entry, record the progression, ask for help, perform simple query (but this can also be done using the activities page).",
        description2: "If you type something that it is not of the one specified it khami should respond with an warning response!",
        imagePath: "lib/images/flamingo_screen.png",
        index: 3,
        color: Colors.orange.shade300);
    TutorialPageSlide pageFive = TutorialPageSlide(
        name: "Keep it going",
        description: "We are happy to have you on board, we suggest to log regularly your days in order to get better data quality for the analysis tool. In the end is as simple as to write to a friend what you did today.",
        description2: "Bonus trick don't type it twice if in different chat you already wrote your day try to copy it and use it here wih what is missing!",
        imagePath: "lib/images/bird_g.png",
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
                            flex: 9,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30, right: 30, top: 90, bottom: 30),
                                  child: Text(
                                    i.name,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        i.description,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        height: 200,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Image.asset(
                                          i.imagePath,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(i.description2),
                                    ))
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                      onPressed: finishTutorial,
                                      child: Text('SKIP'))),
                              Expanded(
                                  flex: 1,
                                  child: DotsIndicator(
                                    dotsCount: 5,
                                    position: currentIndex,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: i.isEnd
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: FilledButton(
                                            onPressed: finishTutorial,
                                            child: Text('FINISH'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll<Color>(
                                                      Colors.blueAccent),
                                            ),
                                          ),
                                        )
                                      : SizedBox()),
                            ]))
                      ],
                    ));
              },
            );
          }).toList(),
        ));
  }
}
