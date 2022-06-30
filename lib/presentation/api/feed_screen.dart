import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/domain/entities/user_data.dart';
import 'package:twitter_api/presentation/api/login_screen.dart';
import 'package:twitter_api/services/flutter_fire_auth.dart';
import 'package:twitter_api/services/flutter_fire_tweet.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, required this.user}) : super(key: key);

  final UserData user;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final CollectionReference _tweets =
      FirebaseFirestore.instance.collection('tweets');

  void _signOut() async {
    await FlutterFireAuth(context).singOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                _signOut();
              },
              icon: const Icon(Icons.logout))
        ]),
        body: StreamBuilder(
          stream: _tweets.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['content']),
                      subtitle: Text(documentSnapshot['qtd_likes'].toString()),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(children: [
                          IconButton(
                              onPressed: () async =>
                                  await FlutterFireTweet(context)
                                      .update(documentSnapshot),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async =>
                                  await FlutterFireTweet(context)
                                      .delete(documentSnapshot.id)),
                          IconButton(
                              icon: const Icon(CupertinoIcons.heart_solid),
                              onPressed: () {})
                        ]),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await FlutterFireTweet(context).create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
