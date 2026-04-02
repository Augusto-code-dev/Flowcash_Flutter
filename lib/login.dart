import 'package:flowcash/tela1.dart';
import 'package:flutter/material.dart';

// Ponto de entrada do app
void main() {
  runApp(const MyApp());
}

// Widget raiz
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowCash',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginScreen(),
       routes: 
       {
          "/dashboard": (context) => const Tela1(),
        },

    );
  }
}

// Tela de Login
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 64, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              "FlowCash",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: "E-mail ou Usuário",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Esqueceu a senha?",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
               onPressed: () 
               {
                  Navigator.pushReplacementNamed(context, "/dashboard");
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Entrar",  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Text("Não tem uma conta? Cadastrar-se"),
            ),
          ],
        ),
      ),
    );
  }
}