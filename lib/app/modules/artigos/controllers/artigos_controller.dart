import 'package:app2021/app/controllers/styles_controller.dart';
import 'package:app2021/app/model/artigo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtigosController extends GetxController {
  final count = 0.obs;
  var listaArtigos = new RxList<ArtigosModel>();
  var grupo = ''.obs;
  StylesController stylesController = Get.put(StylesController());
  var menuSelecionado = {};

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  ArtigosModel docAtivo = new ArtigosModel();

  ArtigosModel convertSnapShotToArtigos(QueryDocumentSnapshot doc) {
    ArtigosModel art = new ArtigosModel();
    art.ativo = doc.get("ativo");
    art.titulo = doc.get("titulo");
    art.texto = doc.get("conteudo");
    art.dataCriacao =
        doc.get("dtInclusao") != null ? doc.get("dtInclusao").toDate() : null;
    art.dataValidade = doc.get("dtLimiteExibicao") != null
        ? doc.get("dtLimiteExibicao").toDate()
        : null;
    art.image = doc.get("imagem");
    art.video = doc.get("video");
    art.categoria = doc.get("grupo");
    art.subtitulo = doc.get("subtitulo");
    art.visualizacoes = doc.get("visualizacoes");
    art.documentID = doc.get("id");
    return art;
  }

  List<DropdownMenuItem> getCategoryList() {
    List<DropdownMenuItem> result = [];
    result.add(new DropdownMenuItem(
        value: {"texto": 'avisos', "id": 0},
        child: Text(
          'Avisos',
          textAlign: TextAlign.center,
          // ignore: unrelated_type_equality_checks
          style: menuSelecionado == 0
              ? stylesController.estiloMenu
              : stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'eventos', "id": 1},
        child: Text(
          'Eventos',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'noticias', "id": 2},
        child: Text(
          'Notícias Católicas',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'parocos', "id": 3},
        child: Text(
          'Parocos',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'pessoas', "id": 4},
        child: Text(
          'Pessoas Importantes',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'paroquia', "id": 5},
        child: Text(
          'Nossa Paróquia',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'duvidas', "id": 6},
        child: Text(
          'Perguntas frequentes',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    result.add(new DropdownMenuItem(
        value: {"texto": 'horários', "id": 7},
        child: Text(
          'Horários paroquiais',
          textAlign: TextAlign.center,
          style: stylesController.estiloMenu,
        )));
    return result;
  }

  getArtigosList(String grupo) async {
    listaArtigos = new RxList<ArtigosModel>();
    print('grupo selecionado $grupo');
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('artigos')
        .where('grupo', isEqualTo: grupo)
        .where('ativo', isEqualTo: true)
        .get();

    snap.docs.forEach((doc) {
      listaArtigos.add(new ArtigosModel(
          documentID: doc.get('documentID'),
          ativo: doc.get('ativo'),
          categoria: doc.get('categoria'),
          titulo: doc.get('titulo'),
          subtitulo: doc.get('subtitulo'),
          texto: doc.get('texto'),
          dataCriacao: doc.get('dataCriacao'),
          autorAutor: doc.get('autorAutor'),
          evento: doc.get('evento'),
          image: doc.get('image'),
          video: doc.get('video'),
          audio: doc.get('audio'),
          dataValidade: doc.get('dataValidade'),
          visualizacoes: doc.get('visualizacoes'),
          comentarios: doc.get('comentarios')));
     // print(doc.get('titulo'));
    });
    return listaArtigos;

    // snap.docs.map((doc) => listaArtigos.add(new ArtigosModel(
    //     documentID: doc.data()['documentID'],
    //     ativo: doc.data()['ativo'],
    //     categoria: doc.data()['categoria'],
    //     titulo: doc.data()['titulo'],
    //     subtitulo: doc.data()['subtitulo'],
    //     texto: doc.data()['texto'],
    //     dataCriacao: doc.data()['dataCriacao'],
    //     autorAutor: doc.data()['autorAutor'],
    //     evento: doc.data()['evento'],
    //     image: doc.data()['image'],
    //     video: doc.data()['video'],
    //     audio: doc.data()['audio'],
    //     dataValidade: doc.data()['dataValidade'],
    //     visualizacoes: doc.data()['visualizacoes'],
    //     comentarios: doc.data()['comentarios'])));
    // print(listaArtigos);
  }
}
