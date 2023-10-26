import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParocosController extends GetxController {
  //TODO: Implement ParocosController

  final count = 0.obs;
  var padreId = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  late List<String> _images;
  List<String> get images => _images;

  // set images(List<String> value) => _images = value;

  List<String> get getimages => _images;

  late List<GlobalKey<FlipCardState>> listKey;

  loadKeys(int qtd) {
    listKey = [];
    for (var i = 0; i < qtd; i++) {
      listKey.add(GlobalKey<FlipCardState>());
    }
  }

  set setimages(List<String> value) => _images = value;

  Stream<QuerySnapshot> getList() {
    var x = FirebaseFirestore.instance
        .collection("artigos")
        //.where('ativo', isEqualTo: true)
        .where('grupo', isEqualTo: 'padres')
        .snapshots();
    //loadKeys(x.length);
    return x;
  }
}
