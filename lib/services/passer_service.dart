import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_checker/models/passer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PasserService extends ChangeNotifier {
  final collection = Firestore.instance.collection('passers');

  List<Passer> _passers = [
    Passer(
        code: 'shdjfhdj',
        name: 'sample csscc',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdfgfhdj',
        name: 'kitchan shusdh',
        address: 'somewhere',
        isApproved: false),
    Passer(
        code: 'hhjjhdjfhdj',
        name: 'kitcha3n uscs',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdjerfhdj',
        name: 'kitchan4 shcsuc',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdjfhdj',
        name: 'kitchan',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdfgfhdj',
        name: 'kitchan2',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'hhjjhdjfhdj',
        name: 'kitcha3n',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdjfhdj',
        name: 'kitchan4',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdjfhdj',
        name: 'kitchan',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdfgfhdj',
        name: 'kitchan2',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'hhjjhdjfhdj',
        name: 'kitcha3n',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdjerfhdj',
        name: 'kitchan4',
        address: 'somewhere',
        isApproved: true),
    Passer(
        code: 'shdttjfhdj',
        name: 'kitcha5n',
        address: 'somewhere',
        isApproved: true),
  ];

  // get passers {
  //   return _passers;
  // }

  Passer mapToPasser(DocumentSnapshot doc) {
    return Passer(
        id: doc.documentID,
        isApproved: doc['isApproved'],
        code: doc['code'],
        name: doc['name'],
        address: doc['address']);
  }

  Stream<List<Passer>> fetchPassers() {
    var snaps = collection.snapshots();
    return snaps.map((list) => list.documents.map(mapToPasser).toList());
  }

  set passers(List<Passer> passers) {
    _passers.reversed;
    notifyListeners();
  }

  void sndksd() {
    collection.getDocuments();
  }

  Future add(Passer passer) async {
    try {
      await collection.document().setData({
        'isApproved': passer.isApproved,
        'code': passer.code,
        'name': passer.name,
        'address': passer.address
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future update(Passer passer) async {
    try {
      await collection.document(passer.id).updateData({
        'uid': passer.id,
        'code': passer.code,
        'name': passer.name,
        'address': passer.address
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
