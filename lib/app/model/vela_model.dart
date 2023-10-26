class VelaModel {
  String? id;
  DateTime? data;
  String? intensao;
  int? minutosrestantes;
  String? destinatario;
  String? solicitanteemail;
  String? solicitantenome;
  String? texto;
  DateTime? dataInclusao;
  DateTime? dataAlteracao;

  VelaModel(
      {this.id,
      this.data,
      this.intensao,
      this.minutosrestantes,
      this.destinatario,
      this.solicitanteemail,
      this.solicitantenome,
      this.texto,
      this.dataInclusao,
      this.dataAlteracao});

  VelaModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    data = json['data'];
    intensao = json['intensao'];
    minutosrestantes = json['minutosrestantes'];
    destinatario = json['destinatario'];
    solicitanteemail = json['solicitanteemail'];
    solicitantenome = json['solicitantenome'];
    texto = json['texto'];
    dataInclusao = json['dataInclusao'];
    dataInclusao = json['dataAlteracao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['intensao'] = this.intensao;
    data['minutosrestantes'] = this.minutosrestantes;
    data['destinatario'] = this.destinatario;
    data['solicitanteemail'] = this.solicitanteemail;
    data['solicitantenome'] = this.solicitantenome;
    data['texto'] = this.texto;
    data['dataInclusao'] = this.dataInclusao;
    data['dataAlteracao'] = this.dataAlteracao;
    return data;
  }
}
