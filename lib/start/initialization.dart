// ApplicationConfigureAdapter

import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/disease_solution/for_expert/expert_disease_detection.dart';
import 'package:khetexpert/layouts/navigation_/application_mode.dart';
import 'package:khetexpert/layouts/navigation_/language_select.dart';
import 'package:khetexpert/layouts/splash/splash.dart';
import 'package:khetexpert/service/firebase_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../language/languages.dart';
import '../layouts/disease_solution/for_farmer/disease_solution_farmers.dart';
import '../settings/constants.dart';
import '../settings/firebase_options.dart';
import '../settings/profile.dart';
import '../settings/settings.dart';

class ApplicationConfigureAdapter extends StatelessWidget {
  const ApplicationConfigureAdapter({super.key});

  static initializeApp() async {
    await ApplicationConfigureAdapter.initializeFirebaseService();
    await ApplicationConfigureAdapter.initializeDeviceOrientation();
    await ApplicationConfigureAdapter.initializeApplicationRunner();
    await ApplicationConfigureAdapter.initializeBackendServerHost();
    await ApplicationConfigureAdapter.initializeApplicationTheme();
    await ApplicationConfigureAdapter.initializeApplicationSettings();
  }

  static initializeFirebaseService() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static initializeDeviceOrientation() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static initializeApplicationRunner() async {
    runApp(const ApplicationConfigureAdapter());
  }

  static initializeBackendServerHost() async {
    host = webHost;
  }

  static initializeApplicationTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("themeMode")) {
      darkMode = sharedPreferences.getBool("themeMode")!;
    } else {
      darkMode = false;
    }
  }

  static initializeExpertProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    expert = ExpertProfile.fromJson(jsonDecode(sharedPreferences.getString("expert")!));
    Get.off(const ExpertDiseaseDetection());
  }

  static initializeFarmerProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    farmer = FarmerProfile.fromJson(jsonDecode(sharedPreferences.getString("farmer")!));
    Get.off(const DiseaseSolutionForFarmers());
  }

  static initializeApplicationSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("language")) {
      appLangCode = sharedPreferences.getString("language")!;
      if (appLangCode == "en") {
        globalLanguage = "English";
      } else if (appLangCode == "hi") {
        globalLanguage = "हिंदी";
      } else {
        globalLanguage = "ગુજરાતી";
      }
      Get.updateLocale(Locale(appLangCode, "IN"));
      if (sharedPreferences.containsKey("mode")) {
        if (sharedPreferences.containsKey("expert")) {
          expert = ExpertProfile.fromJson(jsonDecode(sharedPreferences.getString("expert")!));
        }
        if (sharedPreferences.containsKey("farmer")) {
          farmer = FarmerProfile.fromJson(jsonDecode(sharedPreferences.getString("farmer")!));
        }
        firebaseLoginByPass(2, sharedPreferences.getString("mode")!);
      } else {
        Timer(const Duration(seconds: 2), () {
          Get.off(const ApplicationMode());
        });
      }
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.off(const LanguageSelection());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "KhetExpert",
      translations: Languages(),
      locale: const Locale("en", 'IN'),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
