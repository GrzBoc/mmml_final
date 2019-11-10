import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: Text("About App"),
          )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/logo2.png'),
          ),
          Center(child: Text('We will help you to assess probability of your flight delay.\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
          Center(child: Text('If you are able to provide:\n', textAlign: TextAlign.center)),
          Center(child: Text('origination,\ndestination,\nairline,\nseason,\nday of week\nand\ntime of day\n', textAlign: TextAlign.center)),
          Center(child: Text('...then we will help you. ', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
