import 'package:qr_checker/models/scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanService {
  final collection = Firestore.instance.collection('scans');

  Scan mapToScan(DocumentSnapshot doc) {
    return Scan(
        id: doc.documentID,
        code: doc['code'] ?? '',
        name: doc['name'] ?? '',
        scanAt: doc['scanAt']?.toDate() ?? null,
        address: doc['address'] ?? '');
  }

  Stream<List<Scan>> fetchScans() {
    return collection
        .orderBy('scanAt', descending: true)
        .limit(10)
        .snapshots()
        .map((list) => list.documents.map(mapToScan).toList());
  }

  Future<bool> add(Scan scan) async {
    try {
      await collection.document().setData({
        'code': scan.code,
        'name': scan.name,
        'address': scan.address,
        'scanAt': DateTime.now()
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
