// AppointmentForExpert

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:khetexpert/layouts/navigation_/drawers.dart';
import 'package:khetexpert/service/firebase_service.dart';
import 'package:khetexpert/service/zego_cloud.dart';
import 'package:khetexpert/settings/settings.dart';
import 'package:lottie/lottie.dart';

import '../../../api/api.dart';
import '../../../service/navigation_service.dart';
import '../../../themes/themes.dart';

class AppointmentForExpert extends StatefulWidget {
  const AppointmentForExpert({super.key});

  @override
  State<AppointmentForExpert> createState() => _AppointmentForExpertState();
}

class _AppointmentForExpertState extends State<AppointmentForExpert> with TickerProviderStateMixin {
  late TabController tabController;
  String hour = "";
  String minutes = "";
  String ampm = "";
  final fstoresnapshotpersonal = requestedAppointmentForExpert();
  final fstoresnapshotpersonalAc = acceptedAppointmentForExpert();

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
                "scheduled",
                style: pwText(16, primary()),
              )),
              Tab(
                  child: Text(
                "Pending",
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: fstoresnapshotpersonalAc,
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
                                      Text("No Meetings yet !!", style: pwText(18, pText())),
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
                                          Padding(
                                            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: sBackground(),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(10, 15, 10, 15),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: 100,
                                                      height: 100,
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
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          snapshot.data!.docs[index]['farmerName'],
                                                          style: pwText(22, pText()),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                          child: Container(
                                                            width: MediaQuery.sizeOf(context).width * 0.5,
                                                            decoration: BoxDecoration(
                                                              color: sBackground(),
                                                            ),
                                                            child: Text(
                                                              snapshot.data!.docs[index]['message'],
                                                              style: pwText(15, pText()),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                          child: Container(
                                                            width: MediaQuery.sizeOf(context).width * 0.5,
                                                            decoration: BoxDecoration(
                                                              color: sBackground(),
                                                            ),
                                                            child: Text(
                                                              'Reason : ${snapshot.data!.docs[index]['reason']}',
                                                              style: pwText(15, pText()),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                                                child: Container(
                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                                    width: 130,
                                                                    height: 50,
                                                                    child: ElevatedButton(
                                                                      onPressed: () async {
                                                                        if (kIsWeb) {
                                                                          Fluttertoast.showToast(msg: "Appointment is not supported on web");
                                                                        } else {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ZegoCloudAppointmentRTCE(
                                                                                        callID: snapshot.data!.docs[index]['docId'],
                                                                                        userName: expert.expertName!,
                                                                                        userId: expert.expertMobileNumber!,
                                                                                      )));
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
                                                                      child: Text(
                                                                        "Join Meeting",
                                                                        style: pwText(16, pText()),
                                                                      ),
                                                                    )),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
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
                                                                                  await postponeAppointment(snapshot.data!.docs[index]['docId']);
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
                                                                                  "Postpone",
                                                                                  style: pwText(15, Themes().primaryText),
                                                                                ))),
                                                                      ),
                                                                      titleStyle: pwText(20, pText()),
                                                                      backgroundColor: pBackground(),
                                                                      middleText: "Are you want to\npostpone this Meeting?",
                                                                      middleTextStyle: pwText(16, pText()));
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                                                                  child: Icon(
                                                                    Icons.lock_clock,
                                                                    color: primary(),
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
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
                                                                                  await rejectAppointment(snapshot.data!.docs[index]['docId']);
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
                                                                                  "Reject",
                                                                                  style: pwText(15, Themes().primaryText),
                                                                                ))),
                                                                      ),
                                                                      titleStyle: pwText(20, pText()),
                                                                      backgroundColor: pBackground(),
                                                                      middleText: "Are you want to\npostpone this Meeting?",
                                                                      middleTextStyle: pwText(16, pText()));
                                                                },
                                                                child: const Padding(
                                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                                                                  child: Icon(
                                                                    Icons.cancel,
                                                                    color: Colors.red,
                                                                    size: 35,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ));
                            }
                          }),
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
                                    Text("No Meetings yet !!", style: pwText(18, pText())),
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
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: sBackground(),
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        height: 100,
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
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                        child: Text(
                                                          snapshot.data!.docs[index]['farmerName'],
                                                          style: pwText(22, pText()),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                        child: Text(
                                                          'Appointment : ${snapshot.data!.docs[index]['reason']}',
                                                          style: pwText(15, pText()),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'Set Meeting Time for Today',
                                                      style: pwText(16, pText()),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                decoration: BoxDecoration(
                                                                  color: sBackground(),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                                  child: TextFormField(
                                                                    autofocus: true,
                                                                    onChanged: (value) {
                                                                      hour = value;
                                                                    },
                                                                    obscureText: false,
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: sText(),
                                                                          width: 2,
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    style: pwText(18, pText()),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                child: Text(
                                                                  'Hour',
                                                                  style: pwText(15, pText()),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                decoration: BoxDecoration(
                                                                  color: sBackground(),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                                  child: TextFormField(
                                                                    autofocus: true,
                                                                    obscureText: false,
                                                                    onChanged: (value) {
                                                                      minutes = value;
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: sText(),
                                                                          width: 2,
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    style: pwText(18, pText()),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                child: Text(
                                                                  'Minutes',
                                                                  style: pwText(15, pText()),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.sizeOf(context).width * 0.3,
                                                                decoration: BoxDecoration(
                                                                  color: sBackground(),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                                  child: TextFormField(
                                                                    autofocus: true,
                                                                    obscureText: false,
                                                                    onChanged: (value) {
                                                                      ampm = value;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: sText(),
                                                                          width: 2,
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    style: pwText(18, pText()),
                                                                    textAlign: TextAlign.center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                child: Text(
                                                                  'AM/PM',
                                                                  style: pwText(15, pText()),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                      child: Container(
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                                        height: 50,
                                                        child: ElevatedButton(
                                                            onPressed: () async {
                                                              if (hour == "" || minutes == "" || ampm == "") {
                                                                Fluttertoast.showToast(msg: "field is Empty");
                                                              } else {
                                                                if (int.parse(hour) > 12 || int.parse(hour) < 1) {
                                                                  Fluttertoast.showToast(msg: "hour is Invalid");
                                                                } else if (int.parse(minutes) > 59 || int.parse(minutes) < 0) {
                                                                  Fluttertoast.showToast(msg: "minute is Invalid");
                                                                } else {
                                                                  if (ampm.toUpperCase() == "AM" || ampm.toUpperCase() == "PM") {
                                                                    await acceptAppointment(
                                                                        snapshot.data!.docs[index]['docId'], hour, minutes, ampm.toUpperCase());
                                                                  } else {
                                                                    Fluttertoast.showToast(msg: "Invalid AM/PM");
                                                                  }
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
                                                            child: Text(
                                                              "Arrange Meeting",
                                                              style: pwText(15, Themes().primaryText),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                      child: IconButton(
                                                        onPressed: () {
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
                                                                          await rejectAppointment(snapshot.data!.docs[index]['docId']);
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
                                                                          "Reject",
                                                                          style: pwText(15, Themes().primaryText),
                                                                        ))),
                                                              ),
                                                              titleStyle: pwText(20, pText()),
                                                              backgroundColor: pBackground(),
                                                              middleText: "Are you want to\nreject this Meeting?",
                                                              middleTextStyle: pwText(16, pText()));
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
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
