import 'package:flutter/material.dart';
import 'package:gemini_app/components/delete_account_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/select_language_component.dart';
import 'package:lottie/lottie.dart';

class DataAnalysisPage extends StatelessWidget {
  const DataAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              "Kamilia",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            backgroundColor: Colors.pink[300]),
        drawer: MyDrawer(),
        body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     alignment: Alignment.center,
            //     image: AssetImage("lib/images/analysis.png"),
            //     // fit: BoxFit.cover,
            //   ),
            // ),
            child: SafeArea(
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    'Data analysis page',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    'In this page it will be possible for you to analyze if there is any correlations between your activies and your emotions, maybe some activities might have a slight influence on some of your emotions!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                  
                  ),
                ),
                Image.asset("lib/images/analysis.png"),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    'We need to collect more information about your activities and emotions before giving some valuable results, keep logging your activities and emotions regurarly to speed up the process!',
                    textAlign: TextAlign.center,
                  
                  ),
                ),
                // Center(child: Lottie.asset("lib/images/loading_component.json"))
              ],
            ))));
  }
}
