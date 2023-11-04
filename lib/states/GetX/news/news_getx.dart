// NewsController

import 'package:get/get.dart';

class NewsController extends GetxController {
  RxBool langSwitch = false.obs;
  RxString lang = "en".obs;
  RxString title = "".obs;
  RxString content = "".obs;
  RxString link = "".obs;
  RxBool micSwitch = false.obs;
  RxString liveNews = "".obs;
  List news = [];
  bool newsApiFetch = true;

  changeLiveNews(Future<String> value) async {
    liveNews.value = await value;
  }

  changeTitle(Future<String> value) async {
    title.value = await value;
  }

  changeContent(Future<String> value) async {
    content.value = await value;
  }

  changeLink(Future<String> value) async {
    link.value = await value;
  }
}
