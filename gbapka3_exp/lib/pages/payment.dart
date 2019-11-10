import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart' as STpay;
import 'package:stripe_payment/stripe_payment.dart';

import 'package:gbapka3/pages/predInputs.dart';
import 'package:gbapka3/pages/profile.dart';
import 'package:gbapka3/pages/starting.dart';
import 'package:gbapka3/pages/dictionaries/Stripe_config.dart' as Stripe_c;

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String _paymentMethodId;
  String _paymentMethodId_date;
  final formKey = GlobalKey<FormState>();

//----------- for testing purposes
//  final STpay.CreditCard testCard = STpay.CreditCard(
//    number: '4242424242424242',
//    expMonth: 12,
//    expYear: 24,
//    //cvc: '123',
//  );

  @override
  void initState() {
    super.initState();

    STpay.StripePayment.setOptions(STpay.StripeOptions(publishableKey: Stripe_c.public_key //, merchantId: "Test", androidPayMode: 'test'
    ));
  }

 final fireDb_ref= Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text('Prediction Payment', textAlign: TextAlign.left),
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
          Icon(
            Icons.airplanemode_inactive ,
            color: Colors.deepOrange,
            size: 100.0,),
          Center(child: Text('You are using Flight Delays Prediction Application.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),
          Center(child: Text('This is paid service - each prediction requires payment.\n\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16),)),
          Icon(
            Icons.attach_money  ,
            color: Colors.deepOrange,
            size: 100.0,),
          Center(child: Text('Payment for prediction:', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),)),
          Center(child: Text(r'1 prediction - 1$', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16),)),
          Center(child: Text('\n\n', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),)),
          RaisedButton(
            //-------------działający form dla Stripe Payment------------------------------------------------------------------
              onPressed: () async {
                var doc_stripe =await fireDb_ref.collection('stripe_customers').document(widget.user.uid).get();
                var stripe_data= doc_stripe.data;
                try{
                  StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
                    stderr.writeln('################  CC: '+paymentMethod.id);
                    stderr.writeln('################  CC: '+paymentMethod.card.brand);
                    stderr.writeln('################  CC: '+paymentMethod.card.last4);
                    stderr.writeln('################  CC: '+paymentMethod.card.expMonth.toString());
                    stderr.writeln('################  CC: '+paymentMethod.card.expYear.toString());
                    //stderr.writeln('################  CC: '+paymentMethod.card.cvc.toString());
                    _paymentMethodId=paymentMethod.id;
                    stderr.writeln('################  PM: '+_paymentMethodId);
                    fireDb_ref.collection('stripe_customers')
                        .document(widget.user.uid)
                        .updateData({
                      //.setData({
                      'pm': _paymentMethodId,
                      'pm_date': _paymentMethodId_date
                    });

                    fireDb_ref.collection('stripe_charges')
                        .add({
                      'amount': 10, //price set on server side
                      'currency': 'USD',
                      'user_fb': widget.user.uid,
                      'customer_stripe': stripe_data['customer_id'],
                      'pm': _paymentMethodId,
                      'pm_from': _paymentMethodId_date,
                      'when': DateTime.now().toString()
                    });

                    setState(()  {
                      toPredictionInputs();
                });

                  });
              } catch(e){print(e.message);}
              },
            child: Text('Pay with Credit Card',style: TextStyle(color: Colors.white, fontSize: 28)),
            color: Colors.lime[600],
            textColor: Colors.white,
          ),

//          RaisedButton(
//            //------------- CC without template for testng------------------------------------------------------------------
//            onPressed: () async {
//              var doc_stripe =await fireDb_ref.collection('stripe_customers').document(widget.user.uid).get();
//              var stripe_data= doc_stripe.data;
//              try {
//                StripePayment.createPaymentMethod(PaymentMethodRequest(card: testCard,),).then((paymentMethod) {
//                  stderr.writeln('################  CC: '+paymentMethod.id);
//                  stderr.writeln('################  CC: '+paymentMethod.card.brand);
//                  stderr.writeln('################  CC: '+paymentMethod.card.last4);
//                  stderr.writeln('################  CC: '+paymentMethod.card.expMonth.toString());
//                  stderr.writeln('################  CC: '+paymentMethod.card.expYear.toString());
//                  //stderr.writeln('################  CC: '+paymentMethod.card.cvc.toString());
//
//                  _paymentMethodId=paymentMethod.id;
//                  //setState(()   {
//                  stderr.writeln('################  PM2: '+_paymentMethodId);
//                  _paymentMethodId_date=DateTime.now().toString();
//
//                    fireDb_ref.collection('stripe_customers')
//                        .document(widget.user.uid)
//                        .updateData({
//                        //.setData({
//                        'pm': _paymentMethodId,
//                        'pm_date': _paymentMethodId_date
//                    });
//
//                    fireDb_ref.collection('stripe_charges')
//                        .add({
//                        'amount': 10, //price set on server side
//                        'currency': 'USD',
//                        'user_fb': widget.user.uid,
//                        'customer_stripe': stripe_data['customer_id'],
//                        'pm': _paymentMethodId,
//                        'pm_from': _paymentMethodId_date,
//                        'when': DateTime.now().toString()
//                      });
//
//                });
//              } catch(e){print(e.message);}
//
//            },
//
//            child: Text('Default Card Pay',style: TextStyle(color: Colors.white, fontSize: 28)),
//            color: Colors.lime[600],
//            textColor: Colors.white,
//          ),
         ],
      ),
      backgroundColor: Colors.white,
    );
  }

  void toPredictionInputs(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PredInputsPage(user: widget.user)));
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