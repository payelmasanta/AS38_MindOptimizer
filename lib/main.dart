import 'package:flutter/material.dart';
import 'package:rwh_assistant/condition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RWH Assistant',
      home: Condition(),
    );
  }
}
