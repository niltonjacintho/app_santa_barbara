import 'package:flutter/material.dart';

class QuizDB {
  QuizDb? quizDb;

  QuizDB({required this.quizDb});

  QuizDB.fromJson(Map<String, dynamic> json) {
    quizDb =
        json['quizDb'] != null ? new QuizDb.fromJson(json['quizDb']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quizDb != null) {
      data['quizDb'] = this.quizDb!.toJson();
    }
    return data;
  }
}

class QuizDb {
  List<BaseTopicos>? baseTopicos;
  List<Quiz>? quiz;
  List<Desafios>? desafios;
  BasePerguntas? basePerguntas;

  QuizDb({required this.baseTopicos, required this.quiz, required this.desafios, required this.basePerguntas});

  QuizDb.fromJson(Map<String, dynamic> json) {
    if (json['baseTopicos'] != null) {
      baseTopicos = [];
      json['baseTopicos'].forEach((v) {
        baseTopicos!.add(new BaseTopicos.fromJson(v));
      });
    }
    if (json['quiz'] != null) {
      quiz = [];
      json['quiz'].forEach((v) {
        quiz!.add(new Quiz.fromJson(v));
      });
    }
    if (json['desafios'] != null) {
      desafios = [];
      json['desafios'].forEach((v) {
        desafios!.add(new Desafios.fromJson(v));
      });
    }
    basePerguntas = json['basePerguntas'] != null
        ? new BasePerguntas.fromJson(json['basePerguntas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.baseTopicos != null) {
      data['baseTopicos'] = this.baseTopicos!.map((v) => v.toJson()).toList();
    }
    if (this.quiz != null) {
      data['quiz'] = this.quiz!.map((v) => v.toJson()).toList();
    }
    if (this.desafios != null) {
      data['desafios'] = this.desafios!.map((v) => v.toJson()).toList();
    }
    if (this.basePerguntas != null) {
      data['basePerguntas'] = this.basePerguntas!.toJson();
    }
    return data;
  }
}

class BaseTopicos {
  String? id = '';
  String? nome = '';
  Color? cor;

  get getIdBase => nome!.trim().replaceAll(' ', '').toLowerCase();

  BaseTopicos({ this.id,  this.nome,  this.cor});

  BaseTopicos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cor = json['cor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cor'] = this.cor;
    return data;
  }
}

class Quiz {
  String id = '';
  String titulo = '';
  List<QuizTopico>? quizTopicos = [];
  String recomendacoes = '';
  String qtdperguntas = '';
  List<QuizPerguntas>? quizPerguntas = [];

  Quiz(
      {this.id = '',
      this.titulo = '',
      this.quizTopicos,
      this.recomendacoes = '',
      this.qtdperguntas = '',
      this.quizPerguntas});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    if (json['quizTopico'] != null) {
      quizTopicos = [];
      json['quizTopico'].forEach((v) {
        quizTopicos!.add(new QuizTopico.fromJson(v));
      });
    }
    recomendacoes = json['recomendacoes'];
    qtdperguntas = json['qtdperguntas'];
    if (json['quizPerguntas'] != null) {
      quizPerguntas =[];
      json['quizPerguntas'].forEach((v) {
        quizPerguntas!.add(new QuizPerguntas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.titulo;
    if (this.quizTopicos != null) {
      data['quizTopico'] = this.quizTopicos!.map((v) => v.toJson()).toList();
    }
    data['recomendacoes'] = this.recomendacoes;
    data['qtdperguntas'] = this.qtdperguntas;
    if (this.quizPerguntas != null) {
      data['quizPerguntas'] =
          this.quizPerguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizTopico {
  String? idTopico;

  QuizTopico({this.idTopico});

  QuizTopico.fromJson(Map<String, dynamic> json) {
    idTopico = json['idTopico'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTopico'] = this.idTopico;
    return data;
  }
}

class QuizPerguntas {
  String? id;

  QuizPerguntas({this.id});

  QuizPerguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Desafios {
  String? id;
  String? idQuiz;
  bool? finalizado;
  DateTime? data;
  String? email;
  int? acertos;
  int? tempo;
  List<DesafioPerguntas>? desafioPerguntas;

  Desafios(
      {this.id,
      this.idQuiz,
      this.finalizado,
      this.data,
      this.email,
      this.acertos,
      this.tempo,
      this.desafioPerguntas});

  Desafios.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idQuiz = json['idQuiz'];
    finalizado = json['finalizado'];
    data = json['data'];
    email = json['email'];
    acertos = json['acertos'];
    tempo = json['tempo'];
    if (json['desafioPerguntas'] != null) {
      desafioPerguntas = [];
      json['desafioPerguntas'].forEach((v) {
        desafioPerguntas!.add(new DesafioPerguntas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idQuiz'] = this.idQuiz;
    data['finalizado'] = this.finalizado;
    data['data'] = this.data;
    data['email'] = this.email;
    data['acertos'] = this.acertos;
    data['tempo'] = this.tempo;
    if (this.desafioPerguntas != null) {
      data['desafioPerguntas'] =
          this.desafioPerguntas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DesafioPerguntas {
  String? id;
  bool? acertou;

  DesafioPerguntas({this.id, this.acertou});

  DesafioPerguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acertou = json['acertou'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acertou'] = this.acertou;
    return data;
  }
}

class BasePerguntas {
  String? id;
  String? idTopico;
  String? pergunta;
  List<PerguntasRespostas>? perguntasRespostas;

  BasePerguntas(
      {this.id, this.idTopico, this.pergunta, this.perguntasRespostas});

  BasePerguntas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idTopico = json['idTopico'];
    pergunta = json['pergunta'];
    if (json['perguntasRespostas'] != null) {
      perguntasRespostas = [];
      json['perguntasRespostas'].forEach((v) {
        perguntasRespostas!.add(new PerguntasRespostas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idTopico'] = this.idTopico;
    data['pergunta'] = this.pergunta;
    if (this.perguntasRespostas != null) {
      data['perguntasRespostas'] =
          this.perguntasRespostas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PerguntasRespostas {
  String? id;
  int? sequencia;
  bool? respostacerta;
  String? respostatexto;

  PerguntasRespostas(
      {this.id, this.sequencia, this.respostacerta, this.respostatexto});

  PerguntasRespostas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequencia = json['sequencia'];
    respostacerta = json['respostacerta'];
    respostatexto = json['respostatexto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequencia'] = this.sequencia;
    data['respostacerta'] = this.respostacerta;
    data['respostatexto'] = this.respostatexto;
    return data;
  }
}
