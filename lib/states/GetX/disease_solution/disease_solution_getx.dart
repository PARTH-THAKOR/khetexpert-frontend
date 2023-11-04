// DiseaseSolutionController

import 'package:get/get.dart';

class DiseaseAIForFarmersController extends GetxController {
  RxBool apiResponce = false.obs;
  RxString apiResponceString = "".obs;

  changeApiResponce(Future<String> value) async {
    apiResponceString.value = await value;
  }
}

class DiseaseReadForFarmersController extends GetxController {
  RxBool micSwitch = false.obs;
  RxBool langSwitch = false.obs;
  RxString lang = "en".obs;
  RxString description = "".obs;
  RxString solution = "".obs;
  RxString expertName = "".obs;
  RxString disease = "".obs;

  changeDisease(Future<String> value) async {
    disease.value = await value;
  }

  changeDescription(Future<String> value) async {
    description.value = await value;
  }

  changeSolution(Future<String> value) async {
    solution.value = await value;
  }

  changeExpertName(Future<String> value) async {
    expertName.value = await value;
  }
}

class DiseaseWriteController extends GetxController {
  RxBool apiResponce = false.obs;
}
