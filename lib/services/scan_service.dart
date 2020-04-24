import 'package:qr_checker/models/scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanService {
  final collection = Firestore.instance.collection('scans');

  Scan mapToScan(DocumentSnapshot doc) {
    return Scan(
        id: doc.documentID,
        code: doc['code'] ?? '',
        name: doc['name'] ?? '',
        isAuthorized: doc['isAuthorized'] ?? '',
        scanAt: doc['scanAt']?.toDate() ?? null,
        address: doc['address'] ?? '');
  }

  Stream<QuerySnapshot> snaps() => collection.snapshots();

  Stream<List<Scan>> fetchScans() {
    return snaps().map((list) => list.documents.map(mapToScan).toList());
  }


}
