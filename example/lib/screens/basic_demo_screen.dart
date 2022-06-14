import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/flutter_calendar_widget.dart';

class BasicDemoScreen extends StatefulWidget {
  const BasicDemoScreen({Key? key}) : super(key: key);

  @override
  State<BasicDemoScreen> createState() => _BasicDemoScreenState();
}

class _BasicDemoScreenState extends State<BasicDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic demo screen'),
      ),
      body: const SafeArea(
        child: FlutterCalendar(),
      ),
    );
  }
}
