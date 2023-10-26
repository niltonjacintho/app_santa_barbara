import 'package:app2021/app/model/grupos_model.dart';
import 'package:app2021/app/model/oracao_model.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

 class OracoesController extends GetxController {

  List<Grupos> lista = [];

  Oracoes oracao;
  
  int value = 0;

  
  List listaOracoes = [];

  final box = GetStorage();
  
  Future getListaOracoesFromStore(String grupo) async {
    // var docs = FirebaseFirestore.instance.collection("oracoes").get();
    grupo = grupo == '' ? 'comuns' : grupo;

    // for (var item in docs['grupo']) {
    //   if (item['nome'].toLowerCase() == 'comuns'.toLowerCase()) {
    //     for (var o in item['oracoes']) {
    //       // print(o);
    //       listaOracoes.add(o);
    //     }
    //   }
    // }
    return listaOracoes;
  }

  
  Stream<QuerySnapshot> getOracoes(String grupo) {
    var query = FirebaseFirestore.instance.collection('oracoes');
    // if (filterArtigos != '') {
    //   query = query.where('titulo', isGreaterThanOrEqualTo: filterPastorais);
    // }
    return query.where('grupo', isEqualTo: 'comum').snapshots();
    // .where('ativo', isEqualTo: true)
    // .snapshots();
    // return snap;
  }

  updateOracoes() {
    var doc = FirebaseFirestore.instance.collection("oracoes").get();
    //loadKeys(x.length);
    doc.then((d) =>
        {print(d.docs[0].data()), box.write('oracao', d.docs[0].data())});
    return doc;
  }
}

