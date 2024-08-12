import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/services/db_service.dart';

enum LanguageEnum { en, it }

class DeleteAccountComponent extends StatefulWidget {
  // final
  DeleteAccountComponent({super.key});
  

  @override
  State<DeleteAccountComponent> createState() => _DeleteAccountComponentState();
}

class _DeleteAccountComponentState extends State<DeleteAccountComponent> {
  late TextEditingController deleteSecurity;
  bool buttonActive = false;
  DbService dbService = DbService();


  deleteAccount() async{
      try {
        await dbService.deleteAllDataFromAccount();
        var user = FirebaseAuth.instance.currentUser!;
        await FirebaseAuth.instance.signOut();
        await user.delete();
  
  } on FirebaseAuthException catch (e) {

    if (e.code == "requires-recent-login") {
    } else {
      // Handle other Firebase exceptions
    }
  } catch (e) {}
  }

  @override
  initState() {
    deleteSecurity = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
            child: ExpansionTile(title: Text('Delete account'), children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Text(
              "In order to delete your acocunt type 'DELETE', by deleting the account all the data connected to it will be lost? Are you sure you want to proceed?",
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: deleteSecurity,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'DELETE',
              ),
              onChanged: (val) => setState(()=>buttonActive = (val == 'DELETE')) 
              ,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: buttonActive ? deleteAccount  : null,
            child: const Text('Delete'),
          ),
          SizedBox(
            height: 10,
          ),
        ])));
  }
}
