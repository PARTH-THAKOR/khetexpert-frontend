// ChatBot

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetexpert/api/api.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:lottie/lottie.dart';
import '../../states/GetX/chatbot/chatbot_getx.dart';
import '../../themes/themes.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ChatBotController controller = Get.put(ChatBotController());
  TextEditingController chatTexter = TextEditingController();
  final fstoresnapshot = chatBotStream();

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        drawer: const DrawerNavigationForFarmers(),
        backgroundColor: pBackground(),
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
            "A.I. AskGround".tr,
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
                              Text("No Searches !! Start Searching.".tr, style: pwText(18, pText())),
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
                                  (snapshot.data!.docs[index]['set'].toString() == "que")
                                      ? Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                  maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFf9a095),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                  child:
                                                      Text(snapshot.data!.docs[index]['title'].toString(), style: pwText(16, Themes().primaryText)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  (snapshot.data!.docs[index]['set'].toString() == "ans")
                                      ? Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxWidth: MediaQuery.sizeOf(context).width * 0.85,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: alternate(),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                    child: Text(snapshot.data!.docs[index]['title'].toString(), style: pwText(16, pText())),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 10, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image.asset(
                                                      'lib/assets/tree.webp',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ));
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
                              hintText: "Enter agricultural Prompt".tr,
                              hintStyle: pwText(18, sText()),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            style: pwText(18, pText()),
                            cursorColor: sText(),
                          ),
                        ),
                      ),
                      Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(color: primary(), borderRadius: BorderRadius.circular(10)),
                        child: Obx(() {
                          return (controller.gptResponce.value == false)
                              ? IconButton(
                                  onPressed: () async {
                                    if (await abuseWordFilter(chatTexter.text.toString())) {
                                      await chatbotFirestoreMessageUpload(chatTexter, controller);
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
