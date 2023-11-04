// ExpertDiseaseDetection

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
import '../../../states/GetX/disease_solution/disease_detection_getx.dart';
import '../../../themes/themes.dart';

class ExpertDiseaseDetection extends StatefulWidget {
  const ExpertDiseaseDetection({super.key});

  @override
  State<ExpertDiseaseDetection> createState() => _ExpertDiseaseDetectionState();
}

class _ExpertDiseaseDetectionState extends State<ExpertDiseaseDetection> {
  final fstoresnapshotpersonal = diseaseQuestionsForExpert();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        backgroundColor: pBackground(),
        drawer: const DrawerNavigationForExpert(),
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
            "Detect Disease",
            style: pwText(22, pText()),
          ),
          centerTitle: true,
        ),
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
                                Text("No Questions Yet!!", style: pwText(18, pText())),
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
                            itemBuilder: (context, index) => Column(
                                  children: [
                                    InkWell(
                                      onLongPress: () {},
                                      child: Row(
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
                                                        await profileImageShow(context, snapshot.data!.docs[index]['farmerImgUrl'],
                                                            snapshot.data!.docs[index]['farmerName']);
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
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ExpertDiseaseImageShow(
                                                                                  img1: snapshot.data!.docs[index]['imgUrls'][0],
                                                                                  img2: snapshot.data!.docs[index]['imgUrls'][1],
                                                                                  question: snapshot.data!.docs[index]['question'],
                                                                                )));
                                                                  },
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
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ExpertDiseaseImageShow(
                                                                                  img1: snapshot.data!.docs[index]['imgUrls'][1],
                                                                                  img2: snapshot.data!.docs[index]['imgUrls'][0],
                                                                                  question: snapshot.data!.docs[index]['question'],
                                                                                )));
                                                                  },
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
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                child: Container(
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                    width: 120,
                                                                    height: 40,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => ExpertDiseaseAnswers(
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
                                                                        "Solutions",
                                                                        style: pwText(18, Themes().primaryText),
                                                                      ),
                                                                    )),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                child: Container(
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                    width: 150,
                                                                    height: 40,
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => ExpertDiseaseSolutionWrite(
                                                                                    docId: snapshot.data!.docs[index]['docId'])));
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
                                                                        "Write Solution",
                                                                        style: pwText(16, primary()),
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
    );
  }
}

class ExpertDiseaseImageShow extends StatefulWidget {
  const ExpertDiseaseImageShow({super.key, required this.img1, required this.img2, required this.question});

  final String img1;
  final String img2;
  final String question;

  @override
  State<ExpertDiseaseImageShow> createState() => _ExpertDiseaseImageShowState();
}

class _ExpertDiseaseImageShowState extends State<ExpertDiseaseImageShow> {
  final ExpertDiseaseImageShowController controller = Get.put(ExpertDiseaseImageShowController());

  @override
  void initState() {
    controller.changeImgUrl(widget.img1);
    controller.changeImgCount("1");
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Images",
          style: pwText(22, pText()),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: sBackground(),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: primary(),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Text(
                  widget.question,
                  maxLines: 3,
                  style: pwText(16, pText()),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.65,
              ),
              decoration: BoxDecoration(
                color: pBackground(),
              ),
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Obx(() => Image.network(
                        controller.imgUrl.value,
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        fit: BoxFit.contain,
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    controller.imgUrl.value = widget.img1;
                    controller.imgCount.value = "1";
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: primary(),
                    size: 30,
                  ),
                ),
                Obx(() => Text(
                      'Image ${controller.imgCount.value}',
                      style: pwText(20, pText()),
                    )),
                InkWell(
                  onTap: () {
                    controller.imgUrl.value = widget.img2;
                    controller.imgCount.value = "2";
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: primary(),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpertDiseaseAnswers extends StatelessWidget {
  const ExpertDiseaseAnswers({super.key, required this.answerList, required this.question});

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
          "Solutions",
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
                                                  "Disease :",
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
                                                "Solution :",
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
                                                                  builder: (context) => ExpertDiseaseReadPage(
                                                                      expImg: answerList[index]['expertImageUrl'],
                                                                      solution: answerList[index]['solution'],
                                                                      disease: answerList[index]['disease'],
                                                                      link: (answerList[index]['externalLink'] != null)
                                                                          ? answerList[index]['externalLink']
                                                                          : "null",
                                                                      description: answerList[index]['description'],
                                                                      expertName: answerList[index]['expertName'])));
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
                                                          "Read",
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
                            Text("No Solutions Yet", style: pwText(18, pText())),
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

class ExpertDiseaseReadPage extends StatefulWidget {
  const ExpertDiseaseReadPage(
      {super.key,
      required this.expImg,
      required this.solution,
      required this.disease,
      required this.link,
      required this.description,
      required this.expertName});

  final String expImg;
  final String solution;
  final String description;
  final String disease;
  final String link;
  final String expertName;

  @override
  State<ExpertDiseaseReadPage> createState() => _ExpertDiseaseReadPageState();
}

class _ExpertDiseaseReadPageState extends State<ExpertDiseaseReadPage> {
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
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Read Solution",
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
                            child: Text(
                              widget.expertName,
                              style: pwText(18, pText()),
                            ),
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
                            child: Text(
                              'Disease : ${widget.disease}',
                              style: pwText(20, pText()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        'Description : ${widget.description}',
                        style: pwText(20, pText()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        'Solution : ${widget.solution}',
                        style: pwText(16, pText()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "External Link :",
                            style: pwText(18, pText()),
                          ),
                          InkWell(
                            onTap: () async {
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

class ExpertDiseaseSolutionWrite extends StatefulWidget {
  const ExpertDiseaseSolutionWrite({super.key, required this.docId});

  final String docId;

  @override
  State<ExpertDiseaseSolutionWrite> createState() => _ExpertDiseaseSolutionWriteState();
}

class _ExpertDiseaseSolutionWriteState extends State<ExpertDiseaseSolutionWrite> {
  TextEditingController diseaseTexter = TextEditingController();
  TextEditingController descriptionTexter = TextEditingController();
  TextEditingController solutionTexter = TextEditingController();
  TextEditingController linkTexter = TextEditingController();
  final ExpertDiseaseSolutionWriteController controller = Get.put(ExpertDiseaseSolutionWriteController());

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
          "Write Solution",
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
                        controller: diseaseTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Disease Name',
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
                  'Write Identified disease name',
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
                        controller: descriptionTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Description of Disease',
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
                  'Write Description of identified disease',
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
                        controller: solutionTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Solution of Disease',
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
                  'Write Solution of identified disease',
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
                        controller: linkTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Add External Link',
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
                  'Add external link to your blog',
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
                        title: "Alert",
                        confirm: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                              width: 100,
                              height: 40,
                              child: Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    if (descriptionTexter.text.length > 50 && solutionTexter.text.length > 200) {
                                      if (diseaseTexter.text.isNotEmpty || descriptionTexter.text.isNotEmpty) {
                                        if (solutionTexter.text.isNotEmpty) {
                                          if (linkTexter.text.isNotEmpty &&
                                              !(linkTexter.text.toString().contains("http://") || linkTexter.text.toString().contains("https://"))) {
                                            Fluttertoast.showToast(msg: "link is Invalid");
                                          } else {
                                            controller.apiResponce.value = true;
                                            if (await abuseWordFilter("${solutionTexter.text} ${diseaseTexter.text} ${descriptionTexter.text}")) {
                                              await expertDiseaseWriteSolution(solutionTexter.text.toString(), diseaseTexter.text.toString(),
                                                  descriptionTexter.text.toString(), widget.docId, linkTexter.text.toString(), controller);
                                              Fluttertoast.showToast(msg: "Solution Posted");
                                              solutionTexter.clear();
                                              descriptionTexter.clear();
                                              linkTexter.clear();
                                              diseaseTexter.clear();
                                            } else {
                                              controller.apiResponce.value = false;
                                            }
                                          }
                                        } else {
                                          Fluttertoast.showToast(msg: "Solution is Empty");
                                        }
                                      } else {
                                        Fluttertoast.showToast(msg: "Disease or Description is Empty");
                                      }
                                    } else {
                                      Fluttertoast.showToast(msg: "Description or Solution is short");
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
                                          padding: const EdgeInsets.all(7.0),
                                          child: CircularProgressIndicator(
                                            color: pText(),
                                          ),
                                        )))),
                        ),
                        titleStyle: pwText(20, pText()),
                        backgroundColor: pBackground(),
                        middleText: "Confirm Solution Details,\nbecause It is not updatable\nin future.",
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
