// DiseaseImageController

import 'package:get/get.dart';

class ExpertDiseaseImageShowController extends GetxController {
  RxString imgUrl = "".obs;
  RxString imgCount = "".obs;

  changeImgUrl(String img) {
    imgUrl.value = img;
  }

  changeImgCount(String count) {
    imgCount.value = count;
  }
}

class ExpertDiseaseSolutionWriteController extends GetxController {
  RxBool apiResponce = false.obs;
}
