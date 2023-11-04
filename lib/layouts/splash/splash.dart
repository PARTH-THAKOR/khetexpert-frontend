// Splash Screen

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetexpert/service/initialization.dart';
import 'package:khetexpert/themes/themes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    ApplicationConfigureAdapter.initializeApplicationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: Scaffold(
        backgroundColor: primary(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Welcome !!'.tr,
                  style: pwText(30, pText()),
                ),
                Text(
                  'KhetExpert Application'.tr,
                  style: pwText(25, pText()),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'lib/assets/tree.webp',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.4,
                  ),
                )),
            Text(
              'KhetExpert.inc'.tr,
              style: pwText(20, pText()),
            ),
          ],
        ),
      ),
    );
  }
}
