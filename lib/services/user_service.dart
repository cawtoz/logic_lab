import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserData() async {
    try {
      final User? user = AuthService().auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'nivel': 1,
        });
      } else {
        throw Exception("Usuario no autenticado.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> getUserLevel() async {
    try {
      final User? user = AuthService().auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return doc['nivel'] as int?;
        }
        return null;
      } else {
        throw Exception("Usuario no autenticado.");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserLevel(int newLevel) async {
    try {
      final User? user = AuthService().auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'nivel': newLevel,
        });
      } else {
        throw Exception("Usuario no autenticado.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
