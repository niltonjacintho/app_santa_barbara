class ComentariosModel {
  String? usuario;
  DateTime? data;
  String? texto;

  ComentariosModel({this.usuario, this.data, this.texto});

  ComentariosModel.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    data = json['data'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuario'] = this.usuario;
    data['data'] = this.data;
    data['texto'] = this.texto;
    return data;
  }
}
