// BlogForFarmer

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api/api.dart';
import '../../../language/translator.dart';
import '../../../service/navigation_service.dart';
import '../../../states/GetX/blog/blog_farmer_getx.dart';
import '../../../themes/themes.dart';

class BlogForFarmer extends StatefulWidget {
  const BlogForFarmer({super.key});

  @override
  State<BlogForFarmer> createState() => _BlogForFarmerState();
}

class _BlogForFarmerState extends State<BlogForFarmer> {
  final BlogForFarmerController controller = Get.put(BlogForFarmerController());
  final fstoresnapshot = blogStream();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
          backgroundColor: pBackground(),
          drawer: const DrawerNavigationForFarmers(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: pBackground(),
            automaticallyImplyLeading: false,
            title: Text(
              "Expert's Blogs".tr,
              style: pwText(22, pText()),
            ),
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
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
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
                            Text("No Blogs yet !!".tr, style: pwText(18, pText())),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlogReadPageForFarmer(
                                                expImg: snapshot.data!.docs[index]['expertImageUrl'],
                                                content: snapshot.data!.docs[index]['content'],
                                                imgUrl: snapshot.data!.docs[index]['imageUrl'],
                                                link: (snapshot.data!.docs[index]['externalLink'] != null)
                                                    ? snapshot.data!.docs[index]['externalLink']
                                                    : "null",
                                                title: snapshot.data!.docs[index]['title'],
                                                date: snapshot.data!.docs[index]['date'],
                                                expertName: snapshot.data!.docs[index]['expertName'])));
                                  },
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
                                                    await profileImageShow(context, snapshot.data!.docs[index]['expertImageUrl'],
                                                        snapshot.data!.docs[index]['expertName']);
                                                  },
                                                  child: profileImageWidget(snapshot.data!.docs[index]['expertImageUrl'])),
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
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.network(
                                                        snapshot.data!.docs[index]['imageUrl'],
                                                        width: double.infinity,
                                                        height: MediaQuery.sizeOf(context).height * 0.25,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                                      child: Text(
                                                        snapshot.data!.docs[index]['title'],
                                                        style: pwText(16, pText()),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(100)),
                                                            child: IconButton(
                                                              onPressed: () async {
                                                                SharedPreferences internalData = await SharedPreferences.getInstance();
                                                                if (internalData.containsKey("${snapshot.data!.docs[index]['blogId']}blog")) {
                                                                  await unRateBlog(snapshot.data!.docs[index]['blogId'], internalData);
                                                                } else {
                                                                  await rateBlog(snapshot.data!.docs[index]['blogId'], internalData);
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons.thumb_up,
                                                                color: sBackground(),
                                                                size: 24,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          snapshot.data!.docs[index]['ratting'].toString(),
                                                          style: pwText(16, pText()),
                                                        ),
                                                      ],
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
          )),
    );
  }
}

class BlogReadPageForFarmer extends StatefulWidget {
  const BlogReadPageForFarmer(
      {super.key,
      required this.expImg,
      required this.content,
      required this.imgUrl,
      required this.link,
      required this.title,
      required this.date,
      required this.expertName});

  final String expImg;
  final String content;
  final String title;
  final String date;
  final String imgUrl;
  final String link;
  final String expertName;

  @override
  State<BlogReadPageForFarmer> createState() => _BlogReadPageForFarmerState();
}

class _BlogReadPageForFarmerState extends State<BlogReadPageForFarmer> {
  final BlogForFarmerController controller = Get.put(BlogForFarmerController());
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
    controller.title.value = widget.title;
    controller.content.value = widget.content;
    controller.expertName.value = widget.expertName;
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
          "Read Blog".tr,
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Obx(() => Text(
                            controller.title.value,
                            style: pwText(20, pText()),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        widget.date,
                        style: pwText(15, pText()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.imgUrl,
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            width: 100,
                            height: 40,
                            child: Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    if (controller.langSwitch.value) {
                                      controller.langSwitch.value = false;
                                      controller.lang.value = "en";
                                      controller.title.value = widget.title;
                                      controller.content.value = widget.content;
                                      controller.expertName.value = widget.expertName;
                                    } else {
                                      controller.langSwitch.value = true;
                                      controller.lang.value = appLangCode;
                                      await controller.changeTitle(changeValueEnToOtherApp(widget.title, appLangCode));
                                      await controller.changeContent(changeValueEnToOtherApp(widget.content, appLangCode));
                                      await controller.changeExpertName(changeValueEnToOtherApp(widget.expertName, appLangCode));
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
                                      await speak(controller.content.value, controller.lang.value);
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
                            controller.content.value,
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
