import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:twitter_api/firebase_options.dart';
import 'package:twitter_api/presentation/api/feed_screen.dart';
import 'package:twitter_api/services/flutter_fire_auth.dart';
import 'presentation/api/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = FlutterFireAuth(context).getLoggerUser();

    return MaterialApp(
      title: 'Twitter API',
      theme: ThemeData(
        colorScheme: defaultColorScheme,
        primarySwatch: Colors.blue,
      ),
      home: user != null ? FeedPage(user: user) : const LoginPage(),
    );
  }
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color(0xffBB86FC),
  secondary: Color(0xff03DAC6),
  surface: Color(0xff181818),
  background: Color(0xff121212),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.dark,
);
