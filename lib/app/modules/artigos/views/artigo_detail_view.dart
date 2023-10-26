import 'package:app2021/app/controllers/styles_controller.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/artigos/controllers/artigos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtigoDetailView extends GetView {
  final ArtigosController controller = Get.put(ArtigosController());
  final StylesController stylesController = Get.put(StylesController());
  final UtilsController utilsController = Get.put(UtilsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('ArtigoDetailView'),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () => {utilsController.incTamanhoFonte()},
              child: Image.asset(
                'assets/images/font-increase.png',
                width: 30,
                height: 30,
                color: Colors.white,
              )),
          ElevatedButton(
              onPressed: () => {utilsController.decTamanhoFonte()},
              child: Image.asset(
                'assets/images/font-decrease.png',
                width: 30,
                height: 30,
                color: Colors.yellow,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            controller.docAtivo.image != ""
                ? Image.network(
                    controller.docAtivo.image!,
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  )
                : Text(''),
            Text(
              controller.docAtivo.titulo!,
              style: stylesController.titulo,
            ),
            Text(
              controller.docAtivo.subtitulo!,
              style: stylesController.subTitulo,
            ),
            Divider(
              height: 20,
              color: Colors.blueGrey,
              // padding: EdgeInsets.all(10),
            ),
            Obx(
              () => Text(
                controller.docAtivo.texto!,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: utilsController.tamanhoFonte.value,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
