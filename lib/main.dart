import 'package:flutter/material.dart';
import 'package:jalshakti/auth/login.dart';
import 'package:jalshakti/auth/profile.dart';
import 'package:jalshakti/home.dart';
import 'package:jalshakti/notif.dart';
import 'package:jalshakti/rakshak.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth App',
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        'notif': (context) => Notifpage(),
        '/chat': (context) => RakshakChatbotPage(),
      },
    );
  }
}
