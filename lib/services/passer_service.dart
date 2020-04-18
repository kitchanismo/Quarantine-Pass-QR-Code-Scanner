import 'package:flutter/material.dart';
import 'package:qr_checker/models/passer.dart';

class PasserService extends ChangeNotifier {
  List<Passer> _passers = [
    Passer(code: 'shdjfhdj', name: 'vampiping', address: 'sdsd'),
    Passer(code: 'shdfgfhdj', name: 'kitchan2', address: 'sdsd'),
    Passer(code: 'hhjjhdjfhdj', name: 'kitcha3n', address: 'sdsd'),
    Passer(code: 'shdjerfhdj', name: 'kitchan4', address: 'sdsd'),
    Passer(code: 'shdjfhdj', name: 'kitchan', address: 'sdsd'),
    Passer(code: 'shdfgfhdj', name: 'kitchan2', address: 'sdsd'),
    Passer(code: 'hhjjhdjfhdj', name: 'kitcha3n', address: 'sdsd'),
    Passer(code: 'shdjfhdj', name: 'kitchan4', address: 'sdsd'),
    Passer(code: 'shdjfhdj', name: 'kitchan', address: 'sdsd'),
    Passer(code: 'shdfgfhdj', name: 'kitchan2', address: 'sdsd'),
    Passer(code: 'hhjjhdjfhdj', name: 'kitcha3n', address: 'sdsd'),
    Passer(code: 'shdjerfhdj', name: 'kitchan4', address: 'sdsd'),
    Passer(code: 'shdttjfhdj', name: 'kitcha5n', address: 'sdsd')
  ];

  get passers {
    return _passers;
  }

  set passers(List<Passer> passers) {
    _passers.reversed;
    notifyListeners();
  }

  void add(Passer passer) {
    passers.add(passer);
    notifyListeners();
  }
}
