import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/pages/setting_page.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
// https://ai.google.dev/gemini-api/docs/get-started/tutorial?lang=dart
  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  void openMenu() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(height:  40),
            Center(child: Text('Welcome, you are logged in')),
            SizedBox(height:  40),
            // https://lottiefiles.com/animations/flamingo-v2lht2pMje
            Center(child: Lottie.asset("lib/images/flamingo.json")),
            SizedBox(height:  40),
            Center(child: Text('Welcome, you are logged in'))
          ],
        )));
  }
}
