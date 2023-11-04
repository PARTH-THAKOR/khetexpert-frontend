// ZegoCloudAppointmentRTCE

import 'package:flutter/material.dart';
import 'package:khetexpert/settings/constants.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoCloudAppointmentRTCE extends StatelessWidget {
  const ZegoCloudAppointmentRTCE({Key? key, required this.userName, required this.callID, required this.userId}) : super(key: key);
  final String callID;
  final String userName;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      userID: userId,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
