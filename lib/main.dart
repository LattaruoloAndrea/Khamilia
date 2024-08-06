import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/l10n/l10n.dart';
import 'package:gemini_app/pages/auth_page.dart';
import 'package:gemini_app/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localstorage/localstorage.dart';


// cd ~/Documents/android-studio/bin
// sh studio.sh
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await initLocalStorage();
  // var notifier = ValueNotifier(localStorage.getItem('lang') ?? 'en');
  // notifier.addListener(listener)
  // String? lang = localStorage.getItem('lang');
  // lang ??= 'en';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final FlutterLoc localization = FlutterLocalization.instance;
  //final String lang;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Khamilia',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        locale: Locale(localStorage.getItem('lang') ?? 'en'),
        home: AuthPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: AuthPage()
      );
  }
}