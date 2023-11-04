// DrawerNavigation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/appointment/for_expert/appointment_expert.dart';
import 'package:khetexpert/layouts/appointment/for_farmer/appointment_farmer.dart';
import 'package:khetexpert/layouts/ask_to_expert/for_expert/expert_doubt_solution.dart';
import 'package:khetexpert/layouts/ask_to_expert/for_farmer/ask_to_expert_farmer.dart';
import 'package:khetexpert/layouts/blog/for_expert/blog_expert.dart';
import 'package:khetexpert/layouts/blog/for_farmer/blog_farmer.dart';
import 'package:khetexpert/layouts/chatbot/chatbot.dart';
import 'package:khetexpert/layouts/disease_solution/for_expert/expert_disease_detection.dart';
import 'package:khetexpert/layouts/disease_solution/for_farmer/disease_solution_farmers.dart';
import 'package:khetexpert/layouts/news/news.dart';
import 'package:khetexpert/layouts/settings_/for_farmer/settings_farmer.dart';
import 'package:khetexpert/service/navigation_service.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:khetexpert/states/GetX/navigation_/drawer_navigation_getx.dart';
import '../../themes/themes.dart';
import '../settings_/for_expert/settings_expert.dart';

final DrawerControllerForFarmer drawerControllerForFarmer = Get.put(DrawerControllerForFarmer());
final DrawerControllerForExpert drawerControllerForExpert = Get.put(DrawerControllerForExpert());

class DrawerNavigationForFarmers extends StatelessWidget {
  const DrawerNavigationForFarmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: sBackground(),
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
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
                        child: profileImageWidget(farmer.imgUrl!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Text(
                      farmer.name!,
                      style: pwText(24, pText()),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "1") {
                            Get.off(const DiseaseSolutionForFarmers());
                            drawerControllerForFarmer.nav.value = "1";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Plant disease detection'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "1") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "2") {
                            Get.off(const AskToExpertForFarmer());
                            drawerControllerForFarmer.nav.value = "2";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Ask any agricultural doubts'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "2") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "3") {
                            Get.off(const BlogForFarmer());
                            drawerControllerForFarmer.nav.value = "3";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            "Read expert's blogs".tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "3") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "4") {
                            Get.off(const ChatBot());
                            drawerControllerForFarmer.nav.value = "4";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'A.I.  AskGround'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "4") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "5") {
                            Get.off(const News());
                            drawerControllerForFarmer.nav.value = "5";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Trending agricultural news'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "5") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "6") {
                            Get.off(const AppointmentForFarmer());
                            drawerControllerForFarmer.nav.value = "6";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'My Appointments'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "6") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForFarmer.nav.value != "7") {
                            Get.off(const SettingsForFarmer());
                            drawerControllerForFarmer.nav.value = "7";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Settings'.tr,
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForFarmer.nav.value == "7") ? primary() : sBackground(),
                        dense: false,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 30),
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
    );
  }
}

class DrawerNavigationForExpert extends StatelessWidget {
  const DrawerNavigationForExpert({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: sBackground(),
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
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
                          await profileImageShow(context, expert.imageUrl!, expert.expertName!);
                        },
                        child: profileImageWidget(expert.imageUrl!),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Text(
                      expert.expertName!,
                      style: pwText(24, pText()),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForExpert.nav.value != "1") {
                            Get.off(const ExpertDiseaseDetection());
                            drawerControllerForExpert.nav.value = "1";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Identify Plant Disease',
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForExpert.nav.value == "1") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForExpert.nav.value != "2") {
                            Get.off(const ExpertDoubtSolution());
                            drawerControllerForExpert.nav.value = "2";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            "Solve Farmer's Doubt",
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForExpert.nav.value == "2") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForExpert.nav.value != "3") {
                            Get.off(const BlogForExpert());
                            drawerControllerForExpert.nav.value = "3";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Read expert\'s blogs',
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForExpert.nav.value == "3") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForExpert.nav.value != "4") {
                            Get.off(const AppointmentForExpert());
                            drawerControllerForExpert.nav.value = "4";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'My Appointments',
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForExpert.nav.value == "4") ? primary() : sBackground(),
                        dense: false,
                      )),
                  Obx(() => ListTile(
                        onTap: () {
                          if (drawerControllerForExpert.nav.value != "5") {
                            Get.off(const SettingsForExpert());
                            drawerControllerForExpert.nav.value = "5";
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: Text(
                            'Settings',
                            style: pwText(18, pText()),
                          ),
                        ),
                        tileColor: (drawerControllerForExpert.nav.value == "5") ? primary() : sBackground(),
                        dense: false,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'KhetExpert.inc \nv2.0.1',
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
    );
  }
}
