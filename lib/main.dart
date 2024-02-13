import 'package:flutter/material.dart';
import 'package:flutter_application_1/localization/locales.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_localization/flutter_localization.dart';

void main() async {
 // Register the adapter for Task
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final FlutterLocalization localization = FlutterLocalization.instance;
  @override
  void initState() {
    // TODO: implement initState
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    //  theme: ThemeData.dark(),
      //supportedLocales: L10n.all,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home: const Padding(
        
        padding: EdgeInsets.symmetric(vertical:0.0, horizontal:5.0),
        child: HomePage(),
      ),
    );
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: 'en');
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }
 
  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
