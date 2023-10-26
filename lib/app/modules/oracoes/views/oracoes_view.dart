import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/model/oracao_model.dart';
import 'package:app2021/app/modules/oracoes/controllers/oracoes_controller.dart';
import 'package:app2021/app/modules/oracoes/views/oracoes_ler_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OracoesView extends GetView<OracoesController> {
  //use 'controller' variable to access controller
// Stream<QuerySnapshot> myStream =
//        oracoesComunsController.getOracoesf('');

  UtilsController util = Get.put(UtilsController());
  OracoesController oracoesComunsController = Get.put(OracoesController());
  // BaseStore baseStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: util.corFundoAvisos,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Orações'),
              backgroundColor: Colors.red[900],
              expandedHeight: 200,
              floating: true,
              pinned: true,
              snap: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  tooltip: 'Atualizar orações',
                  onPressed: () {
                    // oracoesComunsController.getOracoes(
                    //     '', true); // handle the press
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/icon/rezando.png',
                  fit: BoxFit.cover,
                ),
                //Text('2222'),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: oracoesComunsController.getOracoes(''),
              builder: (context, AsyncSnapshot snapshot) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                onTap: () {
                                  oracoesComunsController.oracao = new Oracoes(
                                      titulo: snapshot.data.docs[index]
                                          .get('titulo'),
                                      id: snapshot.data.docs[index].get('id'),
                                      texto: snapshot.data.docs[index]
                                          .get('texto'));
                                  Get.to(OracoesLerView());
                                },
                                title: Text(
                                  snapshot.data.docs[index].get('titulo'),
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount:
                        snapshot.hasData ? snapshot.data.docs.length : 0,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
