// ChatBotController

import 'package:get/get.dart';

class ChatBotController extends GetxController {
  RxBool gptResponce = false.obs;
  RxString lang = "en".obs;
  RxBool langSwitch = false.obs;
}
