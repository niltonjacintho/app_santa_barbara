import 'package:app2021/app/model/comentarios_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtigosModel {
  String documentID;
  bool ativo;
  String categoria;
  String titulo;
  String subtitulo;
  String texto;
  DateTime dataCriacao;
  String autorAutor;
  String evento;
  String image;
  String video;
  String audio;
  DateTime dataValidade;
  int visualizacoes;
  List<ComentariosModel> comentarios;

  ArtigosModel(
      {this.documentID,
      this.ativo,
      this.categoria,
      this.titulo,
      this.subtitulo,
      this.texto,
      this.dataCriacao,
      this.autorAutor,
      this.evento,
      this.image,
      this.video,
      this.audio,
      this.dataValidade,
      this.visualizacoes,
      this.comentarios});

  ArtigosModel.fromJson(Map<String, dynamic> json) {
    documentID = json['documentID'];
    ativo = json['ativo'];
    categoria = json['categoria'];
    titulo = json['titulo'];
    subtitulo = json['subtitulo'];
    texto = json['texto'];
    dataCriacao = json['data_criacao'];
    autorAutor = json['autor_autor'];
    evento = json['evento'];
    image = json['image'];
    video = json['video'];
    audio = json['audio'];
    dataValidade = json['data_validade'];
    visualizacoes = json['visualizacoes'];
    if (json['comentarios'] != null) {
      comentarios = [];
      json['comentarios'].forEach((v) {
        comentarios.add(new ComentariosModel.fromJson(v));
      });
    }
  }

  ArtigosModel.fromfirestoresnapshot(DocumentSnapshot snap)
      : documentID = snap.id,
        ativo = snap.get('ativo'),
        categoria = snap.get('categoria'),
        titulo = snap.get('titulo'),
        subtitulo = snap.get('subtitulo'),
        texto = snap.get('texto'),
        dataCriacao = snap.get('dataCriacao'),
        autorAutor = snap.get('autorAutor'),
        evento = snap.get('evento'),
        image = snap.get('image'),
        video = snap.get('video'),
        audio = snap.get('audio'),
        dataValidade = snap.get('dataValidade'),
        visualizacoes = snap.get('visualizacoes'),
        comentarios = snap.get('comentarios');

  toJson2() {
    return {
      'documentID': documentID,
      'ativo': ativo,
      'categoria': categoria,
      'titulo': titulo,
      'subtitulo': subtitulo,
      'texto': texto,
      'dataCriacao': dataCriacao,
      'autorAutor': autorAutor,
      'evento': evento,
      'image': image,
      'video': video,
      'audio': audio,
      'dataValidade': dataValidade,
      'visualizacoes': visualizacoes,
      'comentarios': comentarios
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ativo'] = this.ativo;
    data['categoria'] = this.categoria;
    data['titulo'] = this.titulo;
    data['subtitulo'] = this.subtitulo;
    data['texto'] = this.texto;
    data['data_criacao'] = this.dataCriacao;
    data['autor_autor'] = this.autorAutor;
    data['evento'] = this.evento;
    data['image'] = this.image;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['data_validade'] = this.dataValidade;
    data['visualizacoes'] = this.visualizacoes;
    if (this.comentarios != null) {
      data['comentarios'] = this.comentarios.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
