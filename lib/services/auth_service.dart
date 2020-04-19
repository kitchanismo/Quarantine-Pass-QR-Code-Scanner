import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_checker/models/user.dart';
import 'package:tuple/tuple.dart';

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

  Future<Tuple2<String, bool>> signIn(User user) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      return Tuple2<String, bool>('Logged In!', true);
    } catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return Tuple2<String, bool>('Invalid Email or Password!', false);
      }
      return Tuple2<String, bool>(e.code, false);
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
