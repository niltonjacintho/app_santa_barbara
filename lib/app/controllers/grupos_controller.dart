// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:app2021/app/model/grupos_model.dart';

class GruposController extends GetxController {
  //TODO: Implement GruposController

  final count = 0.obs;
  List<Grupos> _lista = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  getGroupLists() {}
  // .then((value) => {
  //       for (var item in value)
  //         {
  //           print('ENTREIIIIII '),
  //           _lista.add(item),
  //         }
  //     });

  Future<List<Grupos>> getGroupList(String tipo) async {
    if (_lista.length <= 0) {
      List<Grupos> lista = [];
      var snap;
      if (tipo != null) {
        snap = FirebaseFirestore.instance
            .collection('grupos')
            .orderBy("id")
            .where('tipos ', isEqualTo: tipo)
            .snapshots();
      } else {
        snap = FirebaseFirestore.instance
            .collection('grupos')
            .orderBy("id")
            .snapshots();
        // .then((artigos) async {
        //   return await Future.forEach(artigos.docs)
        // .then((onValue)
        // }
      }
// await
      try {
        lista = [];
        await snap.forEach((field) {
          field.docs.asMap().forEach((index, data) {
            try {
              Grupos g = new Grupos();
              g.id = data['id'];
              g.cor = data['cor'];
              g.titulo = data['titulo'];
              g.value = data['value'];
              lista.add(g);
              _lista.add(g);
              _lista.add(g);
            } catch (e) {
              print('error $e');
            }
          });
        });
        _lista = lista;
        _lista = lista;
      } catch (e) {
        print(e);
      }
      return lista;
    }
    return _lista;
  }

  Grupos getGroupById(String id) {
    Grupos g = new Grupos();
    g = _lista.where((element) => element.id == id).first;
    return g;
  }

  Grupos generateGroupObject(dynamic data) {
    Grupos g = new Grupos();
    g.id = data['id'];
    g.cor = data['cor'];
    g.titulo = data['titulo'];
    g.value = data['value'];
    return g;
  }
}
