import 'package:flutter/material.dart';

class OpcoesMenu {
  String? image;
  String? titulo;
  String? subtitulo;
  String? destino;
  int? grupo;
  int? ordem;
  Color? cardColor;
  Color? textColor;
  OpcoesMenu({
    this.image,
    this.titulo,
    this.ordem,
    this.destino,
    this.grupo,
    this.subtitulo,
    this.cardColor,
    this.textColor,
  });

  OpcoesMenu.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    titulo = json['titulo'];
    destino = json['destino'];
    grupo = json['grupo'];
    ordem = json['ordem'];
    subtitulo = json['subtitulo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['titulo'] = this.titulo;
    data['destino'] = this.destino;
    data['grupo'] = this.grupo;
    data['ordem'] = this.ordem;
    data['subtitulo'] = this.subtitulo;
    return data;
  }
}
