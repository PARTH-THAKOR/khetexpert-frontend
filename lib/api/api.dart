// Apis

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khetexpert/layouts/auth/for_expert/expert_login.dart';
import 'package:khetexpert/layouts/navigation_/application_mode.dart';
import 'package:khetexpert/service/initialization.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:khetexpert/states/GetX/ask_to_expert/ask_to_expert_farmer_getx.dart';
import 'package:khetexpert/states/GetX/ask_to_expert/doubt_solution_getx.dart';
import 'package:khetexpert/states/GetX/blog/blog_expert_getx.dart';
import 'package:khetexpert/states/GetX/disease_solution/disease_detection_getx.dart';
import 'package:khetexpert/states/GetX/disease_solution/disease_solution_getx.dart';
import 'package:khetexpert/states/GetX/news/news_getx.dart';
import 'package:khetexpert/states/GetX/settings_/setting_controller_getx.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../language/translator.dart';
import '../settings/constants.dart';
import '../states/GetX/chatbot/chatbot_getx.dart';
import '../states/GetX/login/login_getx.dart';
import 'models.dart';

// ExpertProfile
expertProfile(String expertId) async {
  try {
    final responce = await http.get(
      Uri.parse("$host/expert/profile/get"),
      headers: {
        'Authorization': authToken,
        "Accept": "application/json",
        "content-type": "application/json",
        "expertId": expertId,
      },
    );
    if (responce.statusCode == 200) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("expert", responce.body.toString());
      ApplicationConfigureAdapter.initializeExpertProfile();
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// ExpertLogin
expertLogin(String email, String password, ExpertLoginController controller, BuildContext context) async {
  controller.loading.value = true;
  try {
    final responce = await http.get(
      Uri.parse("$host/expert/login/email"),
      headers: {
        'Authorization': authToken,
        "Accept": "application/json",
        "content-type": "application/json",
        "ExpertEmail": email,
        "Password": password
      },
    );
    if (responce.statusCode == 200) {
      await expertProfile(jsonDecode(responce.body.toString())['message'].toString());
      Fluttertoast.showToast(msg: "Logged In");
    } else if (responce.statusCode == 400) {
      Fluttertoast.showToast(msg: "Password Not Matched");
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
  controller.loading.value = false;
}

// ExpertEmailOTPSend
expertEmailOTPSend(String email, ExpertLoginController controller) async {
  controller.loadingSendOTP.value = true;
  try {
    final responce = await http.patch(
      Uri.parse("$host/expert/login/OTPv/forgot"),
      headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json", 'Email': email},
    );
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "OTP Send");
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
  controller.loadingSendOTP.value = false;
}

// ExpertEmailOTPVerification
expertEmailOTPVerification(String email, String otp) async {
  try {
    final responce = await http.patch(
      Uri.parse("$host/expert/login/OTPv/verify"),
      headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json", 'Email': email, 'OTP': otp},
    );
    if (responce.statusCode == 202) {
      return true;
    } else if (responce.statusCode == 400) {
      Fluttertoast.showToast(msg: "OTP Not Matched");
      return false;
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
      return false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
    return false;
  }
}

// ExpertForgotPassword
expertForgotPassword(String email, String newPassword, String otp, ExpertLoginController controller, BuildContext context) async {
  controller.loadingForgot.value = true;
  bool verified = await expertEmailOTPVerification(email, otp);
  if (verified) {
    try {
      final responce = await http.put(
        Uri.parse("$host/expert/login/forgot"),
        headers: {
          'Authorization': authToken,
          "Accept": "application/json",
          "content-type": "application/json",
          "ExpertEmail": email,
          "NewPassword": newPassword
        },
      );
      if (responce.statusCode == 201) {
        Fluttertoast.showToast(msg: "Password Updated")
            .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ExpertLogin())));
      } else {
        Fluttertoast.showToast(msg: "Internal Server Error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Server Error");
    }
  } else {
    Fluttertoast.showToast(msg: "OTP not matched");
  }
  controller.loadingForgot.value = false;
}

// ExpertRegister
expertRegister(String otp, String email, String expertName, String expertMobileNumber, String stateName, String password, String docUrl,
    String imgUrl, String docNumber, ExpertLoginController controller) async {
  controller.loadingRegister.value = true;
  bool verified = await expertEmailOTPVerification(email, otp);
  if (verified) {
    try {
      final responce = await http.post(Uri.parse("$host/expert/login/register"),
          headers: {
            'Authorization': authToken,
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode({
            "expertName": expertName,
            "expertMobileNumber": expertMobileNumber,
            "expertEmailId": email,
            "stateName": stateName,
            "password": password,
            "docUrl": docUrl,
            "imageUrl": imgUrl,
            "docNumber": docNumber
          }));
      if (responce.statusCode == 201) {
        Fluttertoast.showToast(msg: "Expert Registered");
        Get.off(const ExpertLogin());
      } else if (responce.statusCode == 400) {
        Fluttertoast.showToast(msg: "Expert already Exist");
      } else {
        Fluttertoast.showToast(msg: "Internal Server Error");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Server Error");
    }
  } else {
    Fluttertoast.showToast(msg: "OTP not matched");
  }
  controller.loadingRegister.value = false;
}

// DiseaseAI
diseaseAICall(String disease, DiseaseAIForFarmersController controller) async {
  try {
    final response = await http.post(Uri.parse(url),
        headers: {"Authorization": authKey, 'Content-Type': 'application/json'},
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": "Essay on $disease plant disease pointwise with medical solutions in 1000 words",
          "max_tokens": 2000,
          "temperature": 0
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      controller.changeApiResponce(changeValueEnToOtherApp(data['choices'][0]["text"].toString().replaceRange(0, 2, ""), appLangCode));
    } else {
      Fluttertoast.showToast(msg: "Sorry Error Occurred");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
  controller.apiResponce.value = false;
}

// DiseaseWrite
writeDisease(String question, List<String> imgUrls, DiseaseWriteController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/disease/ask"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({
          "farmerImgUrl": farmer.imgUrl!,
          "farmerName": farmer.name!,
          "phoneNumber": farmer.phoneNumber!,
          "state": farmer.state!,
          "question": question,
          "imgUrls": imgUrls,
        }));
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "Question Posted");
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
  }
  controller.apiResponce.value = false;
  Navigator.pop(Get.overlayContext!, true);
}

// ChatBot
chatBotApiCall(String search, ChatBotController controller) async {
  List<ChatBotModel> gptlist = [];
  final fstore = FirebaseFirestore.instance.collection('chatbot');
  try {
    final response = await http.post(Uri.parse(url),
        headers: {"Authorization": authKey, 'Content-Type': 'application/json'},
        body: jsonEncode({"model": "text-davinci-003", "prompt": search, "max_tokens": 700, "temperature": 0}));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      gptlist.add(ChatBotModel.fromJson(data));
      fstore
          .doc(farmer.phoneNumber!)
          .collection("openAI")
          .doc("zans")
          .set({"set": "ans", "title": await changeValueEnToOther(data['choices'][0]["text"].toString().replaceRange(0, 2, ""), appLangCode)}).then(
              (value) {
        controller.gptResponce.value = false;
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
      });
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

// GetNews
getNews(NewsController controller) async {
  try {
    final responce = await http.get(Uri.parse("$host/news/get"), headers: {'Authorization': authToken});
    if (responce.statusCode == 200) {
      controller.news.clear();
      controller.news = jsonDecode(responce.body.toString());
      controller.newsApiFetch = true;
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
      controller.newsApiFetch = false;
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    controller.newsApiFetch = false;
  }
}

// ExpertDiseaseWriteSolution
expertDiseaseWriteSolution(
    String solution, String disease, String description, String docId, String link, ExpertDiseaseSolutionWriteController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/disease/answer/write"),
        headers: {
          'Authorization': authToken,
          "Accept": "application/json",
          "content-type": "application/json",
          "docId": docId,
          "state": expert.stateName!
        },
        body: jsonEncode({
          "expertImageUrl": expert.imageUrl!,
          "expertId": expert.expertId!,
          "expertName": expert.expertName!,
          "expertPhoneNumber": expert.expertMobileNumber!,
          "expertEmailId": expert.expertEmailId!,
          "disease": disease,
          "description": description,
          "solution": solution,
          "externalLink": link
        }));
    if (responce.statusCode == 201) {
      controller.apiResponce.value = false;
    } else {
      debugPrint(responce.statusCode.toString());
      Fluttertoast.showToast(msg: "Internal Server Error");
      controller.apiResponce.value = false;
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    controller.apiResponce.value = false;
  }
  Navigator.pop(Get.overlayContext!, true);
}

// RateBlog
rateBlog(String docId, SharedPreferences internalData) async {
  try {
    final responce = await http.post(Uri.parse("$host/blog/rate"), headers: {'Authorization': authToken, 'docId': docId});
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "Liked");
      internalData.setBool("${docId}blog", true);
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
      Fluttertoast.showToast(msg: responce.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// UnRateBlog
unRateBlog(String docId, SharedPreferences internalData) async {
  try {
    final responce = await http.post(Uri.parse("$host/blog/unrate"), headers: {'Authorization': authToken, 'docId': docId});
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "Un-Liked");
      internalData.remove("${docId}blog");
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// WriteBlog
writeBlog(String content, String title, String link, String imageUrl, BlogForExpertController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/blog/write"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({
          "expertImageUrl": expert.imageUrl!,
          "expertName": expert.expertName!,
          "expertEmail": expert.expertEmailId!,
          "title": title,
          "content": content,
          "externalLink": link,
          "imageUrl": imageUrl,
        }));
    if (responce.statusCode == 201) {
      controller.apiResponce.value = false;
    } else {
      debugPrint(responce.statusCode.toString());
      Fluttertoast.showToast(msg: "Internal Server Error");
      controller.apiResponce.value = false;
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    controller.apiResponce.value = false;
  }
}

// UpdateBlog
updateBlog(String content, String title, String link, String imageUrl, String docId, BlogForExpertController controller) async {
  try {
    final responce = await http.put(Uri.parse("$host/blog/update"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({
          "blogId": docId,
          "expertImageUrl": expert.imageUrl!,
          "expertName": expert.expertName!,
          "expertEmail": expert.expertEmailId!,
          "title": title,
          "imageUrl": imageUrl,
          "content": content,
          "externalLink": link,
        }));
    if (responce.statusCode == 201) {
      controller.updateResponce.value = false;
    } else {
      debugPrint(responce.statusCode.toString());
      Fluttertoast.showToast(msg: "Internal Server Error");
      Fluttertoast.showToast(msg: responce.statusCode.toString());
      Fluttertoast.showToast(msg: responce.body.toString());
      controller.updateResponce.value = false;
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    controller.updateResponce.value = false;
  }
}

// AskToExpert
askToExpert(String search, AskToExpertForFarmerController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/doubt/ask"),
        headers: {
          'Authorization': authToken,
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode({
          'farmerName': farmer.name!,
          'farmerImgUrl': farmer.imgUrl!,
          'phoneNumber': farmer.phoneNumber!,
          'state': farmer.state!,
          'question': search
        }));
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "Doubt Posted");
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
  controller.apiResponce.value = false;
}

// WriteDoubtAnswer
writeDoubtAnswer(String solution, String docId, String link, ExpertDoubtSolutionWriteController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/doubt/answer/write"),
        headers: {
          'Authorization': authToken,
          "Accept": "application/json",
          "content-type": "application/json",
          "docId": docId,
          "state": expert.stateName!
        },
        body: jsonEncode({
          "expertImageUrl": expert.imageUrl!,
          "expertId": expert.expertId!,
          "expertName": expert.expertName!,
          "expertEmailId": expert.expertEmailId!,
          "solution": solution,
          "externalLink": link
        }));
    if (responce.statusCode == 201) {
      controller.apiResponce.value = false;
    } else {
      debugPrint(responce.statusCode.toString());
      Fluttertoast.showToast(msg: "Internal Server Error");
      controller.apiResponce.value = false;
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    controller.apiResponce.value = false;
  }
}

// RequestAppointment
requestAppointment(String expI, String expE, String expN, String expIm, String expMo, String res) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  try {
    final responce = await http.post(Uri.parse("$host/appointment/request"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({
          "expertId": expI,
          "expertEmailId": expE,
          "expertName": expN,
          "expertImageUrl": expIm,
          "expertMobileNumber": expMo,
          "farmerName": farmer.name!,
          "farmerMobileNumber": farmer.phoneNumber!,
          "farmerImgUrl": farmer.imgUrl!,
          "reason": res,
        }));
    if (responce.statusCode == 201) {
      Fluttertoast.showToast(msg: "Appointment Created");
      sharedPreferences.setString("app${expI + res}", "");
    } else {
      debugPrint(responce.body.toString());
      Fluttertoast.showToast(msg: "Internal Error Occurred");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// AcceptAppointment
acceptAppointment(String docId, String hour, String minutes, String ampm) async {
  try {
    final responce = await http.put(Uri.parse("$host/appointment/accept"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({"docId": docId, "hour": hour, "minutes": minutes, "ampm": ampm}));
    if (responce.statusCode == 200) {
      Fluttertoast.showToast(msg: "Appointment Accepted");
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// PostponeAppointment
postponeAppointment(String docId) async {
  try {
    final responce = await http.put(Uri.parse("$host/appointment/postpone"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({
          "docId": docId,
        }));
    if (responce.statusCode == 200) {
      Fluttertoast.showToast(msg: "Appointment Postponed");
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// RejectAppointment
rejectAppointment(String docId) async {
  try {
    final responce = await http.put(Uri.parse("$host/appointment/reject"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"}, body: jsonEncode({"docId": docId}));
    if (responce.statusCode == 200) {
      Fluttertoast.showToast(msg: "Appointment Postponed");
    } else {
      Fluttertoast.showToast(msg: "Internal Error Occurred");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// FarmerProfileCreate
farmerProfileCreate(String name, String phoneNumber, String state_) async {
  try {
    final responce = await http.post(Uri.parse("$host/farmer/create"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({"name": name, "phoneNumber": phoneNumber, "imgUrl": "", "state": state_}));
    if (responce.statusCode == 201) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("farmer", responce.body.toString());
      ApplicationConfigureAdapter.initializeFarmerProfile();
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    debugPrint(e.toString());
    Fluttertoast.showToast(msg: e.toString());
    Fluttertoast.showToast(msg: "Server Error");
    Get.off(const ApplicationMode());
  }
}

// FarmerProfileUpdate
farmerProfileUpdate(String name, String imgUrl, FarmerProfileEditController controller) async {
  try {
    final responce = await http.post(Uri.parse("$host/farmer/create"),
        headers: {'Authorization': authToken, "Accept": "application/json", "content-type": "application/json"},
        body: jsonEncode({"name": name, "phoneNumber": farmer.phoneNumber!, "imgUrl": imgUrl, "state": farmer.state!}));
    if (responce.statusCode == 201) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("farmer", responce.body.toString());
      controller.load.value = false;
      Restart.restartApp();
    } else {
      controller.load.value = false;
      Fluttertoast.showToast(msg: "Internal Server Error");
    }
  } catch (e) {
    controller.load.value = false;
    Fluttertoast.showToast(msg: e.toString());
    Fluttertoast.showToast(msg: "Server Error");
  }
}

// ExpertProfileUpdate
expertProfileUpdate(String imgUrl, String newMobileNumber, String newName, ExpertProfileEditController controller) async {
  try {
    final responce = await http.put(Uri.parse("$host/expert/profile/update"),
        headers: {
          'Authorization': authToken,
          "Accept": "application/json",
          "content-type": "application/json",
          "Email": expert.expertEmailId!,
        },
        body: jsonEncode({
          "expertName": newName,
          "imageUrl": imgUrl,
          "expertMobileNumber": newMobileNumber,
        }));
    if (responce.statusCode == 201) {
      try {
        final responce = await http.get(
          Uri.parse("$host/expert/profile/get"),
          headers: {
            'Authorization': authToken,
            "Accept": "application/json",
            "content-type": "application/json",
            "expertId": expert.expertId!,
          },
        );
        if (responce.statusCode == 200) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("expert", responce.body.toString());
          controller.load.value = false;
          Restart.restartApp();
        } else {
          Fluttertoast.showToast(msg: "Internal Server Error");
          controller.load.value = false;
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Server Error");
        controller.load.value = false;
      }
    } else {
      Fluttertoast.showToast(msg: "Internal Server Error");
      controller.load.value = false;
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Server Error");
    controller.load.value = false;
  }
}

// AbuseWordFilter
abuseWordFilter(String prompt) async {
  // try {
  //   var headers = {
  //     'X-RapidAPI-Key': rapidApiKey,
  //     'X-RapidAPI-Host': rapidApiHost,
  //     'content-type': 'application/x-www-form-urlencoded',
  //   };
  //   var request = http.Request('POST', Uri.parse(rapidApiHostHttp));
  //   request.bodyFields = {'content': await changeValueOtherToEn(prompt)};
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     if (result.contains("true")) {
  //       Fluttertoast.showToast(msg: "Prompt is bad");
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     // Fluttertoast.showToast(msg: "Internal Server Error");
  //     return true;
  //   }
  // } catch (e) {
  //   // Fluttertoast.showToast(msg: "Server Error");
  //   return true;
  // }
  return true;
}
