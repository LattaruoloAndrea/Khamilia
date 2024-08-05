import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/main.dart';
import 'package:gemini_app/pages/home_page.dart';
import 'package:gemini_app/pages/login.dart';
import 'package:gemini_app/pages/login_or_register.dart';
import 'package:gemini_app/pages/tutorial_page.dart';
import 'package:gemini_app/services/chat_servie.dart';
import 'package:localstorage/localstorage.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  // ChatService _chatService = ChatService();
  String firstLogin = localStorage.getItem('firstLogin') ?? "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(firstLogin.isEmpty){
              return TutorialPage();
            }else{
              return HomePage();

            }
          }else{
            return LoginOrRegisterPage();
          }}),
      );
  }
}
