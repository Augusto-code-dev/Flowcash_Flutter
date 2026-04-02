import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // Lista de mensagens (apenas exemplo estático)
  final List<Map<String, String>> mensagens = [
    {"remetente": "bot", "texto": "Olá! Eu sou seu assistente FlowCash."},
    {"remetente": "user", "texto": "Oi, quero saber meus gastos."},
    {"remetente": "bot", "texto": "Claro! Você gastou R\$90 esta semana."},
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
          // Área de mensagens
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

          // Campo de texto + botão enviar
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
