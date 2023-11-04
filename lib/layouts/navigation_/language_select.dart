// LanguageSelection

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetexpert/service/navigation_service.dart';
import 'package:khetexpert/themes/themes.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
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
                      'Choose Language'.tr,
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () async {
                                await saveLanguageNavigation("en");
                              },
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: primary(),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8))),
                                  elevation: const MaterialStatePropertyAll(2),
                                  backgroundColor: MaterialStatePropertyAll(primary())),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "English",
                                    style: pwText(24, Themes().primaryText),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () async {
                                await saveLanguageNavigation("hi");
                              },
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: primary(),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8))),
                                  elevation: const MaterialStatePropertyAll(2),
                                  backgroundColor: MaterialStatePropertyAll(primary())),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'हिंदी',
                                    style: pwText(24, Themes().primaryText),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () async {
                                await saveLanguageNavigation("gu");
                              },
                              style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: primary(),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8))),
                                  elevation: const MaterialStatePropertyAll(2),
                                  backgroundColor: MaterialStatePropertyAll(primary())),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "ગુજરાતી",
                                    style: pwText(24, Themes().primaryText),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
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
