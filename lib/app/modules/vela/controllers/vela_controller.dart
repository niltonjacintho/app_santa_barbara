// ignore_for_file: invalid_return_type_for_catch_error

import 'package:app2021/app/controllers/auth_controller.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/model/vela_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class VelaController extends GetxController {
  //TODO: Implement VelaController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  VelaModel velaAtual = new VelaModel();

  novaVela() {
    velaAtual = new VelaModel();
  }

  int value = 0;
  int qtdVelasAcesas = 0;
  List listaTipos = [];
  List velasAcesas = [];

  var uuid = Uuid();
  AuthController authController = Get.put(AuthController());
  UtilsController utilsController = Get.put(UtilsController());

  getTiposPedidos() async {
    QuerySnapshot qShot =
        await FirebaseFirestore.instance.collection('pedidos_tipos').get();
    listaTipos = qShot.docs.map((doc) => doc.get('tipo')).toList();
    return qShot.docs.map((doc) => doc.get('tipo')).toList();
  }

  gravar() async {
    if (velaAtual.id == '') {
      velaAtual.id = uuid.v4();
    }
    DocumentReference reference =
        FirebaseFirestore.instance.doc("vela_virtual/" + velaAtual.id);
    // ignore: unnecessary_null_comparison
    velaAtual.dataInclusao = velaAtual.dataInclusao == null
        ? DateTime.now()
        : velaAtual.dataInclusao;
    velaAtual.solicitanteemail =
        authController.user.additionalUserInfo!.profile!["email"];
    velaAtual.solicitantenome =
        authController.user.additionalUserInfo!.profile!["name"];
    velaAtual.dataAlteracao = DateTime.now();
    velaAtual.data = DateTime.now();
    velaAtual.minutosrestantes = utilsController.tempoVelaAcesa;
    reference
        .set(velaAtual.toJson())
        .then((result) => {getVelasAcesas(velaAtual.solicitanteemail)})
        .catchError((err) => print('ERROR $err'));
  }

  Future<List> getVelasAcesas(String email) async {
    velasAcesas = List.empty();
    qtdVelasAcesas = 0;
    await for (var snapshot in FirebaseFirestore.instance
        .collection('vela_virtual')
        .where('solicitanteemail', isEqualTo: email)
        .snapshots()) {
      for (var element in snapshot.docs) {
        print(element.data());
        Timestamp t = element['data'];
        VelaModel m = new VelaModel(
            id: element.data()['id'],
            intensao: element.data()['intensao'],
            destinatario: element.data()['destinatario'],
            data: t.toDate());
        Duration difference = DateTime.now().difference(t.toDate());
        if (difference.inMinutes <= utilsController.tempoVelaAcesa) {
          velasAcesas.add(m);
          qtdVelasAcesas++;
        }
      }
    }
    return velasAcesas;
  }
}
