import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    try {
      return _auth.currentUser!;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> handleRegistration(
      String email, String password, String username) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser?.updateDisplayName(username);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      //if (e.code == 'weak-password') {
      //  print('The password provided is too weak.');
      //} else
      if (e.code == 'email-already-in-use') {
        throw ArgumentError('The account already exists for that email.');
      }
      throw ArgumentError(
          'Something went wrong please try again later. ${e.toString()}');
    } catch (e) {
      //rethrow;
      throw ArgumentError(
          'Something went wrong please try again later. ${e.toString()}');
    }
  }

  Future<User> handleSignInEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ArgumentError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ArgumentError('Wrong password provided for that user.');
      }
      throw ArgumentError(
          'Something went wrong please try again later. ${e.toString()}');
    } catch (e) {
      throw ArgumentError(
          'Something went wrong please try again later. ${e.toString()}');
    }
  }

  void handleSignOut() {
    _auth.signOut();
  }
}
