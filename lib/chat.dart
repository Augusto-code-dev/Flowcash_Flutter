import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String token; // token vindo do login
  const ChatScreen({super.key, required this.token});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // Lista de mensagens
  final List<Map<String, String>> mensagens = [];

  Future<String> chamarApiIA(String pergunta) async {
    try {
      // Exemplo de chamada a uma API de chatbot
      final response = await http.post(
        Uri.parse("https://mobile-ios-ia.zani0x03.eti.br/api/ai/chat"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
        body: jsonEncode({"prompt": pergunta}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["resposta"] ?? "Não entendi sua pergunta.";
      } else {
        return "Erro na API (${response.statusCode}).";
      }
    } catch (e) {
      return "Erro de conexão: $e";
    }
  }

  void _enviarMensagem() async {
    if (_controller.text.isEmpty) return;

    final texto = _controller.text;
    setState(() {
      mensagens.add({"remetente": "user", "texto": texto});
    });
    _controller.clear();

    // Chama API de IA
    final resposta = await chamarApiIA(texto);

    setState(() {
      mensagens.add({"remetente": "bot", "texto": resposta});
    });
  }

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
                  onPressed: _enviarMensagem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
