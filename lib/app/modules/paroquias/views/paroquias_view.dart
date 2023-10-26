// ignore_for_file: must_be_immutable

import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/artigos/controllers/artigos_controller.dart';
import 'package:app2021/app/modules/paroquias/controllers/paroquias_controller.dart';
import 'package:app2021/app/modules/paroquias/views/paroquias_capelas_view.dart';
import 'package:app2021/app/modules/paroquias/views/paroquias_mapa_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;


class ParoquiasView extends GetView<ParoquiasController> {
  //use 'controller' variable to access controller
  UtilsController util = Get.put(UtilsController());
  //controller controller = Modular.get();
  ArtigosController artigosController = Get.put(ArtigosController());

  String filtro = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: util.corFundoAvisos,
      body: Container(
        //child: Text('111'),
        color: util.corFundoAvisos,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Pastorais Movimentos e Serviços'),
              backgroundColor: util.corFundoBarra,
              expandedHeight: 200,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: <Widget>[
                    SizedBox(height: 90.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 16.0),
                      child: Container(
                        height: 36.0,
                        width: double.infinity,
                        child: CupertinoTextField(
                          keyboardType: TextInputType.text,
                          placeholder: 'Digite algo para pesquisar',
                          placeholderStyle: TextStyle(
                            color: Color(0xffC4C6CC),
                            fontSize: 14.0,
                            fontFamily: 'Brutal',
                          ),
                          onChanged: (value) {
                            controller.setFiltro(value);
                            // setState(() {
                            filtro = value;
                            //   });
                          },
                          prefix: InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                              child: Icon(
                                Icons.search,
                                color: Color(0xffC4C6CC),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color(0xffF0F1F5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //     ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('paroquias')
                  .orderBy('nome')
                  .snapshots(),
              builder: (context, AsyncSnapshot snap) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Obx(
                        () => util.existeTexto(
                                snap.data!.docs[index]['nome'].toString(),
                                controller.filtro.value)
                            ? Container(
                                height: 280,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10, left: 10, right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Alert(
                                        context: context,
                                        type: AlertType.info,
                                        title: 'Detalhes',
                                        desc: "Exibe detalhes da paroquia",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Fechar",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            width: 120,
                                          )
                                        ],
                                      ).show();
                                    },
                                    child: Card(
                                      elevation: 10,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: <Widget>[
                                            util.textoEsquerda(
                                                snap.data.docs[index]['nome'],
                                                stilo: util.stHeader),
                                            util.textoEsquerda(snap
                                                .data.docs[index]['paroco']),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            util.textoEsquerda(snap
                                                .data.docs[index]['forania']),
                                            util.textoEsquerda(snap
                                                .data.docs[index]['telefones']),
                                            util.textoEsquerda(snap
                                                .data.docs[index]['vigario']),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    controller.setParoquiaAtiva(
                                                        snap.data.docs[index]);
                                                    Get.to(
                                                        ParoquiasCapelasView());
                                                  },
                                                  child: Text('Capelas'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    slideDialog.showSlideDialog(
                                                        context: context,
                                                        child: detalhes(
                                                            context,
                                                            snap.data
                                                                .docs[index]));
                                                  },
                                                  child: Text('Detalhes'),
                                                ),
                                                // Observer(
                                                //   builder: (_) =>
                                                ElevatedButton(
                                                  onPressed: () {
                                                    controller.setParoquiaAtiva(
                                                        snap.data.docs[index]);
                                                    Get.to(ParoquiasMapaView());
                                                  },
                                                  child: Text('Localização'),
                                                ),
                                                // ),
                                              ],
                                            ),
                                            //),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      );
                    },
                    childCount: snap.hasData ? snap.data.docs.length : 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget detalhes(BuildContext context, DocumentSnapshot doc) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: doc['paroco'],
            readOnly: true,
            decoration: InputDecoration(labelText: 'Pároco'),
          ),
          TextFormField(
            initialValue: doc['vigario'],
            decoration: InputDecoration(labelText: 'Vigário'),
          ),
          TextFormField(
            initialValue: doc['diacono'],
            decoration: InputDecoration(labelText: 'Diácono'),
          ),
          TextFormField(
            initialValue: doc['endereco'] + '  ' + doc['endereco2'],
            decoration: InputDecoration(labelText: 'Endereço'),
          ),
          TextFormField(
            initialValue: doc['telefones'],
            decoration: InputDecoration(labelText: 'Telefones'),
          ),
          TextFormField(
            initialValue: doc['forania'],
            decoration: InputDecoration(labelText: 'Forânia'),
          ),
        ],
      ),
    );
  }
}
