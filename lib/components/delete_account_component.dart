import 'package:flutter/material.dart';

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
  deleteAccount() {}

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
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "In order to delete your acocunt type 'DELETE'",
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
