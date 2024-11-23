import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logic_lab/services/user_service.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final UserService userService = UserService();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential.user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        await userService.createUserData();
      }
      
      return userCredential.user;

    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        await userService.createUserData();
      }
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      rethrow;
    }
  }

}
