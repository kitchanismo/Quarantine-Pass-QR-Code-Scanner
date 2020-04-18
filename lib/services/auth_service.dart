import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_checker/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User mapToUser(FirebaseUser user) {
    return user != null ? User(id: user.uid, email: user.email) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(mapToUser);
  }

  Future signUp(User user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signIn(User user) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
