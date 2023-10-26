import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/home/views/home_view.dart';
import 'package:app2021/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:app2021/app/modules/quiz/views/quiz_final_view.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flat_dialog/flat_dialog.dart';
// import 'package:flutter_beautiful_popup/main.dart';

// class QuizGameViewPage extends StatefulWidget {
//   final String title;
//   const QuizGameViewPage({Key key, this.title = "QuizGame"}) : super(key: key);

//   @override
//   _QuizGameViewPageState createState() => _QuizGameViewPageState();
// }

class QuizGameViewPage extends GetView<QuizController> {
//class _QuizGameViewPageState extends State<QuizGameViewPage> {
  final Color corBotaoPadrao = Colors.black45;
  final Color corBotaoCerto = Colors.green[700];
  final Color corBotaoErrado = Colors.red[700];
  final QuizController quizController = Get.put(QuizController());
  final UtilsController utilsController = Get.put(UtilsController());
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    quizController.initQuiz();
    //  quizController.startCountdown();
    //  int randon = 0;
    return Scaffold(
      backgroundColor: UtilsController().corFundoPadrao,
      floatingActionButton:
// visible if showShould is true
          FloatingActionButton.extended(
        onPressed: () {
          Get.to(HomeView());
          // Add your onPressed code here!
        },
        label: Text('Voltar'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future:
              quizController.getPerguntasPorTopicos(quizController.topicoAtual),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text("Data is not fetched");
                break;
              case ConnectionState.waiting:
                return new CircularProgressIndicator();
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return new Text("fetch error");
                } else {
                  //quizController.regerarRandon(snapshot.data                      .length); // randon = utilsController.gerarRnd(snapshot.data.length);
                  //   _controller.start();
                  return Column(
                    children: <Widget>[
                      Text(
                        quizController.topicoAtual.nome,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.yellow[400]),
                      ),
                      Center(child: temporizador(context)),
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Obx(
                            () => Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                quizController.perguntaAtual.value.toString() +
                                    ') ' +
                                    snapshot.data[
                                            quizController.perguntaAtual.value]
                                        .get('pergunta'),
                                style: UtilsController().stylePerguntas,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => listarRespostas(
                            context,
                            snapshot.data[quizController.perguntaAtual.value]
                                .get('perguntasRespostas'),
                            snapshot.data.length),
                      ),
                    ],
                  );
                }
                //}
                break;
              default:
                return Text("connection is just active");
            }
          },
        ),
      ),
    );
  }

  Widget temporizador(BuildContext context) {
    return CircularCountDownTimer(
      duration: 180,
      initialDuration: 0,
      controller: _controller,
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 4,
      ringColor: Colors.grey[300],
      ringGradient: null,
      fillColor: Colors.blue[900], // .purpleAccent[100],
      fillGradient: null,
      backgroundColor: Colors.purple[900],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        print('Countdown Started');
      },
      onComplete: () {
        print('Countdown Ended');
      },
    );
  }

  Widget listarRespostas(BuildContext context, List snapshot, int size) {
    return Expanded(
      // child: Obx(
      //   () =>
      child: ListView.builder(
        itemCount: snapshot
            .length, //quizController.listaPerguntas[quizController.perguntaAtual]            .perguntasRespostas.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(left: 1, right: 1),
                child: ElevatedButton(
                //  color: Colors.blue[100],
                //  shape: RoundedRectangleBorder(
                //      borderRadius: BorderRadius.circular(18.0),
//side: BorderSide(color: Colors.red)),
                  onPressed: () {
                    bool acertou = snapshot[i]['respostacerta'];
                    if (acertou) {
                      quizController.marcarAcerto();
                    }
                    FlatDialog(
                      context: context,
                      type: acertou ? DialogType.success : DialogType.error,
                      title: acertou ? "PARABÉNS" : "ERROR",
                      desc: acertou
                          ? 'Gostei, você acertou. '
                          : 'Temos de estudar mais. Você terá mais sorte na próxima!',
                      buttons: [
                        FlatDialogButton(
                          child: Center(
                            child: Text(
                              acertou ? "Parabéns!" : "Vamos!!",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          onPressed: () async {
                            if (quizController.perguntaAtual.value >=
                                quizController.totalPergunta.value - 1) {
                              quizController.perguntaAtual.value = 1;
                              quizController.stopCountdown();
                              await quizController.salvarResultado();
                              Navigator.of(context).pop();
                              Get.to(() => QuizFinalPage());
                              quizController.tempoRestante.value =
                                  int.parse(_controller.getTime());
                              //  Navigator.of(context).pop();
                              //  Modular.to.pushNamed('/quizpagefinal');
                            } else {
                              quizController.incPerguntaAtual();
                              quizController.regerarRandon(size);
                              Navigator.pop(context);
                            }
                            //  });
                          }, //Navigator.pop(context),
                          width: 150,
                        )
                      ],
                    ).show();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(snapshot[i]['respostatexto'],
                            style: UtilsController().styleRespostas)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      //    ),
    );
  }
}
