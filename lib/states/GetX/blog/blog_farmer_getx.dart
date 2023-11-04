// BlogFarmerControllers

import 'package:get/get.dart';

class BlogForFarmerController extends GetxController {
  RxBool micSwitch = false.obs;
  RxBool langSwitch = false.obs;
  RxString lang = "en".obs;
  RxString title = "".obs;
  RxString content = "".obs;
  RxString link = "".obs;
  RxString expertName = "".obs;

  changeTitle(Future<String> value) async {
    title.value = await value;
  }

  changeContent(Future<String> value) async {
    content.value = await value;
  }

  changeLink(Future<String> value) async {
    link.value = await value;
  }

  changeExpertName(Future<String> value) async {
    expertName.value = await value;
  }
}
