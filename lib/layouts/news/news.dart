// News

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';
import '../../language/translator.dart';
import '../../states/GetX/news/news_getx.dart';
import '../../themes/themes.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final NewsController controller = Get.put(NewsController());

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
            "Live News".tr,
            style: pwText(22, pText()),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getNews(controller),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primary(),
                  ),
                );
              } else if (controller.newsApiFetch == false) {
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
                        Text("Error Occurred !!, Try again Later".tr, style: pwText(18, pText())),
                      ],
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.news.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (controller.news[index]['image_url'] != null) {
                            if (controller.news[index]['content'] == null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsRead(
                                            content: "NULL",
                                            imgUrl: controller.news[index]['image_url'],
                                            link: controller.news[index]['link'],
                                            title: controller.news[index]['title'],
                                            date: controller.news[index]['pubDate'],
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsRead(
                                            content: controller.news[index]['content'],
                                            imgUrl: controller.news[index]['image_url'],
                                            link: controller.news[index]['link'],
                                            title: controller.news[index]['title'],
                                            date: controller.news[index]['pubDate'],
                                          )));
                            }
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsRead(
                                          content: controller.news[index]['content'],
                                          imgUrl: "",
                                          link: controller.news[index]['link'],
                                          title: controller.news[index]['title'],
                                          date: controller.news[index]['pubDate'],
                                        )));
                          }
                        },
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
                              child: SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    (controller.news[index]['image_url'] != null)
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              controller.news[index]['image_url'].toString(),
                                              width: double.infinity,
                                              height: MediaQuery.sizeOf(context).height * 0.25,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://images.unsplash.com/photo-1566378246598-5b11a0d486cc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxuZXdzcGFwZXJ8ZW58MHx8fHwxNjk0OTYzNTI5fDA&ixlib=rb-4.0.3&q=80&w=1080',
                                              width: double.infinity,
                                              height: MediaQuery.sizeOf(context).height * 0.25,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
                                      child: Text(
                                        controller.news[index]['title'].toString(),
                                        style: pwText(22, pText()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}

class NewsRead extends StatefulWidget {
  const NewsRead({super.key, required this.content, required this.imgUrl, required this.link, required this.title, required this.date});

  final String content;
  final String title;
  final String date;
  final String imgUrl;
  final String link;

  @override
  State<NewsRead> createState() => _NewsReadState();
}

class _NewsReadState extends State<NewsRead> {
  final NewsController controller = Get.put(NewsController());
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
          "Read News".tr,
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
                      child: (widget.imgUrl != "")
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                widget.imgUrl,
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.25,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
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
                                    } else {
                                      controller.langSwitch.value = true;
                                      controller.lang.value = appLangCode;
                                      await controller.changeTitle(changeValueEnToOtherApp(widget.title, appLangCode));
                                      await controller.changeContent(changeValueEnToOtherApp(widget.content, appLangCode));
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
