// BlogForExpert

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api/api.dart';
import '../../../service/navigation_service.dart';
import '../../../states/GetX/blog/blog_expert_getx.dart';
import '../../../themes/themes.dart';

class BlogForExpert extends StatefulWidget {
  const BlogForExpert({super.key});

  @override
  State<BlogForExpert> createState() => _BlogForExpertState();
}

class _BlogForExpertState extends State<BlogForExpert> with TickerProviderStateMixin {
  late TabController tabController;
  final fstoresnapshot = blogStream();
  final fstoresnapshotpersonal = expertBlogStream();

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        drawer: const DrawerNavigationForExpert(),
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
                "Expert's Blog",
                style: pwText(16, primary()),
              )),
              Tab(
                  child: Text(
                "My Blogs",
                style: pwText(16, primary()),
              )),
            ],
          ),
        ),
        body: TabBarView(controller: tabController, children: [
          Scaffold(
              backgroundColor: pBackground(),
              body: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 10),
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
                                Text("No Blogs yet !!", style: pwText(18, pText())),
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
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BlogReadPageForExpert(
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
                                    Text("No Blogs yet !!", style: pwText(18, pText())),
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
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => BlogReadPageForExpert(
                                                          expImg: snapshot.data!.docs[index]['expertImageUrl'],
                                                          content: snapshot.data!.docs[index]['content'],
                                                          imgUrl: snapshot.data!.docs[index]['imageUrl'],
                                                          link: (snapshot.data!.docs[index]['externalLink'] != null)
                                                              ? snapshot.data!.docs[index]['externalLink']
                                                              : "null",
                                                          title: snapshot.data!.docs[index]['title'],
                                                          date: snapshot.data!.docs[index]['date'],
                                                          expertName: snapshot.data!.docs[index]['expertName'],
                                                        )));
                                          },
                                          onLongPress: () {
                                            Get.defaultDialog(
                                                title: "Alert",
                                                confirm: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                  child: Container(
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            blogDeleteForExpert(snapshot, index);
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
                                                            "Delete",
                                                            style: pwText(15, Themes().primaryText),
                                                          ))),
                                                ),
                                                titleStyle: pwText(20, pText()),
                                                backgroundColor: pBackground(),
                                                middleText: "Are you want to\ndelete this blog?",
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
                                                                    decoration:
                                                                        BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(100)),
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
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 5, 5),
                                                                  child: Container(
                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                      width: 100,
                                                                      height: 40,
                                                                      child: ElevatedButton(
                                                                        onPressed: () async {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => BlogUpdateForExpert(
                                                                                        content: snapshot.data!.docs[index]['content'],
                                                                                        title: snapshot.data!.docs[index]['title'],
                                                                                        link: (snapshot.data!.docs[index]['externalLink'] != null)
                                                                                            ? snapshot.data!.docs[index]['externalLink']
                                                                                            : "null",
                                                                                        imageUrl: snapshot.data!.docs[index]['imageUrl'],
                                                                                        docId: snapshot.data!.docs[index]['blogId'],
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
                                                                            backgroundColor: MaterialStatePropertyAll(sBackground())),
                                                                        child: Text(
                                                                          "Edit",
                                                                          style: pwText(18, primary()),
                                                                        ),
                                                                      )),
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
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                        child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (kIsWeb) {
                                  Fluttertoast.showToast(msg: "Blog writing is not available on web.");
                                } else {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BlogWriteForExperts()));
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
                                "write Blog",
                                style: pwText(18, primary()),
                              ),
                            )),
                      ),
                    ],
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

class BlogReadPageForExpert extends StatefulWidget {
  const BlogReadPageForExpert(
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
  State<BlogReadPageForExpert> createState() => _BlogReadPageForExpertState();
}

class _BlogReadPageForExpertState extends State<BlogReadPageForExpert> {
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
          "Read Blog",
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
                    // Generated code for this Row Widget...
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        widget.title,
                        style: pwText(20, pText()),
                      ),
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: Text(
                        widget.content,
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

class BlogWriteForExperts extends StatefulWidget {
  const BlogWriteForExperts({super.key});

  @override
  State<BlogWriteForExperts> createState() => _BlogWriteForExpertsState();
}

class _BlogWriteForExpertsState extends State<BlogWriteForExperts> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController titleTexter = TextEditingController();
  TextEditingController contentTexter = TextEditingController();
  TextEditingController linkTexter = TextEditingController();
  final BlogForExpertController controller = Get.put(BlogForExpertController());

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
          "Write Blog",
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
                        controller: titleTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Title',
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
                  'Write title of your Blog',
                  style: swText(14, sText()),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (kIsWeb) {
                Fluttertoast.showToast(msg: "Blog Writing is Not supported on web");
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
                                    Fluttertoast.showToast(msg: "Blog Writing is Not supported on web");
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
                              'select image from Gallery',
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
                  'Set Image Properly, it can not update further',
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
                        controller: contentTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write Content',
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
                  'Write content of your blog',
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
                                    if (kIsWeb) {
                                      Fluttertoast.showToast(msg: "Blog Writing Not supported on web");
                                    } else {
                                      if (contentTexter.text.toString().length > 450 || titleTexter.text.toString().length > 130) {
                                        if (contentTexter.text.toString().isNotEmpty || titleTexter.text.toString().isNotEmpty) {
                                          if (linkTexter.text.isNotEmpty &&
                                              !(linkTexter.text.toString().contains("http://") || linkTexter.text.toString().contains("https://"))) {
                                            Fluttertoast.showToast(msg: "link is Invalid");
                                          } else {
                                            if (_image != null) {
                                              controller.apiResponce.value = true;
                                              if (await abuseWordFilter("${contentTexter.text} ${titleTexter.text}")) {
                                                String url = "";
                                                url = await imageUploadOnStorage(_image);
                                                if (url.toString().isNotEmpty) {
                                                  await writeBlog(contentTexter.text.toString(), titleTexter.text.toString(),
                                                      linkTexter.text.toString(), url, controller);
                                                  Navigator.pop(Get.overlayContext!, true);
                                                  Fluttertoast.showToast(msg: "Blog Posted");
                                                  contentTexter.clear();
                                                  linkTexter.clear();
                                                  titleTexter.clear();
                                                  _image = null;
                                                  setState(() {});
                                                } else {
                                                  Fluttertoast.showToast(msg: "Image upload error");
                                                }
                                              } else {
                                                controller.apiResponce.value = false;
                                              }
                                            } else {
                                              Fluttertoast.showToast(msg: "Image is Empty");
                                            }
                                          }
                                        } else {
                                          Fluttertoast.showToast(msg: "content or title is Empty");
                                        }
                                      } else {
                                        Fluttertoast.showToast(msg: "Short Blog is not valid");
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
                        middleText: "Confirm blog image,\nbecause It is not updatable\nin future.",
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

class BlogUpdateForExpert extends StatefulWidget {
  const BlogUpdateForExpert({super.key, required this.content, required this.title, required this.link, required this.docId, required this.imageUrl});

  final String content;
  final String title;
  final String link;
  final String docId;
  final String imageUrl;

  @override
  State<BlogUpdateForExpert> createState() => _BlogUpdateForExpertState();
}

class _BlogUpdateForExpertState extends State<BlogUpdateForExpert> {
  final BlogForExpertController controller = Get.put(BlogForExpertController());
  TextEditingController titleTexter = TextEditingController();
  TextEditingController contentTexter = TextEditingController();
  TextEditingController linkTexter = TextEditingController();

  @override
  void initState() {
    titleTexter.text = widget.title;
    contentTexter.text = widget.content;
    linkTexter.text = widget.link;
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
          "Update Blog",
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
                        controller: titleTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write new Title',
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
                  'Write title of your Blog',
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
                        controller: contentTexter,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Write new Content',
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
                  'Write content of your blog',
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
                          hintText: 'Add new External Link',
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
              child: Obx(() => ElevatedButton(
                  onPressed: () async {
                    if (contentTexter.text.toString().length > 450 || titleTexter.text.toString().length > 130) {
                      if (contentTexter.text.toString().isNotEmpty || titleTexter.text.toString().isNotEmpty) {
                        if (linkTexter.text.isNotEmpty &&
                            !(linkTexter.text.toString().contains("http://") || linkTexter.text.toString().contains("https://"))) {
                          Fluttertoast.showToast(msg: "link is Invalid");
                        } else {
                          controller.updateResponce.value = true;
                          if (await abuseWordFilter("${contentTexter.text} ${titleTexter.text}")) {
                            await updateBlog(contentTexter.text.toString(), titleTexter.text.toString(), linkTexter.text.toString(), widget.imageUrl,
                                widget.docId, controller);
                            Fluttertoast.showToast(msg: "Blog Updated");
                            contentTexter.clear();
                            linkTexter.clear();
                            titleTexter.clear();
                          } else {
                            controller.updateResponce.value = false;
                          }
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Content or Link is empty");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Short Blog is not Valid");
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
                  child: (!controller.updateResponce.value)
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
        ],
      ),
    );
  }
}
