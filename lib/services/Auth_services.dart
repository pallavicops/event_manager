import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User registered successfully: ${userCredential.user!.uid}");
      return userCredential.user; // Return the registered user
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null; // Return null in case of FirebaseAuthException
    } catch (e) {
      print(e);
      return null; // Return null in case of other errors
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user; // Returns the signed-in user
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception(e.message ?? 'An unexpected error occurred.');
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
