// ExpertLogin

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khetexpert/api/api.dart';
import 'package:khetexpert/layouts/navigation_/application_mode.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:khetexpert/service/image_processing.dart';
import 'package:khetexpert/states/GetX/settings_/setting_controller_getx.dart';
import 'package:khetexpert/themes/themes.dart';
import '../../../states/GetX/login/login_getx.dart';

class ExpertLogin extends StatefulWidget {
  const ExpertLogin({super.key});

  @override
  State<ExpertLogin> createState() => _ExpertLoginState();
}

class _ExpertLoginState extends State<ExpertLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final ExpertLoginController controller = Get.put(ExpertLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pBackground(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: pBackground(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: primary(),
            ),
            onPressed: () async {
              Get.off(const ApplicationMode());
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 20, 5),
              child: IconButton(
                color: primary(),
                onPressed: () {
                  Get.to(const ExpertRegistration());
                },
                icon: const Icon(Icons.login_outlined),
              ),
            )
          ],
          title: Text(
            "Expert Login",
            style: pwText(22, pText()),
          )),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                child: Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw5fHxwaG9uZXxlbnwwfHx8fDE2OTM3NTM0NjR8MA&ixlib=rb-4.0.3&q=80&w=400',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Text(
                  'Login via E-Mail',
                  style: pwText(24, pText()),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: pBackground(),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: pText(),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: email,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Enter E-Mail',
                              hintStyle: swText(20, sText()),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: pwText(20, pText()),
                            cursorColor: sText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Enter your E-Mail for Verification',
                      style: swText(14, sText()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: pBackground(),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: pText(),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: password,
                            autofocus: true,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              hintStyle: swText(20, sText()),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: pwText(20, pText()),
                            cursorColor: sText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 20),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Enter your Password for Verification',
                      style: swText(14, sText()),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                title: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpertForgotPassword()));
                  },
                  child: Text('Forgot Password', textAlign: TextAlign.center, style: swText(12, primary())),
                ),
                tileColor: pBackground(),
                dense: false,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          height: 55,
                          child: Obx(() => ElevatedButton(
                              onPressed: () async {
                                if (email.text.isEmpty || password.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "Fields are Empty");
                                } else if (!email.text.contains("@")) {
                                  Fluttertoast.showToast(msg: "Invalid Email");
                                } else {
                                  await expertLogin(email.text.toString(), password.text.toString(), controller, context);
                                }
                              },
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: primary(),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8))),
                                  elevation: const MaterialStatePropertyAll(10),
                                  backgroundColor: MaterialStatePropertyAll(primary())),
                              child: (controller.loading.value)
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4,
                                        color: Themes().primaryText,
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: pwText(16, Themes().primaryText),
                                    ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ExpertForgotPassword extends StatefulWidget {
  const ExpertForgotPassword({super.key});

  @override
  State<ExpertForgotPassword> createState() => _ExpertForgotPasswordState();
}

class _ExpertForgotPasswordState extends State<ExpertForgotPassword> {
  TextEditingController otp = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  final ExpertLoginController controller = Get.put(ExpertLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pBackground(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: pBackground(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: primary(),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Forgot Password",
            style: pwText(22, pText()),
          )),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                    child: Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw5fHxwaG9uZXxlbnwwfHx8fDE2OTM3NTM0NjR8MA&ixlib=rb-4.0.3&q=80&w=400',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Reset Account Password',
                      style: pwText(24, pText()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: email,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter E-Mail',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter E-Mail of Account',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: newPassword,
                                autofocus: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter new Password',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter new Password of Account',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: otp,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter OTP',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                textAlign: TextAlign.center,
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                            height: 55,
                            child: Obx(() => ElevatedButton(
                                onPressed: () async {
                                  if (email.text.isEmpty) {
                                    Fluttertoast.showToast(msg: "Email is Empty");
                                  } else if (!email.text.toString().contains("@")) {
                                    Fluttertoast.showToast(msg: "Invalid Email");
                                  } else {
                                    await expertEmailOTPSend(email.text.toString(), controller);
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: primary(),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5))),
                                    elevation: const MaterialStatePropertyAll(10),
                                    backgroundColor: MaterialStatePropertyAll(primary())),
                                child: (controller.loadingSendOTP.value)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: Themes().primaryText,
                                        ),
                                      )
                                    : Text(
                                        "Send OTP",
                                        style: pwText(16, Themes().primaryText),
                                      ))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter your OTP for Verification',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.join_right,
                        color: primary(),
                      ),
                      title: Text(
                        'Enabled E-Mail reading permission',
                        style: swText(12, sText()),
                      ),
                      tileColor: pBackground(),
                      dense: false,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                height: 55,
                                child: Obx(() => ElevatedButton(
                                    onPressed: () async {
                                      if (otp.text.isEmpty || email.text.isEmpty || newPassword.text.isEmpty) {
                                        Fluttertoast.showToast(msg: "Fields are Empty");
                                      } else {
                                        await expertForgotPassword(
                                            email.text.toString(), newPassword.text.toString(), otp.text.toString(), controller, context);
                                      }
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: primary(),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8))),
                                        elevation: const MaterialStatePropertyAll(10),
                                        backgroundColor: MaterialStatePropertyAll(primary())),
                                    child: (controller.loadingForgot.value)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 4,
                                              color: Themes().primaryText,
                                            ),
                                          )
                                        : Text(
                                            "Update",
                                            style: pwText(16, Themes().primaryText),
                                          ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ExpertRegistration extends StatefulWidget {
  const ExpertRegistration({super.key});

  @override
  State<ExpertRegistration> createState() => _ExpertRegistrationState();
}

class _ExpertRegistrationState extends State<ExpertRegistration> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController otp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController expertName = TextEditingController();
  final ExpertLoginController controller = Get.put(ExpertLoginController());
  final StateSelectionController controller2 = Get.put(StateSelectionController());

  getImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      (pickedImage != null) ? _image = File(pickedImage.path) : debugPrint("no img selected");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pBackground(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: pBackground(),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
              color: primary(),
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Expert Registration",
            style: pwText(22, pText()),
          )),
      body: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                    child: Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw5fHxwaG9uZXxlbnwwfHx8fDE2OTM3NTM0NjR8MA&ixlib=rb-4.0.3&q=80&w=400',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'Expert Registration',
                      style: pwText(24, pText()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: email,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter E-Mail',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter E-Mail for Account',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: expertName,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter Name',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter name for Account',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: password,
                                autofocus: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Enter Password',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter new Password for Account',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              '+91',
                              style: pwText(20, pText()),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 10, 0),
                              child: TextFormField(
                                controller: phoneNumber,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter mobile number',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                keyboardType: TextInputType.number,
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter primary mobile number for services',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 10, 0),
                            child: Obx(
                              () => DropdownButton(
                                value: controller2.selected.value,
                                padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 5),
                                dropdownColor: sBackground(),
                                style: pwText(18, pText()),
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(8),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: primary(),
                                ),
                                items: controller2.items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) async {
                                  controller2.selected.value = newValue!;
                                },
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter your state',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (kIsWeb) {
                        Fluttertoast.showToast(msg: "Not Supported on web");
                      } else {
                        await getImageFromGallery();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.25,
                        decoration: BoxDecoration(
                          color: sBackground(),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: pText(),
                          ),
                        ),
                        child: (_image == null)
                            ? Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(100)),
                                      child: IconButton(
                                        onPressed: () async {
                                          if (kIsWeb) {
                                            Fluttertoast.showToast(msg: "Not Supported on web");
                                          } else {
                                            await getImageFromGallery();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: sBackground(),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                    child: Text(
                                      'select document from Gallery',
                                      style: pwText(18, pText()),
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(_image!.path),
                                  width: double.infinity,
                                  height: MediaQuery.sizeOf(context).height * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Set document Properly, it can not update further',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pBackground(),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: pText(),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                controller: otp,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter OTP',
                                  hintStyle: swText(20, sText()),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: pwText(20, pText()),
                                textAlign: TextAlign.center,
                                cursorColor: sText(),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                            height: 55,
                            child: Obx(() => ElevatedButton(
                                onPressed: () async {
                                  if (email.text.isEmpty) {
                                    Fluttertoast.showToast(msg: "Email is Empty");
                                  } else if (!email.text.toString().contains("@")) {
                                    Fluttertoast.showToast(msg: "Invalid Email");
                                  } else {
                                    await expertEmailOTPSend(email.text.toString(), controller);
                                  }
                                },
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: primary(),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5))),
                                    elevation: const MaterialStatePropertyAll(10),
                                    backgroundColor: MaterialStatePropertyAll(primary())),
                                child: (controller.loadingSendOTP.value)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
                                          color: Themes().primaryText,
                                        ),
                                      )
                                    : Text(
                                        "Send OTP",
                                        style: pwText(16, Themes().primaryText),
                                      ))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter your OTP for Verification',
                          style: swText(14, sText()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.join_right,
                        color: primary(),
                      ),
                      title: Text(
                        'Enabled E-Mail reading permission',
                        style: swText(12, sText()),
                      ),
                      tileColor: pBackground(),
                      dense: false,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                height: 55,
                                child: Obx(() => ElevatedButton(
                                    onPressed: () async {
                                      if (kIsWeb) {
                                        Fluttertoast.showToast(msg: "Expert Registration is not Supported on web");
                                      } else {
                                        if (otp.text.isNotEmpty &&
                                            email.text.isNotEmpty &&
                                            password.text.isNotEmpty &&
                                            _image != null &&
                                            phoneNumber.text.isNotEmpty &&
                                            expertName.text.isNotEmpty &&
                                            phoneNumber.text.toString().length == 10) {
                                          String docNumber = await recognizeText(_image!);
                                          if (docNumber.isNotEmpty) {
                                            String docUrl = await imageUploadOnStorage(_image);
                                            if (docUrl.isNotEmpty) {
                                              await expertRegister(
                                                otp.text.toString(),
                                                email.text.toString(),
                                                expertName.text.toString(),
                                                "+91${phoneNumber.text}",
                                                controller2.selected.value.toLowerCase(),
                                                password.text.toString(),
                                                docUrl,
                                                "",
                                                docNumber,
                                                controller,
                                              );
                                            } else {
                                              Fluttertoast.showToast(msg: "Image upload error or Processing Error");
                                            }
                                          } else {}
                                        } else {
                                          Fluttertoast.showToast(msg: "Fields are Empty or Invalid");
                                        }
                                      }
                                    },
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: primary(),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(8))),
                                        elevation: const MaterialStatePropertyAll(10),
                                        backgroundColor: MaterialStatePropertyAll(primary())),
                                    child: (controller.loadingRegister.value)
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 4,
                                              color: Themes().primaryText,
                                            ),
                                          )
                                        : Text(
                                            "Register",
                                            style: pwText(16, Themes().primaryText),
                                          ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
