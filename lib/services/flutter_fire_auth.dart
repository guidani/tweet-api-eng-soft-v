import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/domain/entities/user_data.dart';

class FlutterFireAuth {
  FlutterFireAuth(this._context);
  late final BuildContext _context;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserData?> createUserWithEmailAndPassword(
      String name, String arroba, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await credential.user?.updateDisplayName(name);

      return UserData(
        name: name,
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Error Desconhecido'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<UserData?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return UserData(
        name: credential.user?.displayName,
        email: credential.user?.email,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Error Desconhecido'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  UserData? getLoggerUser() {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    return UserData(
      name: user.displayName,
      email: user.email,
    );
  }

  Future<void> singOut() async {
    await _auth.signOut();
  }
}
