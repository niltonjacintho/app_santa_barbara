import 'package:app2021/app/model/quizRank_model.dart';
import 'package:app2021/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
//import 'quiz_top_controller.dart';

class QuizTopView extends StatefulWidget {
  final String title;
  const QuizTopView({required Key key, this.title = "QuizTop"}) : super(key: key);

  @override
  _QuizTopViewState createState() => _QuizTopViewState();
}

class _QuizTopViewState extends State<QuizTopView> {
  //use 'controller' variable to access controller

 // QuizTopController quizTopController = Modular.get();
  QuizController quizController = Get.put(QuizController());
  late Future<List<QuizRankModel>> _lista;

  void initState() {
    super.initState();
    _lista = quizController.getTopN();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Center(
              child: Text('SOMENTE OS MELHORES',
                  style: new TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            FutureBuilder(
                future: _lista,
                initialData: quizController.initialData(new QuizRankModel()),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done) {
                  //   if (snapshot.hasError) {
                  //     print(snapshot.error);
                  //   }
                  if (quizController.listaTop.length <= 0) {
                    //   return Text('no data');
                    return CircularProgressIndicator();
                  } else {
                    return listarTops(context, snapshot);
                  }
                  // }
                  // } else {
                  //   // loading
                  // }
                }),
            // )
          ],
        ),
      ),
    );
  }

  Widget listarTops(BuildContext context, AsyncSnapshot snapshot) {
    return Padding(
      padding: EdgeInsets.only(left: 11, right: 11),
      child: Column(
        children: <Widget>[
          ShapeOfView(
            height: 300,
            width: 300,
            elevation: 100,
            shape: StarShape(noOfPoints: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.yellow[500],
              ),
              child: GestureDetector(
                onTap: () {
                  alerta(1, snapshot);
                },
                child: Center(
                  child: Text(
                    '${quizController.listaTop[0].nome.substring(0, quizController.listaTop[0].nome.indexOf(' ', 2))}',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ShapeOfView(
              elevation: 20,
              height: 200,
              width: 200,
              shape: StarShape(noOfPoints: 7),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue[900],
                ),
                child: GestureDetector(
                  onTap: () {
                    alerta(2, snapshot);
                  },
                  child: Center(
                    //   color: Colors.yellow[900],
                    child: Text(
                      '${quizController.listaTop[1].nome.substring(0, quizController.listaTop[1].nome.indexOf(' ', 2))}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ShapeOfView(
              elevation: 20,
              height: 180,
              width: 180,
              shape: StarShape(noOfPoints: 5),
              child: GestureDetector(
                onTap: () {
                  alerta(3, snapshot);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.yellow[900],
                  ),
                  child: Center(
                    child: Text(
                      '${quizController.listaTop[2].nome.substring(0, quizController.listaTop[2].nome.indexOf(' ', 2))}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  alerta(int id, AsyncSnapshot snapshot) {
    Alert(
      context: context,
      type: AlertType.info,
      title: '$idº Colocado',
      desc: '',
      content: Column(
        children: <Widget>[
          Text(
            snapshot.data[id].nome,
            style: TextStyle(fontSize: 30),
          ),
          Text(
              'Pontos: ' + snapshot.data[id].pontos.toString().substring(0, 4)),
          //   Text('Tema  : ' + quizController.listaTop[id].topico),
          //   Text('no dia:' + quizController.listaTop[id].data.toString()),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            "Fechar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}

// class QuizTopView extends GetView {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QuizTopView'),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           'QuizTopView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
