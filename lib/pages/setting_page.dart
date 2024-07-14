import 'package:flutter/material.dart';
import 'package:gemini_app/components/delete_account_component.dart';
import 'package:gemini_app/components/my_drawer.dart';
import 'package:gemini_app/components/select_language_component.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'Settings Page',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SelectLanguageComponent(),
            DeleteAccountComponent(),
          ],
        )));
  }
}
