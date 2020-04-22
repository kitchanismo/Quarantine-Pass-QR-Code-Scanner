import 'dart:async';
import 'package:qr_checker/models/passer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasserService {
  final collection = Firestore.instance.collection('passers');

  Passer mapToPasser(DocumentSnapshot doc) {
    return Passer(
        id: doc.documentID,
        code: doc['code'] ?? '',
        name: doc['name'] ?? '',
        validity: doc['validity']?.toDate() ?? null,
        address: doc['address'] ?? '');
  }

  Stream<QuerySnapshot> snaps() => collection.snapshots();

  Stream<List<Passer>> fetchPassers() {
    return snaps().map((list) => list.documents.map(mapToPasser).toList());
  }

  Future<bool> add(Passer passer) async {
    try {
      await collection.document().setData({
        'code': passer.code,
        'name': passer.name,
        'address': passer.address,
        'validity': passer.validity
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future update(Passer passer) async {
    try {
      await collection.document(passer.id).updateData({
        'code': passer.code,
        'name': passer.name,
        'address': passer.address
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Passer> isCodeValid(String code) {
    return collection
        .where('code', isEqualTo: code)
        .getDocuments()
        .then((snaps) => snaps.documents.map(mapToPasser).toList().first)
        .catchError((err) => print(err));
  }
}
