//  Firebase Login

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khetexpert/api/api.dart';
import 'package:khetexpert/layouts/auth/for_expert/expert_login.dart';
import 'package:khetexpert/layouts/auth/for_farmer/farmer_login.dart';
import 'package:khetexpert/layouts/disease_solution/for_expert/expert_disease_detection.dart';
import 'package:khetexpert/layouts/disease_solution/for_farmer/disease_solution_farmers.dart';
import 'package:khetexpert/states/GetX/login/login_getx.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/settings.dart';

firebaseSendOTP(String name, String phoneNumber, String state_, FarmerLoginController controller, BuildContext context) {
  controller.loading.value = true;
  FirebaseAuth.instance
      .verifyPhoneNumber(
          phoneNumber: "+91$phoneNumber",
          verificationCompleted: (_) {},
          verificationFailed: (e) {
            Fluttertoast.showToast(msg: e.toString());
            controller.loading.value = false;
          },
          codeSent: (String verificationId, int? token) {
            controller.loading.value = false;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => FarmerOTPVerification(id: verificationId, name: name, state: state_)));
          },
          codeAutoRetrievalTimeout: (e) {
            controller.loading.value = false;
          })
      .then((value) {});
}

firebaseVerifyOTP(String id, String otp, String name, String state_, FarmerLoginController controller, BuildContext context) async {
  controller.loadingOTP.value = true;
  final credentials = PhoneAuthProvider.credential(verificationId: id.toString(), smsCode: otp.toString());
  try {
    await FirebaseAuth.instance.signInWithCredential(credentials).then((value) async {
      final user = FirebaseAuth.instance.currentUser?.phoneNumber;
      await farmerProfileCreate(name, user.toString(), state_);
    });
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    controller.loadingOTP.value = false;
  }
  controller.loadingOTP.value = false;
}

firebaseLoginByPass(int time, String mode) {
  if (mode == "farmer") {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Timer(Duration(seconds: time), () {
        Get.off(const DiseaseSolutionForFarmers());
      });
    } else {
      Timer(Duration(seconds: time), () {
        Get.off(const FarmerLogin());
      });
    }
  } else {
    if (expert.expertEmailId == null) {
      Timer(Duration(seconds: time), () {
        Get.off(const ExpertLogin());
      });
    } else {
      Timer(Duration(seconds: time), () {
        Get.off(const ExpertDiseaseDetection());
      });
    }
  }
}

firebaseLogOut() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  FirebaseAuth.instance.signOut().then((value) {
    sharedPreferences.remove("farmer").then((value) => sharedPreferences.remove("mode").then((value) => Timer(const Duration(seconds: 1), () {
          Restart.restartApp();
        })));
  });
}

expertLogOut() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove("expert").then((value) => sharedPreferences.remove("mode").then((value) => Timer(const Duration(seconds: 1), () {
        Restart.restartApp();
      })));
}
