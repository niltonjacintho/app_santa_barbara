class QuizRankModel {
  String? id;
  DateTime? data;
  String? email;
  String? nome;
  int? acertos = 0;
  int? erros;
  double? pontos;
  String? topico;

  QuizRankModel(
      {String id='',
      DateTime? data,
      String email='',
      String nome='',
      int acertos = 0,
      int erros = 0,
      double pontos = 0,
      String topico=''}) {
    this.id = id;
    this.data = data;
    this.email = email;
    this.nome = nome;
    this.acertos = acertos;
    this.erros = erros;
    this.pontos = pontos;
    this.topico = topico;
  }

  QuizRankModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topico = json['topico'];
    data = json['data'];
    email = json['email'];
    nome = json['nome'];
    acertos = json['acertos'];
    erros = json['erros'];
    pontos = json['pontos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topico'] = this.topico;
    data['data'] = this.data;
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['acertos'] = this.acertos;
    data['erros'] = this.erros;
    data['pontos'] = this.pontos;
    return data;
  }
}
