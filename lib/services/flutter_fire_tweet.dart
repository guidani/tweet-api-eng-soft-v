import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/domain/entities/user_data.dart';

class FlutterFireTweet {
  FlutterFireTweet(this._context);
  late final BuildContext _context;

  final CollectionReference _tweets =
      FirebaseFirestore.instance.collection('tweets');

  final TextEditingController _contentController = TextEditingController();

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _contentController.text = documentSnapshot['content'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: _context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Tweet'),
                  maxLength: 280,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Atualizar Tweet'),
                  onPressed: () async {
                    final String content = _contentController.text;
                    if (content != null) {
                      await _tweets
                          .doc(documentSnapshot!.id)
                          .update({"content": content});
                      _contentController.text = '';
                      Navigator.of(_context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: _context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Tweet'),
                  maxLength: 280,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Postar'),
                  onPressed: () async {
                    final String content = _contentController.text;
                    if (content != null) {
                      await _tweets.add({"content": content});
                      _contentController.text = '';
                      Navigator.of(_context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> delete(String productId) async {
    await _tweets.doc(productId).delete();

    ScaffoldMessenger.of(_context)
        .showSnackBar(const SnackBar(content: Text('Tweet Deletado')));
  }
  // Future<UserData?> createUserWithEmailAndPassword(
  //     String name, String arroba, String email, String password) async {
  //   try {
  //     final credential = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     await credential.user?.updateDisplayName(name);

  //     return UserData(
  //       name: name,
  //       email: email,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.message ?? 'Error Desconhecido'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  // Future<UserData?> signInWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     final credential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     return UserData(
  //       name: credential.user?.displayName,
  //       email: credential.user?.email,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.message ?? 'Error Desconhecido'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(_context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  // UserData? getLoggerUser() {
  //   final user = _auth.currentUser;
  //   if (user == null) {
  //     return null;
  //   }

  //   return UserData(
  //     name: user.displayName,
  //     email: user.email,
  //   );
  // }

  // Future<void> singOut() async {
  //   await _auth.signOut();
  // }
}
