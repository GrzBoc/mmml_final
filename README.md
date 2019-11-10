# mmml_final
## Final homework

### Team: Standalone 
<p align="center"> <img src="/screenshots/app_anim.gif" width=185  height= 350></p>

### Summary
1. Midterm flask app was transformed to flutter one.
2. It is simple application for predicting flight delays based on Kaggle competition dataset.
3. ML model calibration can be found in [notebook](https://github.com/GrzBoc/mlap_strup/blob/master/model_notebook/gb_HW05_def.ipynb)
4. For the sake of Flutter App, model parameters (logistic regression one) were extracted from the model and placed as Map in flutter app and used in App for predictions.
5. Application operational model:
  - sing up is required to have access to flight delay functionality;
  - then to be able to have a prediction an upfront payment has to be done with credit card.
6. Authentication is based on Firebase - configuration file google-services.json is required in /android/app/ folder.
7. Payments are based on Stripe - keys should be placed in Stripe_config.dart file in /lib/pages/dictionaries, on the other hand secret key has to be set in backend server - for sake of this project Firebase Cloud Services are used ( secret key parametrization by: firebase functions:config:set stripe.token="own stripe secret token").
8. Firebase Cloud functions were placed in folder firebase_cloud.
9. Icons and logo is stored in assets folder.
10. App was tested on Android emulator. 
11. The attached codes repository require firebase and stripe independent parametrization to compile the app.
12. Below images present:
  - front end pages
  - logs of connectivity to stripe services to get Payment Method
  - structure of firebase database
  - list of Cloud function
13. TODOs:
  - frontend and machine learning tasks are completed as well as payment services on frontend side - all the historical/legacy dependencies were overcome and function on up to date classes
  - backend payment services still require further work, i.e. not all Cloud functions were fully tested following technical issue in conectivity to test environment in the last week.

### Home screen
<p align="center"> <img src="/screenshots/app_01.jpg" ></p>

### About
<p align="center"> <img src="/screenshots/app_03.jpg" ></p>

### Login
<p align="center"> <img src="/screenshots/app_02.jpg" ></p>

### Signup
<p align="center"> <img src="/screenshots/app_04.jpg"></p>

### Profile page
<p align="center"> <img src="/screenshots/app_11.jpg"></p>

### Payment page
<p align="center"> <img src="/screenshots/app_10.jpg"></p>

### Credit Card details page
<p align="center"> <img src="/screenshots/app_12.jpg"></p>
<p align="center"> <img src="/screenshots/app_13.jpg"></p>

### Prediction page configuration
<p align="center"> <img src="/screenshots/app_14.jpg"></p>
<p align="center"> <img src="/screenshots/app_15.jpg"></p>
<p align="center"> <img src="/screenshots/app_16.jpg"></p>

### Prediction results
<p align="center"> <img src="/screenshots/app_17.jpg"></p>

### Credit cards logging with PaymentMethod from Stripe
<p align="center"> <img src="/screenshots/fb_app_02.jpg"></p>

### Firebase database
<p align="center"> <img src="/screenshots/fb_01.jpg"></p>
<p align="center"> <img src="/screenshots/fb_02.jpg"></p>
<p align="center"> <img src="/screenshots/fb_03.jpg"></p>

### Firebase Cloud functions
<p align="center"> <img src="/screenshots/fb_04.jpg"></p>


