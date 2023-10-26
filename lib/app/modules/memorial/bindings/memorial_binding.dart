import 'package:get/get.dart';

import 'package:app2021/app/modules/memorial/controllers/memorial_controller.dart';

class MemorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemorialController>(
      () => MemorialController(),
    );
  }
}
