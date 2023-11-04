// AskToExpertForFarmers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api/api.dart';
import '../../../service/navigation_service.dart';
import '../../../states/GetX/ask_to_expert/ask_to_expert_farmer_getx.dart';
import '../../../themes/themes.dart';

class AskToExpertForFarmer extends StatefulWidget {
  const AskToExpertForFarmer({super.key});

  @override
  State<AskToExpertForFarmer> createState() => _AskToExpertForFarmerState();
}

class _AskToExpertForFarmerState extends State<AskToExpertForFarmer> {
  final AskToExpertForFarmerController controller = Get.put(AskToExpertForFarmerController());
  TextEditingController chatTexter = TextEditingController();
  final fstoresnapshot = doubtStreamForFarmer();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        backgroundColor: pBackground(),
        drawer: const DrawerNavigationForFarmers(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: pBackground(),
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
          automaticallyImplyLeading: false,
          title: Text(
            "Ask To Expert".tr,
            style: pwText(22, pText()),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: fstoresnapshot,
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
                              Text("No Doubts !! Start Asking.".tr, style: pwText(18, pText())),
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
                          itemBuilder: (context, index) {
                            return Column(
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
                                                    doubtDeleteForFarmer(snapshot, index);
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
                                        middleText: "Are you want to\ndelete this question?".tr,
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
                                                        Text("Doubt :".tr, textAlign: TextAlign.center, style: pwText(16, pText())),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                                      child: Text(snapshot.data!.docs[index]['question'], style: pwText(16, pText())),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                            child: Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                width: 100,
                                                                height: 40,
                                                                child: ElevatedButton(
                                                                  onPressed: () async {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => AskToExpertForFarmerAnswers(
                                                                                  doubtAnswersList: snapshot.data!.docs[index]['doubtAnswersList'],
                                                                                  title: snapshot.data!.docs[index]['question'],
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
                                                                    "Answers".tr,
                                                                    style: pwText(15, Themes().primaryText),
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
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
              child: Material(
                color: Colors.transparent,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: sBackground(),
                    borderRadius: BorderRadius.circular(10),
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
                            child: TextFormField(
                              controller: chatTexter,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "Ask Agricultural Doubts".tr,
                                hintStyle: pwText(18, sText()),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: pwText(18, pText()),
                              cursorColor: sText(),
                            )),
                      ),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(10)),
                        child: Obx(() {
                          return (controller.apiResponce.value == false)
                              ? IconButton(
                                  onPressed: () async {
                                    if (chatTexter.text.isNotEmpty && chatTexter.text.length > 30) {
                                      controller.apiResponce.value = true;
                                      if (await abuseWordFilter(chatTexter.text.toString())) {
                                        await askToExpert(chatTexter.text.toString(), controller);
                                        chatTexter.clear();
                                      } else {
                                        controller.apiResponce.value = false;
                                      }
                                    } else {
                                      Fluttertoast.showToast(msg: "Doubt is Empty or Short Doubt".tr);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: pText(),
                                    size: 30,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: pText(),
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AskToExpertForFarmerAnswers extends StatelessWidget {
  const AskToExpertForFarmerAnswers({super.key, required this.doubtAnswersList, required this.title});

  final List doubtAnswersList;
  final String title;

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
          "Answers".tr,
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: // Generated code for this Column Widget...
          Column(
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
                  title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: pwText(16, pBackground()),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: (doubtAnswersList.isNotEmpty)
                  ? ListView.builder(
                      itemCount: doubtAnswersList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
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
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Answer :".tr,
                                                textAlign: TextAlign.center,
                                                style: pwText(16, pText()),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                            child: Text(
                                              doubtAnswersList[index]['solution'],
                                              style: pwText(16, pText()),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "External Link :".tr,
                                                      textAlign: TextAlign.center,
                                                      style: pwText(16, pText()),
                                                    ),
                                                    InkWell(
                                                      child: Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                                        child: Text(
                                                          doubtAnswersList[index]['externalLink'],
                                                          style: pwText(16, const Color(0xFF4B39EF)),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        await launchUrl(Uri.parse(doubtAnswersList[index]['externalLink']));
                                                      },
                                                    ),
                                                  ],
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
                                          await profileImageShow(
                                              context, doubtAnswersList[index]['expertImageUrl'], doubtAnswersList[index]['expertName']);
                                        },
                                        child: profileImageWidget(doubtAnswersList[index]['expertImageUrl'])),
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
                            Text("No solutions given by Experts.\n Wait for some time.".tr, textAlign: TextAlign.center, style: pwText(18, pText())),
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
