// ExpertBlogSection

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khetexpert/api/api.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/image_processing.dart';
import 'package:khetexpert/states/GetX/disease_solution/disease_solution_getx.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../language/translator.dart';
import '../../../service/firebase_service.dart';
import '../../../service/navigation_service.dart';
import '../../../settings/settings.dart';
import '../../../themes/themes.dart';

class DiseaseSolutionForFarmers extends StatefulWidget {
  const DiseaseSolutionForFarmers({super.key});

  @override
  State<DiseaseSolutionForFarmers> createState() => _DiseaseSolutionForFarmersState();
}

class _DiseaseSolutionForFarmersState extends State<DiseaseSolutionForFarmers> with TickerProviderStateMixin {
  late TabController tabController;
  final fstoresnapshotpersonal = diseaseQuestionStream();
  DateTime bbk = DateTime.now();

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        drawer: const DrawerNavigationForFarmers(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            backgroundColor: primary(),
            child: Icon(
              Icons.menu,
              color: sBackground(),
            ),
          );
        }),
        appBar: AppBar(
          backgroundColor: pBackground(),
          elevation: 0,
          toolbarHeight: 1,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            indicatorColor: primary(),
            tabs: [
              Tab(
                  child: Text(
                "Write for Help".tr,
                style: pwText(16, primary()),
              )),
              Tab(
                  child: Text(
                "My Questions".tr,
                style: pwText(16, primary()),
              )),
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          Scaffold(
              backgroundColor: pBackground(),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: primary(),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.linked_camera_outlined,
                        color: pBackground(),
                        size: 50,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        height: 55,
                        width: 300,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DiseaseWriteForFarmers()));
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
                              "Detect your Plant disease".tr,
                              style: pwText(15, primary()),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
          Scaffold(
            backgroundColor: pBackground(),
            body: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: fstoresnapshotpersonal,
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primary(),
                              ),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                  child: Lottie.network(
                                    'https://assets3.lottiefiles.com/packages/lf20_SI8fvW.json',
                                    width: 150,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    animate: true,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No Questions yet !!".tr, style: pwText(18, pText())),
                                  ],
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                  child: Lottie.network(
                                    'https://assets3.lottiefiles.com/packages/lf20_SI8fvW.json',
                                    width: 150,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    animate: true,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Sorry !! Error Occurred , Try again Later '.tr, style: pwText(18, pText())),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        InkWell(
                                          onLongPress: () {
                                            Get.defaultDialog(
                                                title: "Alert".tr,
                                                confirm: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                  child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            diseaseQuestionDelete(snapshot, index);
                                                            Navigator.pop(Get.overlayContext!, true);
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
                                                            "Delete".tr,
                                                            style: pwText(15, Themes().primaryText),
                                                          ))),
                                                ),
                                                titleStyle: pwText(20, pText()),
                                                backgroundColor: pBackground(),
                                                middleText: "Are you want to\ndelete this Question?".tr,
                                                middleTextStyle: pwText(16, pText()));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: sBackground(),
                                                      borderRadius: BorderRadius.circular(15),
                                                      border: Border.all(
                                                        color: primary(),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                                      child: Container(
                                                        width: 100,
                                                        decoration: const BoxDecoration(),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      child: Image.network(
                                                                        snapshot.data!.docs[index]['imgUrls'][0],
                                                                        width: double.infinity,
                                                                        height: MediaQuery.sizeOf(context).height * 0.25,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                    child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8),
                                                                      child: Image.network(
                                                                        snapshot.data!.docs[index]['imgUrls'][1],
                                                                        width: double.infinity,
                                                                        height: MediaQuery.sizeOf(context).height * 0.25,
                                                                        fit: BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                                              child: Text(
                                                                snapshot.data!.docs[index]['question'],
                                                                style: pwText(16, pText()),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                                                    child: Container(
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                      width: 120,
                                                                      height: 40,
                                                                      child: ElevatedButton(
                                                                          onPressed: () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => DiseaseAnswersForFarmers(
                                                                                        answerList: snapshot.data!.docs[index]['diseaseAnswersList'],
                                                                                        question: snapshot.data!.docs[index]['question'])));
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
                                                                            "Solutions".tr,
                                                                            style: pwText(18, Themes().primaryText),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class DiseaseAnswersForFarmers extends StatelessWidget {
  const DiseaseAnswersForFarmers({super.key, required this.answerList, required this.question});

  final List answerList;
  final String question;

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
          "Solutions".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primary(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                  question,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: pwText(16, pText()),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: (answerList.isNotEmpty)
                  ? ListView.builder(
                      itemCount: answerList.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: sBackground(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                    child: Container(
                                      width: 100,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Disease : ".tr,
                                                  textAlign: TextAlign.center,
                                                  style: pwText(16, pText()),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                  child: Text(
                                                    answerList[index]['disease'],
                                                    textAlign: TextAlign.center,
                                                    style: pwText(16, pText()),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Solution :".tr,
                                                textAlign: TextAlign.center,
                                                style: pwText(16, pText()),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                            child: Text(
                                              answerList[index]['solution'],
                                              maxLines: 10,
                                              style: pwText(16, pText()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                                  child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => DiseaseReadPageForFarmers(
                                                                        expImg: answerList[index]['expertImageUrl'],
                                                                        solution: answerList[index]['solution'],
                                                                        disease: answerList[index]['disease'],
                                                                        link: (answerList[index]['externalLink'] != null)
                                                                            ? answerList[index]['externalLink']
                                                                            : "null",
                                                                        description: answerList[index]['description'],
                                                                        expertName: answerList[index]['expertName'],
                                                                        expertEmailId: answerList[index]['expertEmailId'],
                                                                        expertId: answerList[index]['expertId'],
                                                                        expertMobileNumber: answerList[index]['expertPhoneNumber'],
                                                                      )));
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
                                                          "Read".tr,
                                                          style: pwText(18, Themes().primaryText),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 10, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                        onTap: () async {
                                          await profileImageShow(context, answerList[index]['expertImageUrl'], answerList[index]['expertName']);
                                        },
                                        child: profileImageWidget(answerList[index]['expertImageUrl'])),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: Lottie.network(
                            'https://assets3.lottiefiles.com/packages/lf20_SI8fvW.json',
                            width: 150,
                            height: 130,
                            fit: BoxFit.cover,
                            animate: true,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("No Solutions yet !!".tr, style: pwText(18, pText())),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiseaseReadPageForFarmers extends StatefulWidget {
  const DiseaseReadPageForFarmers(
      {super.key,
      required this.expImg,
      required this.expertEmailId,
      required this.expertId,
      required this.expertMobileNumber,
      required this.solution,
      required this.disease,
      required this.link,
      required this.description,
      required this.expertName});

  final String expertEmailId;
  final String expertId;
  final String expertMobileNumber;
  final String expImg;
  final String solution;
  final String description;
  final String disease;
  final String link;
  final String expertName;

  @override
  State<DiseaseReadPageForFarmers> createState() => _DiseaseReadPageForFarmersState();
}

class _DiseaseReadPageForFarmersState extends State<DiseaseReadPageForFarmers> {
  final DiseaseReadForFarmersController controller = Get.put(DiseaseReadForFarmersController());
  FlutterTts flutterTts = FlutterTts();

  speak(String text, String langCode) async {
    await flutterTts.setLanguage(langCode);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
    flutterTts.setCompletionHandler(() {
      controller.micSwitch.value = false;
    });
  }

  @override
  void initState() {
    controller.langSwitch.value = false;
    controller.description.value = widget.description;
    controller.solution.value = widget.solution;
    controller.expertName.value = widget.expertName;
    controller.disease.value = widget.disease;
    super.initState();
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
          onPressed: () {
            controller.micSwitch.value = false;
            flutterTts.stop();
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Read Solution".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: sBackground(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                                onTap: () async {
                                  await profileImageShow(context, widget.expImg, widget.expertName);
                                },
                                child: profileImageWidget(widget.expImg)),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Obx(() => Text(
                                  controller.expertName.value,
                                  style: pwText(18, pText()),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width * 0.7,
                          ),
                          decoration: BoxDecoration(
                            color: sBackground(),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Obx(() => Text(
                                  '${'Disease :'.tr} ${controller.disease.value}',
                                  style: pwText(20, pText()),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            width: 90,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiseaseAIForFarmers(disease: widget.disease)));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: primary(),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8))),
                                    elevation: const MaterialStatePropertyAll(10),
                                    backgroundColor: MaterialStatePropertyAll(sBackground())),
                                child: Text(
                                  "A.I.".tr,
                                  style: pwText(18, primary()),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Obx(() => Text(
                            '${'Description :'.tr} ${controller.description.value}',
                            style: pwText(20, pText()),
                          )),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            width: 100,
                            height: 40,
                            child: Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    if (controller.langSwitch.value) {
                                      controller.langSwitch.value = false;
                                      controller.lang.value = "en";
                                      controller.description.value = widget.description;
                                      controller.solution.value = widget.solution;
                                      controller.expertName.value = widget.expertName;
                                      controller.disease.value = widget.disease;
                                    } else {
                                      controller.langSwitch.value = true;
                                      controller.lang.value = appLangCode;
                                      await controller.changeDescription(changeValueEnToOtherApp(widget.description, appLangCode));
                                      await controller.changeSolution(changeValueEnToOtherApp(widget.solution, appLangCode));
                                      await controller.changeExpertName(changeValueEnToOtherApp(widget.expertName, appLangCode));
                                      await controller.changeDisease(changeValueEnToOtherApp(widget.disease, appLangCode));
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
                                      backgroundColor: (!controller.langSwitch.value)
                                          ? MaterialStatePropertyAll(sBackground())
                                          : MaterialStatePropertyAll(primary())),
                                  child: Text(
                                    globalLanguage,
                                    style: pwText(15, (!controller.langSwitch.value) ? primary() : Themes().primaryText),
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(100)),
                            child: Obx(() => IconButton(
                                  onPressed: () async {
                                    if (controller.micSwitch.value) {
                                      controller.micSwitch.value = false;
                                      flutterTts.stop();
                                    } else {
                                      controller.micSwitch.value = true;
                                      await speak(controller.solution.value, controller.lang.value);
                                    }
                                  },
                                  icon: Icon(
                                    (!controller.micSwitch.value) ? Icons.mic : Icons.stop,
                                    color: sBackground(),
                                    size: 24,
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Obx(() => Text(
                            '${'Solution :'.tr} ${controller.solution.value}',
                            style: pwText(16, pText()),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "External Links :".tr,
                            style: pwText(18, pText()),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.micSwitch.value = false;
                              flutterTts.stop();
                              await launchUrl(Uri.parse(widget.link));
                            },
                            child: Text(
                              widget.link,
                              style: pwText(18, link()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(50, 10, 50, 20),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        height: 55,
                        child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              if (sharedPreferences.containsKey("app${widget.expertId + widget.disease}")) {
                                Fluttertoast.showToast(msg: "Request Already Exist".tr);
                              } else {
                                await requestAppointment(widget.expertId, widget.expertEmailId, widget.expertName, widget.expImg,
                                    widget.expertMobileNumber, widget.disease);
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
                                backgroundColor: MaterialStatePropertyAll(sBackground())),
                            child: Text(
                              "Request for Appointment".tr,
                              style: pwText(16, primary()),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiseaseAIForFarmers extends StatefulWidget {
  const DiseaseAIForFarmers({super.key, required this.disease});

  final String disease;

  @override
  State<DiseaseAIForFarmers> createState() => _DiseaseAIForFarmersState();
}

class _DiseaseAIForFarmersState extends State<DiseaseAIForFarmers> {
  final DiseaseAIForFarmersController controller = Get.put(DiseaseAIForFarmersController());

  @override
  void initState() {
    controller.apiResponceString.value = "";
    diseaseAICall(widget.disease, controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "A.I. Generated Disease details".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      backgroundColor: pBackground(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: primary(),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Text(
                    "${"About".tr} ${widget.disease}",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: pwText(16, pText()),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Obx(() {
                if (controller.apiResponceString.value == "") {
                  return Center(
                    child: CircularProgressIndicator(
                      color: primary(),
                    ),
                  );
                } else {
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: sBackground(),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                  child: Container(
                                    width: 100,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                                          child: Obx(() => Text(
                                                controller.apiResponceString.value,
                                                style: pwText(16, pText()),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class DiseaseWriteForFarmers extends StatefulWidget {
  const DiseaseWriteForFarmers({super.key});

  @override
  State<DiseaseWriteForFarmers> createState() => _DiseaseWriteForFarmersState();
}

class _DiseaseWriteForFarmersState extends State<DiseaseWriteForFarmers> {
  File? _image;
  File? _image2;
  final picker = ImagePicker();
  TextEditingController questionTexter = TextEditingController();
  final DiseaseWriteController controller = Get.put(DiseaseWriteController());

  getImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      (pickedImage != null) ? _image = File(pickedImage.path) : debugPrint("no img selected");
    });
  }

  getImageFromGallery2() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      (pickedImage != null) ? _image2 = File(pickedImage.path) : debugPrint("no img selected");
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
          "Ask for disease identification".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
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
                        controller: questionTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Write Question".tr,
                          hintStyle: swText(20, sText()),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        style: pwText(20, pText()),
                        maxLines: null,
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
                  "Write your question".tr,
                  style: swText(14, sText()),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (kIsWeb) {
                Fluttertoast.showToast(msg: "Not supported on web".tr);
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
                                    Fluttertoast.showToast(msg: "Not supported on web".tr);
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
                              "select image from Gallery".tr,
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
            padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Set Image Properly, it can not update further".tr,
                  style: swText(14, sText()),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (kIsWeb) {
                Fluttertoast.showToast(msg: "Not supported on web".tr);
              } else {
                await getImageFromGallery2();
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
                child: (_image2 == null)
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
                                    Fluttertoast.showToast(msg: "Not supported on web".tr);
                                  } else {
                                    await getImageFromGallery2();
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
                              "select image from Gallery".tr,
                              style: pwText(18, pText()),
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          File(_image2!.path),
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Set Image Properly, it can not update further".tr,
                  style: swText(14, sText()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 50, 20),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              height: 40,
              child: ElevatedButton(
                  onPressed: () async {
                    Get.defaultDialog(
                        title: "Alert".tr,
                        confirm: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              width: 100,
                              height: 40,
                              child: Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    if (kIsWeb) {
                                      Fluttertoast.showToast(msg: "Not supported on web".tr);
                                    } else {
                                      if (questionTexter.text.toString().length > 50) {
                                        if (questionTexter.text.toString().isNotEmpty) {
                                          if (_image != null || _image2 != null) {
                                            controller.apiResponce.value = true;
                                            if (await abuseWordFilter(questionTexter.text.toString())) {
                                              if (await agriculturalImageProcess(_image!) && await agriculturalImageProcess(_image2!)) {
                                                String url = "";
                                                String url2 = "";
                                                List<String> imgUrls = [];
                                                url = await imageUploadOnStorage(_image);
                                                url2 = await imageUploadOnStorage(_image2);
                                                if (url.toString().isNotEmpty && url2.toString().isNotEmpty) {
                                                  imgUrls.add(url);
                                                  imgUrls.add(url2);
                                                  await writeDisease(questionTexter.text.toString(), imgUrls, controller);
                                                  questionTexter.clear();
                                                  _image = null;
                                                  _image2 = null;
                                                  setState(() {});
                                                }
                                              } else {
                                                controller.apiResponce.value = false;
                                                Fluttertoast.showToast(msg: "Images are not agricultural related".tr);
                                              }
                                            } else {
                                              controller.apiResponce.value = false;
                                            }
                                          } else {
                                            Fluttertoast.showToast(msg: "Image is Empty".tr);
                                          }
                                        } else {
                                          Fluttertoast.showToast(msg: "content or title is Empty".tr);
                                        }
                                      } else {
                                        Fluttertoast.showToast(msg: "Question is sort".tr);
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
                                  child: (!controller.apiResponce.value)
                                      ? Text(
                                          "Submit".tr,
                                          style: pwText(15, Themes().primaryText),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: CircularProgressIndicator(
                                            color: pText(),
                                          ),
                                        )))),
                        ),
                        titleStyle: pwText(20, pText()),
                        backgroundColor: pBackground(),
                        middleText: "Confirm Question image,\nbecause It is not updatable\nin future.".tr,
                        middleTextStyle: pwText(16, pText()));
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
                    "Submit".tr,
                    style: pwText(15, Themes().primaryText),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
