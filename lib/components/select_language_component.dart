import 'package:flutter/material.dart';

enum LanguageEnum { en, it }

class SelectLanguageComponent extends StatefulWidget {
  // final
  String currentLang = 'en';
  SelectLanguageComponent({super.key, currentLang});

  @override
  State<SelectLanguageComponent> createState() =>
      _SelectLanguageComponentState();
}

class _SelectLanguageComponentState extends State<SelectLanguageComponent> {
  String? currentLang;
  LanguageEnum? _character;
  @override
  initState() {
    currentLang = widget.currentLang;
    if(currentLang=='en'){
      _character = LanguageEnum.en;
    }else{
      _character = LanguageEnum.it;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: ExpansionTile(title: Text('Select Language'), children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('English'),
                  leading: Radio<LanguageEnum>(
                    value: LanguageEnum.en,
                    groupValue: _character,
                    onChanged: (LanguageEnum? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Italian'),
                  leading: Radio<LanguageEnum>(
                    value: LanguageEnum.it,
                    groupValue: _character,
                    onChanged: (LanguageEnum? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
