import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:app2021/app/model/grupos_model.dart';
import 'package:app2021/app/controllers/grupos_controller.dart';
import 'package:get_storage/get_storage.dart';

class UtilsController extends GetxController {
  RxDouble tamanhoFonte = 0.0.obs;
  final count = 0.obs;
  final box = GetStorage();
  @override
  // ignore: must_call_super
  void onInit() {
    tamanhoFonte.value = box.read('tamanhoFonte');
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  incTamanhoFonte() {
    tamanhoFonte.value++;
    tamanhoFonte.value = tamanhoFonte > 50 ? 50 : tamanhoFonte.value;
    box.write('tamanhoFonte', tamanhoFonte.value);
  }

  decTamanhoFonte() {
    tamanhoFonte.value--;
    tamanhoFonte = tamanhoFonte > 12 ? 12 : tamanhoFonte;
    box.write('tamanhoFonte', tamanhoFonte);
  }

  Color cor;
  GruposController gruposService = Get.put(GruposController());

  Color getColorRandom() {
    Random random = new Random();
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  Grupos get grupoAvisos {
    return gruposService.getGroupById('avisos');
  }

  Grupos get grupoPadres {
    return gruposService.getGroupById('padres');
  }

  Grupos get grupoPerguntas {
    return gruposService.getGroupById('perguntas');
  }

  Grupos get grupoHorarios {
    return gruposService.getGroupById('horarios');
  }

  Grupos get grupoNoticias {
    return gruposService.getGroupById('noticias');
  }

  //int grupoAvisos = 100;

  Grupos grupoAtivo;

  double get espacoPadrao => 15;

  // static const Color transparent = Color(0x00000000);
  // static const Color fundopadrao = Color.fromRGBO(179, 45, 0, 1.0);
  Color get corFundoPadrao => Color.fromRGBO(179, 45, 0, 1.0);
  Color get corFundoBarra => Color.fromRGBO(26, 0, 0, 1.0);
  Color get corFundoAvisos => Color.fromRGBO(76, 26, 26, 1);
  Color get corFundoArtigo => Color.fromRGBO(255, 230, 254, 1.0);
  Color get corFundoPerguntas => Color.fromRGBO(0, 0, 102, 1.0);

  final InputDecorationTheme inputDecorationTheme =
      new InputDecorationTheme(contentPadding: EdgeInsets.all(1));

  /// ********
  /// Retorna o tempo em minutos para a vela ficar acesa
  int get tempoVelaAcesa => 60;

  TextStyle stHeader = new TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle stBody = new TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  TextStyle stylePerguntas =
      new TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
  TextStyle styleRespostas =
      new TextStyle(fontSize: 20, fontWeight: FontWeight.normal);
  TextStyle styleRespostaCerta = new TextStyle(
      fontSize: 20, fontWeight: FontWeight.normal, color: Colors.blueGrey[800]);
  TextStyle styleRespostaErrada = new TextStyle(
      fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white);

  double get espacoPadraoForm => 5;

  String get defaultLanguage => 'pt_BR';

  String tratarnull(dynamic valor) {
    return valor == null ? ' ' : valor;
  }

  InputDecoration inputDecoration({String label = '', double vEspaco = 5}) {
    return new InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(vEspaco),
    );
  }

  FormBuilderDateTimePicker campoDataPadrao(
      {String label = '',
      String atributo = '',
      String errorMessage = '',
      double vEspaco = 2}) {
    return FormBuilderDateTimePicker(
      name: atributo,
      inputType: InputType.date,
      //   format: DateFormat("dd/MM/yyyy"),
      decoration: inputDecoration(label: label, vEspaco: vEspaco),
      // validators: [
      //   FormBuilderValidators.required(
      //     errorText: Messages().campoObrigatorio(mensagem: errorMessage),
      //   ),
      // ],
    );
  }

  FormBuilderTextField campoTextoPadrao(
      {String label = '',
      String atributo = '',
      String errorMessage = '',
      double vEspaco = 2}) {
    return FormBuilderTextField(
      name: atributo,
      decoration: inputDecoration(label: label, vEspaco: vEspaco),
      // validators: [
      //   FormBuilderValidators.required(
      //     errorText: Messages().campoObrigatorio(mensagem: errorMessage),
      //   ),
      // ],
    );
  }

  Align textoEsquerda(String texto,
      {TextStyle stilo, Alignment alinhamento = Alignment.centerLeft}) {
    stilo = stilo == null ? stBody : stilo;
    return Align(
      alignment: alinhamento,
      child: Text(tratarnull(texto), style: stilo),
    );
  }

  bool existeTexto(String texto, String filtro) {
    return texto.toLowerCase().indexOf(filtro.toLowerCase()) >= 0;
  }

  List<DropdownMenuItem> getCategoryList() {
    List<DropdownMenuItem> result = new List<DropdownMenuItem>();
    result.add(new DropdownMenuItem(value: 100, child: Text('Avisos')));
    result.add(new DropdownMenuItem(value: 200, child: Text('Eventos')));
    result.add(
        new DropdownMenuItem(value: 300, child: Text('Notícias Católicas')));
    result.add(new DropdownMenuItem(value: 400, child: Text('Parocos')));
    result.add(
        new DropdownMenuItem(value: 500, child: Text('Pessoas Importantes')));
    result.add(new DropdownMenuItem(value: 600, child: Text('Nossa Paróquia')));
    result.add(
        new DropdownMenuItem(value: 700, child: Text('Perguntas frequentes')));
    result.add(
        new DropdownMenuItem(value: 800, child: Text('Horários paroquiais')));
    return result;
  }

  DropdownMenuItem getDropDownMenuItem(num v) {
    return getCategoryList().firstWhere((categ) => categ.value == v);
  }

  List<int> randomGerados = [];
  inicializarrandomGerados() {
    randomGerados = [];
  }

  gerarRnd(int qtd) {
    try {
      Random randomGenerator = new Random();
      int num2 = randomGenerator.nextInt(qtd);
      if (randomGerados.length == qtd) {
        return -1;
      }
      while (randomGerados.indexOf(num2) >= 0) {
        num2 = randomGenerator.nextInt(qtd);
      }
      randomGerados.add(num2);
      return num2;
    } catch (e) {
      print(e);
    }
  }

  void showLongToast(String msg) {
    // FlutterFlexibleToast.showToast(
    //   toastGravity: ToastGravity.CENTER,
    //   elevation: 25,
    //   radius: 20,
    //   fontSize: 20,
    //   textColor: Colors.white,
    //   backgroundColor: Colors.red[900],
    //   message: msg,
    //   toastLength: Toast.LENGTH_LONG,
    // );
  }
}
