import 'package:app2021/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app2021/app/model/opcoesMenu.model.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var opcaoMenu = 0.obs;
  var qtdVelasAcesas = 0.obs;
  var velasAcesas = [];
  List<OpcoesMenu> listaMenu = [];

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  fillMenu() {
    listaMenu = [];
    listaMenu.add(
      new OpcoesMenu(
          image: 'assets/images/avisos.png',
          titulo: 'Fique por dentro',
          ordem: 01,
          destino: Routes.ARTIGOS,
          grupo: 100,
          subtitulo:
              'Aqui você encontra todos os avisos e mensagens da paróquia. Tudo separado em grupos especialmente para você!',
          cardColor: Colors.blue),
    );

    listaMenu.add(new OpcoesMenu(
      image: 'assets/images/vela.png',
      titulo: 'Vela Virtual',
      ordem: 09,
      destino: Routes.VELA,
      grupo: 0,
      cardColor: Colors.red[900],
      textColor: Colors.white,
      subtitulo: ' ..',
    ));
    listaMenu.add(new OpcoesMenu(
      image: 'assets/images/vela.png',
      titulo: 'Nossos Párocos',
      ordem: 09,
      destino: Routes.PAROCOS,
      grupo: 0,
      cardColor: Colors.red[900],
      textColor: Colors.white,
      subtitulo: 'Venha conhecer os párocos que fazem parte de nossa história',
    ));

    listaMenu.add(new OpcoesMenu(
        image: 'assets/images/paroquia.png',
        titulo: 'Nossas Paróquias',
        ordem: 12,
        destino: Routes.PAROQUIAS,
        grupo: 0,
        cardColor: Colors.green[900],
        textColor: Colors.white,
        subtitulo: ''));

    listaMenu.add(new OpcoesMenu(
      image: 'assets/images/quiz.png',
      titulo: 'Quiz',
      ordem: 3,
      destino: Routes.QUIZ,
      grupo: 0,
      subtitulo:
          'Venha testar seus conhecimentos da nossa igreja! Participe do nosso Quiz!',
    ));

    listaMenu.add(new OpcoesMenu(
      image: 'assets/images/agenda.png',
      titulo: 'Agenda Paroquial',
      ordem: 5,
      destino: 'agenda',
      grupo: 0,
      subtitulo: ' ..',
    ));

    listaMenu.add(new OpcoesMenu(
      image: 'assets/images/pastorais.png',
      titulo: 'Nossas Pastorais',
      ordem: 02,
      destino: 'Routes.PAROQUIAS',
      grupo: 0,
      subtitulo: '.. ',
    ));

    listaMenu.add(
      new OpcoesMenu(
        image: 'assets/images/pessoais.png',
        titulo: 'Orações',
        ordem: 5,
        destino: Routes.ORACOES,
        grupo: 0,
        subtitulo: '.. ',
      ),
    );
  }
}
