import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User currentUser = auth.currentUser!;
                    final uid = currentUser.uid;

                    if (content != null) {
                      await _tweets.add({
                        "content": content,
                        "qtd_likes": 0,
                        "ref_id": null,
                        "user_id": uid,
                        "comments": null,
                        "qtd_retweets": 0
                      });
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
}
