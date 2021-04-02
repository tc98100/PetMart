import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String feedback = "";

  // `userState`
  //
  // The state listener for user authentication
  Stream<User> get userState {
    return _firebaseAuth.authStateChanges();
  }

  // `signUp`
  //
  // Signup a user.
  Future signUp(String username, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      User user = _firebaseAuth.currentUser;

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        feedback = 'The email address is invalid';
        print('The email address is invalid');
      } else if (e.code == 'email-already-in-use') {
        feedback = 'The account already exists for this email address.';
        print('The account already exists for this email address.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // `signIn`
  //
  // Sign in a user
  Future signIn(String username, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      User user = _firebaseAuth.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        feedback = 'The email address is invalid';
        print('The email address is invalid');
      } else if (e.code == 'user-not-found') {
        feedback = 'No user found for that email.';
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        feedback = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // `signOut`
  //
  // Sign out a user
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // `giveFeedback`
  //
  // Returns the validation messages
  String giveFeedback() {
    return feedback;
  }
}
