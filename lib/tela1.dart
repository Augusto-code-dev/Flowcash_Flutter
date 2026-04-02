import 'package:flutter/material.dart';

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
      home: const Tela1(), // Tela inicial
    );
  }
}

// Tela principal (Dashboard)
class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  final double salario = 1400.0;
  final double saldoAtual = 1380.0;

  final List<Map<String, String>> gastos = const [
    {"valor": "R\$10,00", "motivo": "Comida", "dia": "Segunda"},
    {"valor": "R\$50,00", "motivo": "Transporte", "dia": "Terça"},
    {"valor": "R\$30,00", "motivo": "Compras", "dia": "Quarta"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de Gastos"),
        backgroundColor: Colors.green,
        actions: [
          // Botão para abrir o chat
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Salário: R\$${salario.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18)),
            Text("Saldo Atual: R\$${saldoAtual.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text("Gastos Recentes",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...gastos.map((gasto) => ListTile(
                  leading: const Icon(Icons.money),
                  title: Text("${gasto['motivo']} - ${gasto['valor']}"),
                  subtitle: Text("Dia: ${gasto['dia']}"),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aqui você pode abrir uma tela de cadastro de gasto
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Tela de Chat
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, String>> mensagens = [
    {"remetente": "bot", "texto": "Olá! Eu sou seu assistente FlowCash."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlowCash - Chatbot"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: mensagens.length,
              itemBuilder: (context, index) {
                final msg = mensagens[index];
                final isUser = msg["remetente"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[200] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg["texto"] ?? ""),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Digite sua mensagem...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        mensagens.add({
                          "remetente": "user",
                          "texto": _controller.text,
                        });
                      });
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
