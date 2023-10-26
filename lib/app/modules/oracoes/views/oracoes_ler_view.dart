// ignore_for_file: must_be_immutable

import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/oracoes/controllers/oracoes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OracoesLerView extends GetView {
//  BaseStore baseStore = Modular.get();
  UtilsController utilsController = Get.put(UtilsController());
  OracoesController controller = Get.put(OracoesController());
  @override
  Widget build(BuildContext context) {
    // double tamanhoFonte =
    //     double.parse(GetStorage().read('tamanhoFonte').toString()) ?? 10.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.oracao.titulo),
        actions: <Widget>[
          ElevatedButton(
       //     color: Colors.transparent,
       //     splashColor: Colors.black26,
            onPressed: () {
              utilsController.incTamanhoFonte();
            },
            child: Text('A+',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          ),
          ElevatedButton(
           // color: Colors.transparent,
           // splashColor: Colors.black26,
            onPressed: () {
              utilsController.decTamanhoFonte();
            },
            child: Text(
              'A-',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              strutStyle: StrutStyle(fontSize: 13),
            ),
          ),
        ],
      ),
      //),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Obx(
              () => Text(
                controller.oracao.texto,
                style: TextStyle(fontSize: utilsController.tamanhoFonte.value),
              ),
            ),
          ],
        ),
      ),
      //  ),
    );
  }
}
