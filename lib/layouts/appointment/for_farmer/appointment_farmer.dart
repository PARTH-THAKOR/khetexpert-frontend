// AppointmentsForFarmer

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
import '../../../service/navigation_service.dart';
import '../../../themes/themes.dart';

class AppointmentForFarmer extends StatefulWidget {
  const AppointmentForFarmer({super.key});

  @override
  State<AppointmentForFarmer> createState() => _AppointmentForFarmerState();
}

class _AppointmentForFarmerState extends State<AppointmentForFarmer> with TickerProviderStateMixin {
  late TabController tabController;
  final fstoresnapshotpersonal = requestedAppointmentForFarmer();
  final fstoresnapshotpersonalAc = acceptedAppointmentForFarmer();

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
                "Accepted".tr,
                style: pwText(16, primary()),
              )),
              Tab(
                  child: Text(
                "Requested".tr,
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
                                      Text("No Meetings yet !!".tr, style: pwText(18, pText())),
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
                                                          await profileImageShow(context, snapshot.data!.docs[index]['expertImageUrl'],
                                                              snapshot.data!.docs[index]['expertName']);
                                                        },
                                                        child: profileImageWidget(snapshot.data!.docs[index]['expertImageUrl']),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          snapshot.data!.docs[index]['expertName'],
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
                                                              '${'Time : Today '.tr} ${snapshot.data!.docs[index]['hour']} : ${snapshot.data!.docs[index]['minutes']} ${snapshot.data!.docs[index]['ampm']}',
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
                                                                          Fluttertoast.showToast(msg: "Appointments are not supported on web.".tr);
                                                                        } else {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ZegoCloudAppointmentRTCE(
                                                                                        callID: snapshot.data!.docs[index]['docId'],
                                                                                        userName: farmer.name!,
                                                                                        userId: farmer.phoneNumber!,
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
                                                                        "Join Meeting".tr,
                                                                        textAlign: TextAlign.center,
                                                                        style: pwText(16, pText()),
                                                                      ),
                                                                    )),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
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
                                                                                  appointmentDeleteForFarmer(snapshot, index);
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
                                                                                  "Cancel".tr,
                                                                                  style: pwText(15, Themes().primaryText),
                                                                                ))),
                                                                      ),
                                                                      titleStyle: pwText(20, pText()),
                                                                      backgroundColor: pBackground(),
                                                                      middleText: "Are you want to\ncancel this Meeting?".tr,
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
                                    Text("No Meetings yet !!".tr, style: pwText(18, pText())),
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
                                                          await profileImageShow(context, snapshot.data!.docs[index]['expertImageUrl'],
                                                              snapshot.data!.docs[index]['expertName']);
                                                        },
                                                        child: profileImageWidget(snapshot.data!.docs[index]['expertImageUrl'])),
                                                  ),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        snapshot.data!.docs[index]['expertName'],
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
                                                            '${'Reason :'.tr} ${snapshot.data!.docs[index]['reason']}',
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
                                                            '${'Email :'.tr} ${snapshot.data!.docs[index]['expertEmailId']}',
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
                                                            '${'Status :'.tr} ${snapshot.data!.docs[index]['message']}',
                                                            style: pwText(15, pText()),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
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
                                                                                appointmentDeleteForFarmer(snapshot, index);
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
                                                                                "Cancel".tr,
                                                                                style: pwText(15, Themes().primaryText),
                                                                              ))),
                                                                    ),
                                                                    titleStyle: pwText(20, pText()),
                                                                    backgroundColor: pBackground(),
                                                                    middleText: "Are you want to\ncancel this Meeting?".tr,
                                                                    middleTextStyle: pwText(16, pText()));
                                                              },
                                                              child: const Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
            ),
          ),
        ]),
      ),
    );
  }
}
