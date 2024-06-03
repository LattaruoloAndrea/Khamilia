import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  void signOutUser() {
    FirebaseAuth.instance.signOut();
  }

  void openMenu(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
