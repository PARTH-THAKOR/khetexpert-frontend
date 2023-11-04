// SettingsForApplication

import 'dart:io';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khetexpert/api/api.dart';
import 'package:khetexpert/service/firebase_login.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:khetexpert/service/navigation_service.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:khetexpert/states/GetX/settings_/setting_controller_getx.dart';
import 'package:khetexpert/themes/themes.dart';
import '../../navigation_/drawers.dart';
import '../developers_note.dart';

class SettingsForFarmer extends StatefulWidget {
  const SettingsForFarmer({super.key});

  @override
  State<SettingsForFarmer> createState() => _SettingsForFarmerState();
}

class _SettingsForFarmerState extends State<SettingsForFarmer> {
  final SettingsLanguageController controller = Get.put(SettingsLanguageController());
  var items = ["English", "हिंदी", "ગુજરાતી"];

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        drawer: const DrawerNavigationForFarmers(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: pBackground(),
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: primary(),
              ),
            );
          }),
          title: Text(
            "Settings".tr,
            style: pwText(22, pText()),
          ),
          centerTitle: true,
        ),
        backgroundColor: pBackground(),
        body: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Container(
                    width: 150,
                    height: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                        onTap: () async {
                          await profileImageShow(context, farmer.imgUrl!, farmer.name!);
                        },
                        child: profileImageWidget(farmer.imgUrl!)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    '${'Farmer :'.tr} ${farmer.name!}',
                    style: pwText(24, pText()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            Get.to(const FarmerProfileEdit());
                          },
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: primary(),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8))),
                              elevation: const MaterialStatePropertyAll(10),
                              backgroundColor: MaterialStatePropertyAll(pBackground())),
                          child: Text(
                            "Edit Profile".tr,
                            style: pwText(16, primary()),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color: primary(),
                      size: 30,
                    ),
                    title: Text(
                      "Dark Mode".tr,
                      style: pwText(20, pText()),
                    ),
                    subtitle: Text(
                      'Change the theme of application'.tr,
                      style: swText(14, sText()),
                    ),
                    trailing: Switch(
                      value: darkMode,
                      activeColor: primary(),
                      onChanged: (bool value) async {
                        await saveThemeMode(value);
                      },
                    ),
                    tileColor: pBackground(),
                    dense: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.language,
                      color: primary(),
                      size: 30,
                    ),
                    title: Text(
                      "Language".tr,
                      style: pwText(20, pText()),
                    ),
                    subtitle: Text(
                      'Change the language of application'.tr,
                      style: swText(14, sText()),
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(color: sBackground(), borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                        child: Obx(() => DropdownButton(
                              value: controller.selected.value,
                              padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 5),
                              dropdownColor: sBackground(),
                              style: pwText(18, pText()),
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(8),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: primary(),
                              ),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                await controller.updateLanguage(newValue!);
                              },
                            )),
                      ),
                    ),
                    tileColor: pBackground(),
                    dense: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.webhook,
                      color: primary(),
                      size: 30,
                    ),
                    onTap: () {
                      Get.to(const DevelopersNote());
                    },
                    title: Text(
                      'About Developers'.tr,
                      style: pwText(20, pText()),
                    ),
                    subtitle: Text(
                      'Know about the developers of application.'.tr,
                      style: swText(14, sText()),
                    ),
                    tileColor: pBackground(),
                    dense: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: primary(),
                      size: 30,
                    ),
                    onTap: () {
                      Get.defaultDialog(
                          title: "Alert".tr,
                          confirm: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                width: 120,
                                height: 40,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await firebaseLogOut();
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
                                    child: Text(
                                      "LogOut".tr,
                                      style: pwText(15, Themes().primaryText),
                                    ))),
                          ),
                          titleStyle: pwText(20, pText()),
                          backgroundColor: pBackground(),
                          middleText: "Are you want to\nlogout this Application?".tr,
                          middleTextStyle: pwText(16, pText()));
                    },
                    title: Text(
                      'Log out'.tr,
                      style: pwText(20, pText()),
                    ),
                    subtitle: Text('Click to log out from this application'.tr, style: swText(14, sText())),
                    tileColor: pBackground(),
                    dense: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 40, 10, 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'KhetExpert.inc \nv2.0.1'.tr,
                        textAlign: TextAlign.center,
                        style: swText(16, primary()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FarmerProfileEdit extends StatefulWidget {
  const FarmerProfileEdit({super.key});

  @override
  State<FarmerProfileEdit> createState() => _FarmerProfileEditState();
}

class _FarmerProfileEditState extends State<FarmerProfileEdit> {
  TextEditingController controller = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  final FarmerProfileEditController editController = Get.put(FarmerProfileEditController());

  @override
  void initState() {
    controller.text = farmer.name!;
    super.initState();
  }

  getImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      (pickedImage != null) ? _image = File(pickedImage.path) : debugPrint("no img selected");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: pBackground(),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: primary(),
            )),
        title: Text(
          "Edit Profile".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      backgroundColor: pBackground(),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                child: Container(
                    width: 200,
                    height: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onLongPress: () async {
                        kIsWeb ? Fluttertoast.showToast(msg: "Image Change is not supported on web".tr) : await getImageFromGallery();
                      },
                      child: (_image == null)
                          ? profileImageWidget(farmer.imgUrl!)
                          : Image.file(
                              File(_image!.absolute.path),
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Text(
                  'Long Press To Edit Image !'.tr,
                  style: pwText(18, pText()),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 40, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: pBackground(),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: primary(),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: TextFormField(
                            controller: controller,
                            autofocus: false,
                            obscureText: false,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: pwText(22, pText()),
                            cursorColor: sText(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Text(
                        'Edit your new Name'.tr,
                        style: pwText(14, pText()),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 50, 20),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 30),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    height: 55,
                    child: Obx(() => ElevatedButton(
                          onPressed: () async {
                            editController.load.value = true;
                            if (controller.text.isNotEmpty) {
                              if (_image == null) {
                                await farmerProfileUpdate(controller.text.toString(), farmer.imgUrl!, editController);
                              } else {
                                String imgUrl = await imageUploadOnStorage(_image);
                                if (imgUrl.isNotEmpty) {
                                  await farmerProfileUpdate(controller.text.toString(), imgUrl, editController);
                                } else {
                                  Fluttertoast.showToast(msg: "Image Upload Error".tr);
                                  editController.load.value = false;
                                }
                              }
                            } else {
                              Fluttertoast.showToast(msg: "Name is Empty".tr);
                              editController.load.value = false;
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
                          child: (editController.load.value)
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: Themes().primaryText,
                                  ),
                                )
                              : Text(
                                  "Update Profile".tr,
                                  style: pwText(16, Themes().primaryText),
                                ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
