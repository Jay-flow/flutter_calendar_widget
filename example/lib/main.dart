import 'package:example/screens/basic_demo_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_calendar_widget demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BasicDemoScreen(),
    );
  }
}
