import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbapka3/pages/payment.dart';
import 'package:gbapka3/pages/starting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Profile', textAlign: TextAlign.left),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.flight_takeoff  , color: Colors.white, size: 40),
            onPressed: toPayment,),
          IconButton(
            icon: Icon(Icons.exit_to_app  , color: Colors.white, size: 40),
            onPressed: signout,),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            color: Colors.deepOrange,
            size: 125.0,),
          Center(child: Text('User:', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24),)),
          Center(child: Text('${widget.user.email}', textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24),)),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void toPayment(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentPage(user: widget.user)));
  }

  void signout(){
    try {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } catch(e){
      print(e.message);
    }
  }
}