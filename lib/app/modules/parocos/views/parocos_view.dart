import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/parocos/controllers/parocos_controller.dart';

// ignore: must_be_immutable
class ParocosView extends GetView<ParocosController> {
  // int _index = 0;
  ParocosController parocosController = Get.put(ParocosController());
  UtilsController utilsController = Get.put(UtilsController());
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> myStream = parocosController.getList();
    //pa.getimages;
    return Scaffold(
      backgroundColor: utilsController.corFundoAvisos,
      //appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          }),
      body: StreamBuilder<QuerySnapshot>(
          stream: myStream,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Column(
                children: [Text('error')],
              );
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Column(children: <Widget>[
                    SizedBox(
                      child: const CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Recuperando informações.'),
                    )
                  ]);
                case ConnectionState.done:
                  return Column(children: <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('\$${snapshot.data} (closed)'),
                    )
                  ]);
                case ConnectionState.active:
                  final int messageCount = snapshot.data.docs.length;
                  parocosController.loadKeys(messageCount);
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height *
                          .9, // card height
                      child: PageView.builder(
                        itemCount: messageCount,
                        controller: PageController(viewportFraction: 0.8),
                        onPageChanged: (int index) => parocosController
                            .padreId.value = index, // TRATAR O OBS AQUI
                        itemBuilder: (_, i) {
                          return Obx(
                            () => Transform.scale(
                              scale: i == parocosController.padreId.value
                                  ? 1
                                  : 0.7,
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: FlipCard(
                                  key: parocosController.listKey[i],
                                  flipOnTouch: false,
                                  front: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: GestureDetector(
                                            onTap: () => {
                                              parocosController
                                                  .listKey[i].currentState!
                                                  .toggleCard(),
                                            },
                                            child: snapshot.data.docs[i]
                                                        ['imagem'] !=
                                                    ''
                                                ? Image.network(snapshot
                                                    .data.docs[i]['imagem'])
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 46),
                                                    child: Text(
                                                      'Ops. \nNão achei a imagem do pároco',
                                                      style: TextStyle(
                                                        fontSize: 30,
                                                        // textAlign:
                                                        //     TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.docs[i]['titulo'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                snapshot.data.docs[i]
                                                    ['subtitulo'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //    ),
                                      ],
                                    ),
                                  ),
                                  back: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: GestureDetector(
                                      onTap: () {
                                        parocosController
                                            .listKey[i].currentState!
                                            .toggleCard();
                                      },
                                      child: Text(
                                          snapshot.data.docs[i]['conteudo']),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                          //);
                        },
                      ),
                    ),
                  );
                default:
                  return Text('error');
              }
              return Text('erro indefinido');
            }
          }),
    );
  }
}
