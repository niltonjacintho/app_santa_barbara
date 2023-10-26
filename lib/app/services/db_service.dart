// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DbService {
  //dispose will be called automatically
  void dispose() {}

  Future<String> cleanFolder(String pasta) async {
    var db = FirebaseFirestore.instance;
    int batCount = 0;
    var batch = db.batch();
    await db.collection('$pasta').get().then((querySnapshot) async {
      batCount = 0;
      querySnapshot.docs.forEach((doc) async {
        batch.delete(doc.reference);
        batCount++;
        if (batCount > 400) {
          await batch.commit();
          batCount = 1;
        }
      });
      await batch.commit();
    }).then((dados) {
      print('fechou');
    });
    return '';
  }

// ainda vou tentar
  Future<String> getListObject(String pasta) async {
    var db = FirebaseFirestore.instance;
    await db.collection('$pasta').get().then((querySnapshot) {
      var batch = db.batch();
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
      batch.commit();
    }).then((dados) {
      print('fechou');
    });
    return '';
  }

  Future<String> salvarObjeto(objeto, String pasta) async {
    var uuid = Uuid();
    if (objeto.id == null || objeto.id == '') {
      objeto.id = uuid.v4();
    }
    DocumentReference reference =
        FirebaseFirestore.instance.doc("$pasta/${objeto.id}");
    await reference
        .set(objeto.toJson())
        .then((result) => {})
        .catchError((err) => print('ERROR $err'));

    return objeto.id;
  }
}
