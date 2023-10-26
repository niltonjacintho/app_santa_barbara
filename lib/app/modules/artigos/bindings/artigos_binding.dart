import 'package:get/get.dart';

import 'package:app2021/app/modules/artigos/controllers/artigos_controller.dart';

class ArtigosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtigosController>(
      () => ArtigosController(),
    );
  }
}
