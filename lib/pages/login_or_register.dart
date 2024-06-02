import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/components/my_button.dart';
import 'package:gemini_app/components/my_textfield.dart';
import 'package:gemini_app/components/squere_tile.dart';
import 'package:gemini_app/pages/login.dart';
import 'package:gemini_app/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPage();
}

class _LoginOrRegisterPage extends State<LoginOrRegisterPage> {
 
  bool showLoginPage = true;

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap:  togglePages,);
    }
        
  }
}
