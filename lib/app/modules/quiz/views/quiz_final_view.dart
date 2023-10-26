import 'package:app2021/app/modules/quiz/views/quiz_top_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app2021/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:shape_of_view/shape_of_view.dart';

class QuizFinalPage extends StatefulWidget {
  final String title;
  const QuizFinalPage({Key key, this.title = "QuizFinal"}) : super(key: key);

  @override
  _QuizFinalPageState createState() => _QuizFinalPageState();
}

class _QuizFinalPageState extends State<QuizFinalPage> {
  //use 'controller' variable to access controller
  QuizController quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        Get.toNamed('/home');
        //  return Future<true>();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.yellow,
        floatingActionButton:
// visible if showShould is true
            FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/home');
            // Add your onPressed code here!
          },
          label: Text('Voltar'),
          icon: Icon(Icons.thumb_up),
          backgroundColor: Colors.pink,
        ),
        body: SafeArea(
          //   child: Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Parabéns ',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.red[900],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  quadroResumo('Acertos', quizController.qtdAcertos.toString(),
                      Colors.green[900],
                      corFonte: Colors.white),
                  quadroResumo(
                      'Erros',
                      (quizController.qtdPerguntas - quizController.qtdAcertos)
                          .toString(),
                      Colors.red[900],
                      corFonte: Colors.white),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  quadroResumo(
                      'Seus Pontos',
                      (quizController.pontuacaoFinal).toStringAsFixed(1),
                      Colors.red[900],
                      corFonte: Colors.white),
                  quadroResumo(
                      'Seus Tempo',
                      (quizController.getFormatTempoCorrido()),
                      Colors.yellow[900],
                      corFonte: Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ShapeOfView(
                height: 300,
                width: 300,
                elevation: 100,
                shape: StarShape(noOfPoints: 5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.yellow[500],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(QuizTopView());
                    },
                    child: Center(
                      child: Text(
                        'Campeões',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget listarTops(BuildContext context, AsyncSnapshot snapshot) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 11, right: 11),
  //     child: ShapeOfView(
  //       shape: ArcShape(
  //           direction: ArcDirection.Outside,
  //           height: 20,
  //           position: ArcPosition.Left),
  //       child: Container(
  //         color: Colors.blue[900],
  //         child: ListView.builder(
  //           shrinkWrap: true,
  //           //   scrollDirection: Axis.horizontal,
  //           itemCount: quizController.listaTop.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: EdgeInsets.only(left: 10, right: 10),
  //               child: ListTile(
  //                 title: Text(
  //                     '${index + 1} -) ${quizController.listaTop[index].nome} com ${quizController.listaTop[index].pontos.toString().substring(0, 4)} pt',
  //                     style: GoogleFonts.meeraInimai(
  //                         fontSize: index == 0 ? 25 : 20,
  //                         fontWeight: FontWeight.w900,
  //                         color: Colors.yellow[300])),
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget quadroResumo(String titulo, String nome, Color cor,
      {Color corFonte = Colors.white}) {
    return ShapeOfView(
      height: 130,
      width: 180,
      elevation: 25,
      shape: RoundRectShape(
        borderRadius: BorderRadius.circular(12),
        borderColor: Colors.transparent, //optional
        borderWidth: 10, //optional
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(titulo, style: TextStyle(fontSize: 20, color: corFonte)),
            Text(
              nome,
              style: TextStyle(fontSize: 45, color: corFonte),
            )
          ],
        ),
        //  ),
      ),
    );
  }
}

class QuizFinalView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuizFinalView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'QuizFinalView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
