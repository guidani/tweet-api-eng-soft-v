import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/domain/entities/user_data.dart';
import 'package:twitter_api/presentation/api/login_screen.dart';
import 'package:twitter_api/services/flutter_fire_auth.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key, required this.user}) : super(key: key);

  final UserData user;

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      await FlutterFireAuth(context).singOut();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false);
    }

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Feed'),
      actions: [
        IconButton(
            onPressed: () {
              _signOut();
            },
            icon: const Icon(Icons.exit_to_app))
      ],
    )));
  }
}
