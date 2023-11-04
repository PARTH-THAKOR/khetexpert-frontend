// SaveLanguage

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/auth/for_expert/expert_login.dart';
import 'package:khetexpert/service/firebase_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../layouts/auth/for_farmer/farmer_login.dart';
import '../layouts/navigation_/application_mode.dart';
import '../settings/settings.dart';
import '../themes/themes.dart';

saveLanguageNavigation(String langCode) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("language", langCode);
  Get.updateLocale(Locale(langCode, "IN"));
  if (sharedPreferences.containsKey("mode")) {
    firebaseLoginByPass(1, sharedPreferences.getString("mode")!);
  } else {
    Timer(const Duration(seconds: 1), () {
      Get.off(const ApplicationMode());
    });
  }
}

applicationModeNavigation(String mode) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("mode", mode);
  if (mode == "farmer") {
    Get.to(const FarmerLogin());
  } else {
    Get.to(const ExpertLogin());
  }
}

profileImageShow(BuildContext context, String url, String name) async {
  await showDialog(
      context: context,
      builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(border: Border.all(color: primary(), width: 1), borderRadius: BorderRadius.circular(10), color: primary()),
            child: ListView(
              children: [
                Container(
                  height: 250,
                  width: 250,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: (url == "")
                      ? Image.asset(
                          "lib/assets/tree.webp",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: pwText(20, pText()),
                  ),
                ),
              ],
            ),
          )));
}

profileImageWidget(String url) {
  if (url == "") {
    return Image.asset(
      'lib/assets/tree.webp',
      fit: BoxFit.cover,
    );
  } else {
    return Image.network(
      url,
      fit: BoxFit.cover,
    );
  }
}

popExitMethod() async {
  final difference = DateTime.now().difference(backTime);
  final isExitWarning = difference >= const Duration(seconds: 2);
  backTime = DateTime.now();
  if (isExitWarning) {
    Fluttertoast.showToast(msg: 'Press back again to exit.', fontSize: 18);
    return false;
  } else {
    Fluttertoast.cancel();
    return true;
  }
}
