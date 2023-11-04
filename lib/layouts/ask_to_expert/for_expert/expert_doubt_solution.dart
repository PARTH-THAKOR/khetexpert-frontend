// ExpertDoubtSolution

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
import '../../../states/GetX/ask_to_expert/doubt_solution_getx.dart';
import '../../../themes/themes.dart';

class ExpertDoubtSolution extends StatefulWidget {
  const ExpertDoubtSolution({super.key});

  @override
  State<ExpertDoubtSolution> createState() => _ExpertDoubtSolutionState();
}

class _ExpertDoubtSolutionState extends State<ExpertDoubtSolution> {
  TextEditingController chatTexter = TextEditingController();
  final fstoresnapshot = doubtStreamForExpert();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        drawer: const DrawerNavigationForExpert(),
        backgroundColor: pBackground(),
        appBar: AppBar(
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
          elevation: 0,
          backgroundColor: pBackground(),
          automaticallyImplyLeading: false,
          title: Text(
            "Farmer's Doubts",
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
                    } else if (!snapshot.hasData) {
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
                              Text("No Doubts !!", style: pwText(18, pText())),
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
                              Text('Sorry !! Error Occurred , Try again Later ', style: pwText(18, pText())),
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
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
                                                      context, snapshot.data!.docs[index]['farmerImgUrl'], snapshot.data!.docs[index]['farmerName']);
                                                },
                                                child: profileImageWidget(snapshot.data!.docs[index]['farmerImgUrl'])),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                      Text("Doubt :", textAlign: TextAlign.center, style: pwText(16, pText())),
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
                                                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                                          child: Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                              width: 100,
                                                              height: 40,
                                                              child: ElevatedButton(
                                                                onPressed: () async {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ExpertDoubtAnswersReadPage(
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
                                                                  "Answers",
                                                                  style: pwText(15, Themes().primaryText),
                                                                ),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                                          child: Container(
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                              width: 130,
                                                              height: 40,
                                                              child: ElevatedButton(
                                                                onPressed: () async {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ExpertDoubtSolutionWritePage(
                                                                                docId: snapshot.data!.docs[index]['docId'],
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
                                                                  "Write Answer",
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
                              ],
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpertDoubtAnswersReadPage extends StatelessWidget {
  const ExpertDoubtAnswersReadPage({super.key, required this.doubtAnswersList, required this.title});

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
          "Answers",
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
                                                "Answer :",
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
                                                      "External Link :",
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
                            Text("No solutions given by Experts.", style: pwText(18, pText())),
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

class ExpertDoubtSolutionWritePage extends StatefulWidget {
  const ExpertDoubtSolutionWritePage({super.key, required this.docId});

  final String docId;

  @override
  State<ExpertDoubtSolutionWritePage> createState() => _ExpertDoubtSolutionWritePageState();
}

class _ExpertDoubtSolutionWritePageState extends State<ExpertDoubtSolutionWritePage> {
  final ExpertDoubtSolutionWriteController controller = Get.put(ExpertDoubtSolutionWriteController());
  TextEditingController solutionWrite = TextEditingController();
  TextEditingController linkWrite = TextEditingController();

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
          "Write Answer",
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: // Generated code for this ListView Widget...
          ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
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
                        controller: solutionWrite,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Solution',
                          hintStyle: pwText(20, sText()),
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
                  'Write solution of doubt',
                  style: swText(16, sText()),
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
                        controller: linkWrite,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Add External Link',
                          hintStyle: pwText(20, sText()),
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
                  'Add external link to solution',
                  style: swText(16, sText()),
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
                        title: "Alert",
                        confirm: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            width: 100,
                            height: 40,
                            child: Obx(() => ElevatedButton(
                                onPressed: () async {
                                  if (solutionWrite.text.toString().length > 100) {
                                    if (solutionWrite.text.toString().isEmpty) {
                                      Fluttertoast.showToast(msg: "Solution is Empty");
                                    } else if (linkWrite.text.isNotEmpty &&
                                        !(linkWrite.text.toString().contains("http://") || linkWrite.text.toString().contains("https://"))) {
                                      Fluttertoast.showToast(msg: "link is Invalid");
                                    } else {
                                      controller.apiResponce.value = true;
                                      if (await abuseWordFilter(solutionWrite.text.toString())) {
                                        await writeDoubtAnswer(solutionWrite.text.toString(), widget.docId, linkWrite.text.toString(), controller);
                                        Navigator.pop(Get.overlayContext!, true);
                                        Fluttertoast.showToast(msg: "Solution Submitted");
                                        solutionWrite.clear();
                                        linkWrite.clear();
                                      } else {
                                        controller.apiResponce.value = false;
                                      }
                                    }
                                  } else {
                                    Fluttertoast.showToast(msg: "Solution is sort");
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
                                        "Submit",
                                        style: pwText(15, Themes().primaryText),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: CircularProgressIndicator(
                                          color: pText(),
                                        ),
                                      ))),
                          ),
                        ),
                        titleStyle: pwText(20, pText()),
                        backgroundColor: pBackground(),
                        middleText: "Confirm solution and link,\nbecause they are not updatable\nin future.",
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
                    "Submit",
                    style: pwText(15, Themes().primaryText),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
