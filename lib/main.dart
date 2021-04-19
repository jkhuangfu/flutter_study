import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/pages/home_page.dart';
import 'package:flutter_study/pages/login_page.dart';

void main() {
  // 禁止横屏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new StudyApp());
  });
}

class StudyApp extends StatelessWidget {
  const StudyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter study',
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}
