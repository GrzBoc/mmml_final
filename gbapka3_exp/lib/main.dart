import 'package:flutter/material.dart';
import 'package:gbapka3/pages/starting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'gbapka3',
      theme:  ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home:  WelcomePage(),
    );
  }
}
