import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project2/main_page.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instanceFor(app: secondaryApp);
  // late final GoogleSignIn _googleSignIn;

  void regUser(String email) {
    String uid = FirebaseAuth.instanceFor(app: secondaryApp).currentUser!.uid;

    db.collection('users').doc(uid).collection('userInfo').add({
      "name": 'name',
      "sum": 0,
      "email": email,
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instanceFor(app: secondaryApp)
          .createUserWithEmailAndPassword(email: email, password: password);

      regUser(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instanceFor(app: secondaryApp)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instanceFor(app: secondaryApp)
          .signInWithCredential(credential);

      regUser(googleUser!.email);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      // await _googleSignIn.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
