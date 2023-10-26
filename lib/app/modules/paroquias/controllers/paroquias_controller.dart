import 'package:app2021/app/model/igreja.model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParoquiasController extends GetxController {
  // DocumentsController documentsController = Modular.get();
  final count = 0.obs;

  @override
  // ignore: must_call_super
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}

  void increment() => count.value++;

  List<Igreja> _lista = [];

  List<Igreja> lista = [];

  int totalParoquias = 0;

  int contParoquia = 0;

  RxString filtro = ''.obs;

  Igreja paroquiaAtiva = new Igreja();

  setFiltro(String value) {
    filtro.value = value;
  }

  setParoquiaAtiva(DocumentSnapshot doc) async {
    Igreja p;
    Capelas capela;
    p = new Igreja();
    p.capelas = [];
    try {
      p.id = doc.get('id');
      p.nome = doc.get('nome');
      p.forania = doc.get('forania');
      p.nascimento = doc.get('nascimento');
      p.paroco = doc.get('paroco');
      p.vigario = doc.get('vigario');
      p.diacono = doc.get('diacono');
      p.endereco = doc.get('endereco');
      p.endereco2 = doc.get('endereco2');
      p.telefones = doc.get('telefones');
      p.lat = doc.get('lat');
      p.long = doc.get('long');
      //   print('PAROQUIA ${p.nome}  ${p.id} $index');
      List c = doc.get('capelas');

      c.forEach((element) {
        capela = new Capelas();
        capela.nome = element['nome'];
        capela.endereco = element['endereco'];
        capela.endereco2 = element['.endereco2'];
        capela.telefone = element['telefone'];
        capela.lat = element['lat'];
        capela.long = element['long'];
        p.capelas!.add(capela);
      });
      paroquiaAtiva = p;
    } catch (e) {
      print('error');
      paroquiaAtiva = new Igreja();
    }
  }

  Future<List<Igreja>> getParoquias() async {
    var snap = FirebaseFirestore.instance
        .collection('paroquias')
        .orderBy("nome")
        .snapshots();
    lista = [];
    Igreja p;
    Capelas capela;
    await snap.forEach((field) async {
      field.docs.asMap().forEach((index, data) {
        p = new Igreja();
        p.capelas = [];
        try {
          p.id = data.get('id');
          p.nome = data.get('nome');
          p.forania = data.get('forania');
          p.nascimento = data.get('nascimento');
          p.paroco = data.get('paroco');
          p.vigario = data.get('vigario');
          p.diacono = data.get('diacono');
          p.endereco = data.get('endereco');
          p.endereco2 = data.get('endereco2');
          p.telefones = data.get('telefones');
          p.lat = data.get('lat');
          p.long = data.get('long');
          print('PAROQUIA ${p.nome}  ${p.id} $index');
          List c = data.get('capelas');

          c.forEach((element) {
            capela = new Capelas();
            capela.nome = element['nome'];
            capela.endereco = element['endereco'];
            capela.endereco2 = element['.endereco2'];
            capela.telefone = element['telefone'];
            capela.lat = element['lat'];
            capela.long = element['long'];
            p.capelas!.add(capela);
          });
          lista.add(p);
        } catch (e) {
          print('error');
        }
      });
    });
    // print(listaPastorais);
    return lista;
  }

  Future<QuerySnapshot> gerarListaParoquias() {
    Igreja igrejaObj;
    Future<QuerySnapshot> doc =
        FirebaseFirestore.instance.collection('paroquias').get();
    _lista = [];
    doc.then((d) => {
          d.docs.forEach((element) {
            igrejaObj = new Igreja();
            igrejaObj.endereco = element.get('endereco');
            igrejaObj.endereco2 = element.get('endereco2');
            igrejaObj.lat = element.get('lat');
            igrejaObj.long = element.get('long');
            igrejaObj.id = element.id;
            igrejaObj.diacono = element.get('diacono');
            igrejaObj.forania = element.get('forania');
            igrejaObj.nascimento = element.get('nascimento');
            igrejaObj.nome = element.get('nome');
            igrejaObj.paroco = element.get('paroco');
            igrejaObj.telefones = element.get('telefones');
            igrejaObj.vigario = element.get('vigario');
            igrejaObj.capelas = [];
            for (var item in element.get('capelas')) {
              Capelas c = new Capelas();
              c.endereco = item['endereco'];
              c.endereco2 = item['endereco2'];
              c.lat = item['lat'];
              c.long = item['long'];
              c.nome = item['nome'];
              c.telefone = item['telefone'];
              igrejaObj.capelas!.add(c);
            }
            // igrejaObj.capelas = element
            //     .get('capelas']
            //     .map((s) => s as Capelas)
            //     .toList(); //element.get('capelas'] as List<Capelas>;
            _lista.add(igrejaObj);
          })
          // igrejaObj.id = d.metadata;
        });
    return doc;
  }

  atualizarLocation() async {
    await gerarListaParoquias();
    totalParoquias = _lista.length;
    Igreja element;
    List<Location> placemark;
    for (int i = 0; i <= _lista.length - 1; i++) {
      element = lista[i];
      try {
        placemark = await locationFromAddress(element.endereco!);
        element.lat = placemark[0].latitude;
        element.long = placemark[0].longitude;
        lista[i] = element;
        contParoquia = i;
      } catch (e) {
        print('ERRO NO ENDEREÇO ${element.endereco}');
      }

      FirebaseFirestore.instance
          .collection("paroquias")
          .doc(element.id)
          .update({"lat": element.lat, "long": element.long, "id": element.id});
    }
  }

  getLocalizacaoByAdress(String endereco) {}

  updateAllParoquias() async {
    await gerarListaParoquias();
    _lista.forEach((element) async {
      // List<Placemark> placemark =
      // await Geolocator().placemarkFromAddress(element.endereco);
    });
  }
}
