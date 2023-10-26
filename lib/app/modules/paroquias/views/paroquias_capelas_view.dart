import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/paroquias/controllers/paroquias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParoquiasCapelasView extends GetView {
  final UtilsController util = Get.put(UtilsController());
  final ParoquiasController paroquiasController =
      Get.put(ParoquiasController());
  //DocumentsController documentsController = new DocumentsController();

  @override
  Widget build(BuildContext context) {
    List doc = paroquiasController.paroquiaAtiva.capelas!;
    return Scaffold(
      appBar: AppBar(
        title: Text(paroquiasController.paroquiaAtiva.nome!),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          itemCount: doc.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      readOnly: true,
                      initialValue: doc[index].nome,
                      decoration: InputDecoration(labelText: 'Capela'),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: doc[index].endereco + ' ',
                      decoration: InputDecoration(labelText: 'Endereço'),
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: doc[index].telefone,
                      decoration: InputDecoration(labelText: 'Telefones'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        //  ],
        //  ),
      ),
    );
  }

// class ParoquiasCapelasView extends GetView {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ParoquiasCapelasView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'ParoquiasCapelasView is working',
//           style: TextStyle(fontSize:20),
//         ),
//       ),
//     );
//   }
// }
}
