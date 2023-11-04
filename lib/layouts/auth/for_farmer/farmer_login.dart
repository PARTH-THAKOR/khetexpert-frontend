// FarmerLogin

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khetexpert/service/firebase_login.dart';
import 'package:khetexpert/states/GetX/login/login_getx.dart';
import 'package:khetexpert/themes/themes.dart';
import '../../../states/GetX/settings_/setting_controller_getx.dart';
import '../../navigation_/application_mode.dart';

class FarmerLogin extends StatefulWidget {
  const FarmerLogin({super.key});

  @override
  State<FarmerLogin> createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final FarmerLoginController controller = Get.put(FarmerLoginController());
  final StateSelectionController controller2 = Get.put(StateSelectionController());

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
          title: Text(
            "Farmer Login".tr,
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
                      'Login via mobile number'.tr,
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
                                controller: name,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter Name'.tr,
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
                          'Enter your name for Identification'.tr,
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
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter mobile number'.tr,
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
                          'Enter primary mobile number for services'.tr,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter your state'.tr,
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
                    leading: Icon(
                      Icons.join_right,
                      color: primary(),
                    ),
                    title: Text(
                      'Enabled SMS reading permission'.tr,
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
                                    if (name.text.isEmpty || phoneNumber.text.isEmpty) {
                                      Fluttertoast.showToast(msg: "Fields are Empty".tr);
                                    } else if (phoneNumber.text.length != 10) {
                                      Fluttertoast.showToast(msg: "Invalid PhoneNumber".tr);
                                    } else {
                                      firebaseSendOTP(name.text.toString(), phoneNumber.text.toString(),
                                          controller2.selected.value.toLowerCase().toString(), controller, context);
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
                                          "Send OTP".tr,
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
        ],
      ),
    );
  }
}

class FarmerOTPVerification extends StatefulWidget {
  const FarmerOTPVerification({super.key, required this.id, required this.name, required this.state});

  final String id;
  final String name;
  final String state;

  @override
  State<FarmerOTPVerification> createState() => _FarmerOTPVerificationState();
}

class _FarmerOTPVerificationState extends State<FarmerOTPVerification> {
  TextEditingController otp = TextEditingController();
  final FarmerLoginController controller = Get.put(FarmerLoginController());

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
            "Verify OTP".tr,
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
                      'Verify OTP Code'.tr,
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
                                controller: otp,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Enter OTP'.tr,
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Enter your OTP for Verification'.tr,
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
                    leading: Icon(
                      Icons.join_right,
                      color: primary(),
                    ),
                    title: Text(
                      'Enabled SMS reading permission'.tr,
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
                                    if (otp.text.isEmpty) {
                                      Fluttertoast.showToast(msg: "Fields are Empty".tr);
                                    } else {
                                      await firebaseVerifyOTP(widget.id.toString(), otp.text.toString(), widget.name.toString(),
                                          widget.state.toString(), controller, context);
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
                                  child: (controller.loadingOTP.value)
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 4,
                                            color: Themes().primaryText,
                                          ),
                                        )
                                      : Text(
                                          "Verify".tr,
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
        ],
      ),
    );
  }
}
