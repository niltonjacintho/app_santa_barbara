// import 'package:flutter/cupertino.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StylesController extends GetxController {
  //TODO: Implement StylesController
  UtilsController utilsController = Get.put(UtilsController());
  final count = 0.obs;
  final box = GetStorage();

  //var _tamanhoFonte = 20.obs;
  // RxInt get tamanhoFonte => this._tamanhoFonte;

  // set tamanhoFonte(RxInt v) => {
  //       v = v < 5 ? 5 : v,
  //       v = v > 70 ? 70 : v,
  //       this._tamanhoFonte = v,
  //       box.write('tamanhoFonte', v.value),
  //     };

  @override
  // ignore: must_call_super
  void onInit() {
    // if (box.read('tamanhoFonte') != null) {
    //   tamanhoFonte.value = box.read('tamanhoFonte').value;
    // }
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  TextStyle formLabel = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);

  TextStyle estiloMenu = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue);

  TextStyle estiloMenuSelecionado = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);

  TextStyle titulo = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 40, color: Colors.blue);

  TextStyle subTitulo = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue);

  TextStyle corpo = new TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue);

  alterarTamanhoFonteCorpo() {
    corpo = new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: utilsController.tamanhoFonte.value,
        color: Colors.blue);
  }
}
