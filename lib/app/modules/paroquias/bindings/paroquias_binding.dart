import 'package:get/get.dart';

import 'package:app2021/app/modules/paroquias/controllers/paroquias_controller.dart';

class ParoquiasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParoquiasController>(
      () => ParoquiasController(),
    );
  }
}
