import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

enum LanguageEnum { en, it }

class SelectLanguageComponent extends StatefulWidget {
  // final
  SelectLanguageComponent({super.key});

  @override
  State<SelectLanguageComponent> createState() =>
      _SelectLanguageComponentState();
}

class _SelectLanguageComponentState extends State<SelectLanguageComponent> {
  String? currentLang = localStorage.getItem('lang') ?? 'en';
  LanguageEnum? _character;
  @override
  initState() {
    if (currentLang == 'en') {
      _character = LanguageEnum.en;
    } else {
      _character = LanguageEnum.it;
    }
  }

  setLocalStorage(LanguageEnum value) {
    if (value == LanguageEnum.it) {
      localStorage.setItem('lang', 'it');
    } else {
      localStorage.setItem('lang', 'en');
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
                        setLocalStorage(value!);
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
                        setLocalStorage(value!);
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
