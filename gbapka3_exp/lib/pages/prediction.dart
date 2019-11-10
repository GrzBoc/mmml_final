import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbapka3/pages/payment.dart';
import 'package:gbapka3/pages/profile.dart';
import 'package:gbapka3/pages/starting.dart';
import 'package:gbapka3/pages/dictionaries/constants.dart' as Constants;

class PredictionPage extends StatefulWidget {
  const PredictionPage({
    Key key,
    @required this.user,
    @required this.in_from,
    @required this.in_to,
    @required this.in_airline,
    @required this.in_season,
    @required this.in_DoW,
    @required this.in_ToD,
    @required this.in_id_from,
    @required this.in_id_to,
    @required this.in_id_airline,
    @required this.in_id_season,
    @required this.in_id_DoW,
    @required this.in_id_ToD
  }) : super(key: key);
  final FirebaseUser user;
  final String in_from;
  final String in_to;
  final String in_airline;
  final String in_season;
  final String in_DoW;
  final String in_ToD;
  final int in_id_from;
  final int in_id_to;
  final int in_id_airline;
  final int in_id_season;
  final int in_id_DoW;
  final int in_id_ToD;
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Result', textAlign: TextAlign.left),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.person_outline  , color: Colors.white, size: 40),
            onPressed: toProfile,),
          IconButton(
            icon: Icon(Icons.exit_to_app  , color: Colors.white, size: 40),
            onPressed: signout,),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(child: Text('Prediction', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),)),
          ListTile(leading: Icon(Icons.access_alarm  , color: Colors.deepOrange),title: Text('Probability of flight delay:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),)
                  ),
          Text('${prediction( widget.in_id_ToD,  widget.in_id_from,  widget.in_id_to,  widget.in_id_airline,  widget.in_id_season,  widget.in_id_DoW)}%', textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold),),
          ListTile(leading: Icon(Icons.flight_takeoff  , color: Colors.deepOrange),title: Text('Flight From:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)
                  ),
          Text(widget.in_from, textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          ListTile(leading: Icon(Icons.flight_land  , color: Colors.deepOrange),title: Text('Flight To:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)
          ),
          Text(widget.in_to, textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          ListTile(leading: Icon(Icons.local_airport  , color: Colors.deepOrange),title: Text('With Airline:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)
          ),
          Text(widget.in_airline, textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          ListTile(leading: Icon(Icons.brightness_4  , color: Colors.deepOrange),title: Text('On:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)
          ),
          Text(widget.in_DoW + ', ' + widget.in_ToD, textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          ListTile(leading: Icon(Icons.local_florist  , color: Colors.deepOrange),title: Text('In:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)
          ),
          Text(widget.in_season, textAlign: TextAlign.center, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          Text('\n'),
          RaisedButton(
            onPressed: toPayment,
            child: Text('New Prediction',style: TextStyle(color: Colors.white, fontSize: 28)),
            color: Colors.lime[600],
            textColor: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

 String prediction(int TimeOfDay_id, int Origin_id, int Destination_id, int Airline_id, int Season_id, int DayOfWeek_id)  {
   String proba=(100-100/(1+exp(Constants.coef['TimeOfDay']*TimeOfDay_id+Constants.coef['org_'+Origin_id.toString()]+Constants.coef['dst_'+Destination_id.toString()]+Constants.coef['arl_'+Airline_id.toString()]+Constants.coef['ssn_'+Season_id.toString()]+Constants.coef['Intercept']))).toStringAsFixed(2);
    return proba;
 }


  void toPayment(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentPage(user: widget.user)));
  }

  void toProfile(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
  }

  void signout(){
    try {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
    } catch(e){
      print(e.message);
    }
  }
}