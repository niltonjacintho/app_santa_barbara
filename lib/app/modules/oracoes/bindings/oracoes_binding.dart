import 'package:get/get.dart';

import 'package:app2021/app/modules/oracoes/controllers/oracoes_controller.dart';

class OracoesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OracoesController>(
      () => OracoesController(),
    );
  }
}
