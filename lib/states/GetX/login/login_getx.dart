// Farmer Login Controller

import 'package:get/get.dart';

class FarmerLoginController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingOTP = false.obs;
}

class ExpertLoginController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadingForgot = false.obs;
  RxBool loadingRegister = false.obs;
  RxBool loadingSendOTP = false.obs;
}
