import 'package:flutter/material.dart';
import 'login.dart';
import 'tela1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowCash',
      theme: ThemeData(primarySwatch: Colors.green),
      // 🚀 Começa pelo Login
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
       // O LoginScreen vai navegar para Tela1(token: result.accessToken)
      },
    );
  }
}
