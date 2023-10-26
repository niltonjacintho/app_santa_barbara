import 'package:app2021/app/controllers/auth_controller.dart';
import 'package:app2021/app/controllers/utils_controller.dart';
import 'package:app2021/app/model/quizRank_model.dart';
import 'package:app2021/app/model/quiz_model.dart';
import 'package:app2021/app/services/db_service.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_color/random_color.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

class QuizController extends GetxController {
  //TODO: Implement QuizController

  final count = 0.obs;
  RxInt totalPergunta = 0.obs;
  RxInt randonPergunta = 0.obs;

  @override
  void onInit() {
    getTopicos().then((value) => null);
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  void regerarRandon(int num) {
    randonPergunta.value = utilsController.gerarRnd(num);
  }

  var db = FirebaseFirestore.instance;
  AuthController authController = Get.put(AuthController());
  DbService dbService = Get.put(DbService());
  UtilsController utilsController = Get.put(UtilsController());

  List<BasePerguntas> perguntas = [];

  BaseTopicos topicoAtual = new BaseTopicos();

  var listaTopicos = [].obs;

  BasePerguntas basePerguntas = new BasePerguntas();

  List<BasePerguntas> listaPerguntas = [];

  RxInt perguntaAtual = 0.obs;
  int qtdPerguntas = 10;

  incPerguntaAtual() {
    perguntaAtual++;
  }

  resetPerguntaAtual() {
    perguntaAtual.value = 1;
  }

  Desafios desafio = new Desafios();

  int qtdAcertos = 0;

  List<QuizRankModel> listaTop = [];

  marcarAcerto() {
    qtdAcertos++;
  }

  // int qtdPerguntas = 10;
  final int tempoPadrao = 180;
  int _contPerguntas = 0;

  var tempoRestante = 0.obs;

  bool stopCount = false;

  initQuiz({int tempo}) {
    tempoRestante.value = tempo == null ? tempoPadrao : tempo;
    stopCount = false;
    _contPerguntas = 0;
    qtdAcertos = 0;
    stopCount = false;
    perguntaAtual.value = 1;
  }

  decTempoRestante() {
    if (tempoRestante.value > 0) {
      tempoRestante.value--;
    }
  }

  double get pontuacaoFinal {
    return qtdAcertos * (tempoRestante.value / 10);
  }

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (stopCount) {
        timer.cancel();
        tempoRestante.value = tempoPadrao;
      } else {
        decTempoRestante();
      }
      // print(tempoRestante);
    });
  }

  salvarResultado() {
    QuizRankModel q = new QuizRankModel();
    q.pontos = pontuacaoFinal;
    q.acertos = qtdAcertos;
    q.erros = qtdPerguntas - qtdAcertos;
    q.data = DateTime.now();
    q.nome = authController.user.user.displayName;
    q.email = authController.user.user.email;
    q.topico = topicoAtual.nome;
    dbService.salvarObjeto(q, 'quizrank');
  }

  void stopCountdown() {
    stopCount = true;
  }

  int get getTempoRestante {
    return tempoRestante.value;
  }

  int get getTempoCorrido {
    return tempoPadrao - tempoRestante.value;
  }

  String getFormatTempoCorrido() {
    Duration d = Duration(hours: 0, minutes: 0, seconds: getTempoCorrido);
    return d.toString().split('.').first.padLeft(8, "0").substring(3);
  }

  String getFormatTempoRestante() {
    Duration d = Duration(hours: 0, minutes: 0, seconds: tempoRestante.value);
    return d.toString().split('.').first.padLeft(8, "0").substring(3);
  }

  UtilsController _utilsController = Get.put(UtilsController());
  AuthController _authController = Get.put(AuthController());

  Future<bool> limparBase() async {
    await DbService().cleanFolder('quiztopicos');
    await DbService().cleanFolder('quizperguntas');
    return true;
  }

  Future getTopicos({qtd = 999}) async {
    RandomColor _randomColor = new RandomColor();
    await db.collection('quiztopicos').get().then(
      (querySnapshot) {
        listaTopicos = [].obs;
        querySnapshot.docs.forEach((doc) {
          listaTopicos.add(new BaseTopicos(
              nome: doc.data()['nome'],
              id: doc.data()['id'],
              cor: _randomColor.randomColor()));
        });
      },
    );
    // return listaTopicos;
  }

  BaseTopicos getTopicoById(int index) {
    topicoAtual = listaTopicos[index];
    return topicoAtual;
  }

  initialData(q) {
    var x = [];
    q.nome = '';
    q.pontos = 0.00;
    q.email = '';
    q.acertos = 0;
    q.erros = 0;
    q.id = '';
    x.add(q);
    x.add(q);
    x.add(q);
    return x;
  }

  Future<List<QuizRankModel>> getTopN({int n = 3}) async {
    listaTop = [];
    await db
        .collection('quizrank')
        .orderBy('pontos', descending: true)
        .limit(n)
        .get()
        .then((querySnapshot) {
      QuizRankModel q = new QuizRankModel();
      var element;
      for (int i = 0; i <= querySnapshot.docs.length - 1; i++) {
        element = querySnapshot.docs[i];
        //  querySnapshot.docs.forEach((var element) async {
        q = new QuizRankModel();
        q.nome = element.data()['nome'];
        q.pontos = element.data()['pontos'];
        q.email = element.data()['email'];
        q.acertos = element.data()['acertos'];
        q.erros = element.data()['erros'];
        // q.data = element.data()['data'];
        //  q.topico = element.data()['topico'];
        q.id = element.data()['id'];
        listaTop.add(q);
      }
    });
    return listaTop;
  }

  Future<List<QuizRankModel>> getTopNOffLine() async {
    listaTop = [];
    QuizRankModel q;
    for (int i = 0; i < 4; i++) {
      q = new QuizRankModel();
      q.nome = 'Nome Cesar Jacintho$i ';
      q.pontos = Random.secure().nextDouble();
      q.email = 'Nome$i@gmail.com';
      q.acertos = Random.secure().nextInt(50);
      q.erros = Random.secure().nextInt(30);
      q.topico = 'Arca de Noé';
      q.data = DateTime.now();
      listaTop.add(q);
    }
    return listaTop;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getPerguntasPorTopicos(BaseTopicos topico) async {
    // Random random = new Random();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> lista = [];
    return db
        .collection('quizperguntas')
        .where('idTopico', isEqualTo: topico.id)
        .get()
        .then((querySnapshot) {
      totalPergunta.value = qtdPerguntas > querySnapshot.docs.length
          ? querySnapshot.docs.length
          : qtdPerguntas;
      List<int> _numeros = [];
      _utilsController.randomGerados = [];
      for (var i = 0; i < totalPergunta.value; i++) {
        //_utilsController.gerarRnd(totalPergunta.value);
        _numeros.add(_utilsController.gerarRnd(querySnapshot.docs.length));
      }
      _utilsController.randomGerados.sort();
      var cont = 0;
      var _idnum = 0;
      try {
        querySnapshot.docs.forEach((element) {
          if (lista.length <= totalPergunta.value - 1) {
            if (cont == _utilsController.randomGerados[_idnum]) {
              lista.add(element);
              _idnum++;
            }
            cont++;
          }
        });
      } catch (e) {
        print(e);
      }

      return lista; //querySnapshot.docs;
    });
  }

  carregarTopicos() async {
    listaUrls.forEach((element) {
      BaseTopicos b = new BaseTopicos(
          nome: element.id,
          cor: null,
          id: element.id.trim().replaceAll(' ', '').toLowerCase());
      //   listaTopicos.add(b);
      DbService().salvarObjeto(b, 'quiztopicos');
    });
  }

  RxList<dynamic> listaUrls = [].obs;

  inicializarUrls() {
    RandomColor _randomColor = new RandomColor();
    listaUrls = [].obs;
    //new List<BaseTopicos>();
    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/perguntas-biblicas-faceis/',
        id: 'Biblia nivel fácil',
        cor: _randomColor.randomColor()));
    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/50-perguntas-biblicas-nivel-medio/',
        id: 'Biblia nivel médio',
        cor: _randomColor.randomColor()));

    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/perguntas-biblicas-infantil/',
        id: 'Biblia nivel infantil',
        cor: _randomColor.randomColor()));

    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/perguntas-biblicas-dificil/',
        id: 'Biblia nivel difícil',
        cor: _randomColor.randomColor()));

    listaUrls.add(new BaseTopicos(
        nome:
            'https://www.respostas.com.br/perguntas-biblicas-noe-arca-diluvio/',
        id: 'Arca de Noé',
        cor: _randomColor.randomColor()));

    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/perguntas-biblicas-jesus-cristo/',
        id: 'Jesus Cristo',
        cor: _randomColor.randomColor()));

    listaUrls.add(new BaseTopicos(
        nome: 'https://www.respostas.com.br/perguntas-biblicas-natal/',
        id: 'Natal',
        cor: _randomColor.randomColor()));
    listaUrls.add(new BaseTopicos(
        nome:
            'https://www.respostas.com.br/perguntas-biblicas-velho-testamento/',
        id: 'Velho Testamento',
        cor: _randomColor.randomColor()));
  }

  carregarPerguntas() async {
    //await limparBase;
    await inicializarUrls();
    await carregarTopicos();
    _contPerguntas = 0;
    listaPerguntas = [];
    for (var element in listaUrls) {
      var response = await http.get(Uri.parse(element.nome));
      _carregarPerguntas(element, response.body);
    }
  }

  Future<String> _carregarPerguntas(BaseTopicos topico, String html) async {
    var unescape = new HtmlUnescape();
    try {
      html = unescape.convert(html);
      html =
          html.substring(html.toLowerCase().indexOf('<article'.toLowerCase()));
      BasePerguntas p = new BasePerguntas();
      while (html.toLowerCase().indexOf('ver resposta'.toLowerCase()) >= 0) {
        //pega a perguntas
        p = new BasePerguntas();
        html = html.substring(html.indexOf('<h3>'));
        p.pergunta = html.substring(4, html.indexOf('</h3'));
        try {
          p.pergunta = p.pergunta
              .substring(p.pergunta.indexOf(new RegExp(r'[A-Z][a-z]')))
              .trim();
        } catch (e) {
          print(null);
        }
        if (p.pergunta.indexOf('Qual o nome do monte onde') != -1)
          print('parar aqui');
        p.idTopico = topico.id.trim().replaceAll(' ', '').toLowerCase();
        html = html.substring(html.indexOf('</h3') + 5);
        // Respostas
        List<String> tempRespostas = html
            .substring(0, html.indexOf('<div class'))
            .replaceAll('<p>', '')
            .replaceAll('</p>', ';')
            .split(';');
        //limpa o lixo dos textos
        List<String> temp = [];
        tempRespostas.forEach((element) {
          if (element != "") {
            if (element.indexOf(') ') > 0)
              temp.add(element.substring(element.indexOf(') ') - 1));
            else
              temp.add(element);
          }
        });
        tempRespostas = temp;
        print(tempRespostas); //
        //pergar resposta certa
        String r;
        try {
          r = html.substring(
              html.toLowerCase().indexOf('<div class="hc-pt'.toLowerCase()),
              html.toLowerCase().indexOf('<button>Ver'.toLowerCase()));
          r = r.substring(r.indexOf('<p>'), r.indexOf('</p>'));
          r = r.replaceAll('<p>', '').replaceAll('</p>', '').trim();
          //   print(r);
        } catch (e) {
          //  print(e);
        }
        p.perguntasRespostas = [];
        PerguntasRespostas pr = new PerguntasRespostas();
        int i = 0;
        tempRespostas.forEach((element) {
          if (element != '' && element != '.') {
            pr = new PerguntasRespostas();
            pr.respostatexto = element;
            pr.sequencia = i;
            pr.respostacerta = element.trim().toLowerCase() == r.toLowerCase();
            p.perguntasRespostas.add(pr);
            i++;
          }
        });
        //  listaPerguntas.add(p);
        p.id = _contPerguntas.toString();
        _contPerguntas++;
        DbService().salvarObjeto(p, 'quizperguntas');
        //  print(p);
        try {
          html = html.substring(html.indexOf('<h3>'));
        } catch (e) {
          html = '';
        }
      }
      // print(html);
      return html;
    } catch (e) {
      //  print(e);
      return '';
    }
  }

//#region Metodos da montagem do QUIZ

//#endregion

  criarQuiz(BaseTopicos topico) async {
    utilsController.randomGerados = [];
    // await getPerguntasPorTopicos(topico);
    desafio = new Desafios();
    desafio.data = new DateTime.now();
    desafio.finalizado = false;
    desafio.email = _authController.user.user.email;
    desafio.desafioPerguntas = [];
    if (listaPerguntas.length > 0) {
      listaPerguntas.forEach((element) {
        desafio.desafioPerguntas
            .add(new DesafioPerguntas(id: element.id, acertou: false));
      });
    }
  }
}
