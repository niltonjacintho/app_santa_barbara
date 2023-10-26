// ignore_for_file: unused_local_variable

import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/modules/quiz/views/quiz_game_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:app2021/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizView extends GetView<QuizController> {
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  //bool _isPlaying = false;
  // RandomColor _randomColor = RandomColor();
  final _sliderKey = GlobalKey();

  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.put(QuizController());
    UtilsController utilsController = Get.put(UtilsController());
    quizController.getTopicos().then((value) => null);
    return Scaffold(
      backgroundColor: UtilsController().corFundoPadrao,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircularText(
                children: [
                  TextItem(
                    text: Text(
                      "Quiz Católico".toUpperCase(),
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    space: 12,
                    startAngle: -90,
                    startAngleAlignment: StartAngleAlignment.center,
                    direction: CircularTextDirection.clockwise,
                  ),
                  TextItem(
                    text: Text(
                      "Você Consegue?".toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.amberAccent[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    space: 10,
                    startAngle: 90,
                    startAngleAlignment: StartAngleAlignment.center,
                    direction: CircularTextDirection.anticlockwise,
                  ),
                ],
                radius: 125,
                position: CircularTextPosition.inside,
                backgroundPaint: Paint()..color = Colors.yellow[50]!,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Card(
              elevation: 50,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Escolha um tema! Vamos lá',
                  style:
                      GoogleFonts.sriracha(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: FutureBuilder(
                    future: controller.getTopicos(),
                    builder: (context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return new Text("Data is not fetched");
                        case ConnectionState.waiting:
                          return new CircularProgressIndicator();
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return new Text("fetch error");
                          } else {
                            return new Container(
                              height: 250.0,
                              child: CarouselSlider.builder(
                                key: _sliderKey,
                                unlimitedMode: true,
                                slideBuilder: (index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color:
                                        quizController.listaTopicos[index].cor,
                                    child: GestureDetector(
                                      onTap: () async {
                                        await quizController.criarQuiz(
                                            quizController.topicoAtual);
                                        Get.to(() => QuizGameViewPage(), preventDuplicates: true);
                                        // Get.to(QuizGameViewPage());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 40),
                                        child: Text(
                                          quizController
                                                  .getTopicoById(index)
                                                  .nome +
                                              '\n\nVamos la!!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                slideTransform: CubeTransform(),
                                slideIndicator: CircularSlideIndicator(
                                  padding: EdgeInsets.only(bottom: 32),
                                ),
                                itemCount: colors.length,
                              ),
                            );
                          }
                        // }
                        default:
                          return Text("connection is just active");
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
