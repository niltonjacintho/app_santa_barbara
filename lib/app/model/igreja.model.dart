class Igreja {
  String? id;
  String? nome;
  String? forania;
  String? nascimento;
  String? paroco;
  String? vigario;
  String? diacono;
  String? endereco;
  String? endereco2;
  String? telefones;
  double? lat;
  double? long;
  List<Capelas>? capelas;

  Igreja(
      {this.id,
      this.nome,
      this.forania,
      this.nascimento,
      this.paroco,
      this.vigario,
      this.diacono,
      this.endereco,
      this.endereco2,
      this.telefones,
      this.lat,
      this.long,
      this.capelas});

  Igreja.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    forania = json['forania'];
    nascimento = json['nascimento'];
    paroco = json['paroco'];
    vigario = json['vigario'];
    diacono = json['diacono'];
    endereco = json['endereco'];
    endereco2 = json['endereco2'];
    telefones = json['telefones'];
    lat = json['lat'];
    long = json['long'];
    if (json['capelas'] != null) {
      capelas = [];
      json['capelas'].forEach((v) {
        capelas!.add(new Capelas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['forania'] = this.forania;
    data['nascimento'] = this.nascimento;
    data['paroco'] = this.paroco;
    data['vigario'] = this.vigario;
    data['diacono'] = this.diacono;
    data['endereco'] = this.endereco;
    data['endereco2'] = this.endereco2;
    data['telefones'] = this.telefones;
    data['lat'] = this.lat;
    data['long'] = this.long;
    if (this.capelas != null) {
      data['capelas'] = this.capelas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Capelas {
  String? nome;
  String? endereco;
  String? endereco2;
  String? telefone;
  double? lat;
  double? long;

  Capelas(
      {this.nome,
      this.endereco,
      this.endereco2,
      this.telefone,
      this.lat,
      this.long});

  Capelas.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    endereco = json['endereco'];
    endereco2 = json['endereco2'];
    telefone = json['telefone'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['endereco'] = this.endereco;
    data['endereco2'] = this.endereco2;
    data['telefone'] = this.telefone;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
