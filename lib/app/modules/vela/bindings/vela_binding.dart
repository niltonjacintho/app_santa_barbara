import 'package:get/get.dart';

import 'package:app2021/app/modules/vela/controllers/vela_controller.dart';

class VelaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VelaController>(
      () => VelaController(),
    );
  }
}
