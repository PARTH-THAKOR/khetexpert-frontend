// SettingsController

import 'dart:ui';
import 'package:get/get.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLanguageController extends GetxController {
  RxString selected = globalLanguage.obs;

  updateLanguage(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value == "English") {
      sharedPreferences.setString("language", "en");
      appLangCode = "en";
    } else if (value == "हिंदी") {
      sharedPreferences.setString("language", "hi");
      appLangCode = "hi";
    } else {
      sharedPreferences.setString("language", "gu");
      appLangCode = "gu";
    }
    globalLanguage = value;
    Get.updateLocale(Locale(sharedPreferences.getString("language")!, "IN"));
    selected.value = value;
  }
}

class FarmerProfileEditController extends GetxController {
  RxBool load = false.obs;
}

class ExpertProfileEditController extends GetxController {
  RxBool load = false.obs;
}

class StateSelectionController extends GetxController {
  RxString selected = "Andhra Pradesh".obs;
  var items = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman Nicobar",
    "Chandigarh",
    "Dadra Nagar Haveli",
    "Daman Diu",
    "Lakshadweep",
    "Delhi",
    "Puducherry",
    "Ladakh",
    "Jammu Kashmir"
  ];
}
