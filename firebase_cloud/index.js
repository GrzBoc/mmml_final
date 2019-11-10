const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const logging = require('@google-cloud/logging');

//admin.initializeApp(functions.config().firebase);

const firestore2 = admin.firestore();
const settings = { timestampsInSnapshots: true };
firestore2.settings(settings);

const stripe = require('stripe')(functions.config().stripe.token);
const currency = functions.config().stripe.currency || 'USD';


// ################# Account functions ###################
 exports.createUserAccount = functions.auth.user().onCreate(async (event) => {
     console.log('User id to be created..', event.uid);

     const userID = event.uid;
     const email = event.email;
     //const customer = await stripe.customers.create({email: event.email});

     return admin.firestore().collection('users').doc(`${userID}`).set({
         email: email //,
   //      customer_id: customer.id
     }).then( utworzony => {
         console.log("Created user... ", userID); return userID;
     }).catch(error => {
         console.error("Error while creating ", error); return error;
     });
 });


exports.deleteUserAccount = functions.auth.user().onDelete(event => {
    console.log('User id to be deleted..', event.uid);
    const userID = event.uid;

    return admin.firestore().doc(`users/${userID}`).delete()
        .then( function () {
            console.log("Deleted user... ", userID); return userID;
        }).catch(error => {
            console.error("Error while deleting ", error); return error;
        });
});

//##################### Payment functions ######################

exports.doPlacenia = functions.firestore.document('/stripe_charges/{any}').onCreate(async (snap, context) => {

    const snap_data=snap.after.data();
    const ss_cust_strp=snap_data.customer_stripe;
    const ss_pm=snap_data.pm;
    const response = await stripe.customers.createSource(ss_cust_strp, {'source': ss_pm});

    return snap.ref.set( response);
  });

// alternative not used
  exports.doPlacenia2=functions.firestore.document('/stripe_charges/{any}').onCreate(async (snap, context) => {
  
    //--customer striep view
    const snapshot = await admin.firestore().collection('stripe_customers').document(context.params.userId).get(); //wyciagniecie uzytkownika z sesji
    const customer=snapshot.data().customer_id; //w celu wydobycia strip_customer id
    const token=snapshot.data().pm; //w celu wydobycia strip_customer id

    // create customer source
    const response = await stripe.customers.createSource(customer, {source: token});

    // finalnie zwracam 
    return admin.firestore().collection('stripe_customers')
        .document(context.params.userId)
        .collection('sources')
        .doc(response.fingerprint)   
        .set(response, {merge:true});

});


// When a user is created, register them with Stripe
exports.createStripeCustomer = functions.auth.user().onCreate(async (user) => {
const customer = await stripe.customers.create({email: user.email});
return admin.firestore().collection('stripe_customers').doc(user.uid).set({customer_id: customer.id});
});


//shared public firebase cloud functions

// [START chargecustomer]
// Charge the Stripe customer whenever an amount is created in Cloud Firestore
exports.createStripeCharge = functions.firestore.document('stripe_customers/{userId}/charges/{id}').onCreate(async (snap, context) => {
    const val = snap.data();
    try {
      // Look up the Stripe customer id written in createStripeCustomer
      const snapshot = await admin.firestore().collection('stripe_customers').doc(context.params.userId).get()
      const snapval = snapshot.data();
      const customer = snapval.customer_id
      // Create a charge using the pushId as the idempotency key
      // protecting against double charges
      const amount = val.amount;
      const idempotencyKey = context.params.id;
      const charge = {amount, currency, customer};
      if (val.source !== null) {
        charge.source = val.source;
      }
      const response = await stripe.charges.create(charge, {idempotency_key: idempotencyKey});
      // If the result is successful, write it back to the database
      return snap.ref.set(response, { merge: true });
    } catch(error) {
      // We want to capture errors and render them in a user-friendly way, while
      // still logging an exception with StackDriver
      console.log(error);
      await snap.ref.set({error: userFacingMessage(error)}, { merge: true });
      return reportError(error, {user: context.params.userId});
    }
  });
// [END chargecustomer]]






// Add a payment source (card) for a user by writing a stripe payment source token to Cloud Firestore
exports.addPaymentSource = functions.firestore.document('/stripe_customers/{userId}/tokens/{pushId}').onCreate(async (snap, context) => {
const source = snap.data();
const token = source.token;
if (source === null){
  return null;
}

try {
  const snapshot = await admin.firestore().collection('stripe_customers').doc(context.params.userId).get();
  const customer =  snapshot.data().customer_id;
  const response = await stripe.customers.createSource(customer, {source: token});
  return admin.firestore().collection('stripe_customers').doc(context.params.userId).collection("sources").doc(response.fingerprint).set(response, {merge: true});
} catch (error) {
  await snap.ref.set({'error':userFacingMessage(error)},{merge:true});
  return reportError(error, {user: context.params.userId});
}
});

// When a user deletes their account, clean up after them
exports.cleanupUser = functions.auth.user().onDelete(async (user) => {
const snapshot = await admin.firestore().collection('stripe_customers').doc(user.uid).get();
const customer = snapshot.data();
await stripe.customers.del(customer.customer_id);
return admin.firestore().collection('stripe_customers').doc(user.uid).delete();
});

// To keep on top of errors, we should raise a verbose error report with Stackdriver rather
// than simply relying on console.error. This will calculate users affected + send you email
// alerts, if you've opted into receiving them.
// [START reporterror]
function reportError(err, context = {}) {
// This is the name of the StackDriver log stream that will receive the log
// entry. This name can be any valid log stream name, but must contain "err"
// in order for the error to be picked up by StackDriver Error Reporting.
const logName = 'errors';
const log = logging.log(logName);

// https://cloud.google.com/logging/docs/api/ref_v2beta1/rest/v2beta1/MonitoredResource
const metadata = {
  resource: {
    type: 'cloud_function',
    labels: {function_name: process.env.FUNCTION_NAME},
  },
};

// https://cloud.google.com/error-reporting/reference/rest/v1beta1/ErrorEvent
const errorEvent = {
  message: err.stack,
  serviceContext: {
    service: process.env.FUNCTION_NAME,
    resourceType: 'cloud_function',
  },
  context: context,
};

// Write the error log entry
return new Promise((resolve, reject) => {
  log.write(log.entry(metadata, errorEvent), (error) => {
    if (error) {
     return reject(error);
    }
    return resolve();
  });
});
}
// [END reporterror]

// Sanitize the error message for the user
function userFacingMessage(error) {
return error.type ? error.message : 'An error occurred, developers have been alerted';
}