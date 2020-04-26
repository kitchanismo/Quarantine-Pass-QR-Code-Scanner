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

  Future<bool> signUp(User user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Tuple2<String, bool>> signIn(User user) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      return Tuple2<String, bool>('Logged In!', true);
    } catch (e) {
      print(e.toString());
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return Tuple2<String, bool>('Invalid Email or Password!', false);
      }
      if (e.code == 'ERROR_INVALID_EMAIL') {
        return Tuple2<String, bool>('Email is in invalid format!', false);
      }
      if (e.code == 'ERROR_TOO_MANY_REQUESTS') {
        return Tuple2<String, bool>(
            'Too many unsuccessful login attempts.!', false);
      }

      return Tuple2<String, bool>('Network Error', false);
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
