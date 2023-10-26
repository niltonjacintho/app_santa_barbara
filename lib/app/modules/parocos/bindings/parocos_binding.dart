import 'package:get/get.dart';

import 'package:app2021/app/modules/parocos/controllers/parocos_controller.dart';

class ParocosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParocosController>(
      () => ParocosController(),
    );
  }
}
