import 'package:flutter/material.dart';
import 'package:gbapka3/pages/about.dart';
import 'package:gbapka3/pages/signin.dart';
import 'package:gbapka3/pages/signup.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Flight Delay App"),
      )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/logo.png'),
          ),
          RaisedButton(
            onPressed: toSignIn,
            child: Text('Sign In'),
            color: Colors.redAccent,
            textColor: Colors.white,
          ),
          RaisedButton(
            onPressed: toSignUp,
            child: Text('Sign Up'),
            color: Colors.cyan,
            textColor: Colors.white,
          ),
          RaisedButton(
            onPressed: toAbout,
            child: Text('About'),
            color: Colors.grey[400],
            textColor: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

void toSignIn(){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
}

void toSignUp(){
  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
}

void toAbout(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage(), fullscreenDialog: true));
  }

}