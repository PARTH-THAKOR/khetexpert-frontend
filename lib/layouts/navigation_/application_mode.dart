// Application Mode

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetexpert/service/navigation_service.dart';
import 'package:khetexpert/themes/themes.dart';

class ApplicationMode extends StatefulWidget {
  const ApplicationMode({super.key});

  @override
  State<ApplicationMode> createState() => _ApplicationModeState();
}

class _ApplicationModeState extends State<ApplicationMode> {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pBackground(),
          toolbarHeight: 0,
        ),
        backgroundColor: pBackground(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Icon(
                      Icons.settings,
                      color: sText(),
                      size: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                    child: Text(
                      'Choose Application Mode'.tr,
                      style: pwText(24, pText()),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: pBackground(),
              ),
              child: // Generated code for this Column Widget...
                  Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 5, 10),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await applicationModeNavigation("farmer");
                              },
                              child: Container(
                                width: 2,
                                decoration: BoxDecoration(
                                  color: sBackground(),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primary(),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'lib/assets/843349.png',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                      child: Text(
                                        'Farmer'.tr,
                                        style: pwText(22, pText()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 10, 10),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await applicationModeNavigation("expert");
                              },
                              child: Container(
                                width: 2,
                                decoration: BoxDecoration(
                                  color: sBackground(),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primary(),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'lib/assets/4301882.png',
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                      child: Text(
                                        'Expert'.tr,
                                        style: pwText(22, pText()),
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
              ),
            ),
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
              decoration: BoxDecoration(
                color: pBackground(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: sText(),
                      size: 30,
                    ),
                    title: Text(
                      'Welcome in KhetExpert Application'.tr,
                      style: pwText(12, pText()),
                    ),
                    subtitle: Text(
                      'KhetExpert.inc'.tr,
                      style: swText(10, sText()),
                    ),
                    tileColor: pBackground(),
                    dense: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
