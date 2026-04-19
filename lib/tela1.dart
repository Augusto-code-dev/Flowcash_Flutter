import 'package:flutter/material.dart';
import 'models/gasto.dart';
import 'db/database_helper.dart';



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
      home: const Tela1(),
    );
  }
}

class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  final double salario = 1400.0;
  double saldoAtual = 1380.0;

  List<Gasto> gastos = [];

  @override
  void initState() {
    super.initState();
    _carregarGastos();
  }

  Future<void> _carregarGastos() async {
    final lista = await DatabaseHelper.getGastos();
    setState(() {
      gastos = lista;
    });
  }

  void _adicionarGasto() {
  final valorController = TextEditingController();
  final motivoController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Novo Gasto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            TextField(
              controller: motivoController,
              decoration: const InputDecoration(labelText: "Motivo"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              if (valorController.text.isNotEmpty &&
                  motivoController.text.isNotEmpty) {
                final valor = double.tryParse(valorController.text) ?? 0.0;
                final novoGasto = Gasto(
                  valor: valor,
                  motivo: motivoController.text,
                  dia: "Hoje",
                );
                await DatabaseHelper.insertGasto(novoGasto);
                saldoAtual -= valor;

                if (!mounted) return; // ✅ evita erro de contexto
                Navigator.pop(context);
                _carregarGastos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Gasto adicionado!")),
                );
              }
            },
            child: const Text("Adicionar"),
          ),
        ],
      );
    },
  );
}


  void _editarGasto(Gasto gasto) {
  final valorController = TextEditingController(text: gasto.valor.toString());
  final motivoController = TextEditingController(text: gasto.motivo);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Editar Gasto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
            ),
            TextField(
              controller: motivoController,
              decoration: const InputDecoration(labelText: "Motivo"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              final valor = double.tryParse(valorController.text) ?? 0.0;
              final gastoAtualizado = Gasto(
                id: gasto.id,
                valor: valor,
                motivo: motivoController.text,
                dia: "Hoje",
              );
              await DatabaseHelper.updateGasto(gastoAtualizado);

              if (!mounted) return; // ✅ evita erro de contexto
              Navigator.pop(context);
              _carregarGastos();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gasto atualizado!")),
              );
            },
            child: const Text("Salvar"),
          ),
        ],
      );
    },
  );
}


  void _excluirGasto(int id) async {
  await DatabaseHelper.deleteGasto(id);

  if (!mounted) return; // ✅ evita erro de contexto
  _carregarGastos();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Gasto excluído!")),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle de Gastos"),
        backgroundColor: Colors.green,
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
            Expanded(
              child: ListView.builder(
                itemCount: gastos.length,
                itemBuilder: (context, index) {
                  final gasto = gastos[index];
                  return ListTile(
                    leading: const Icon(Icons.money),
                    title: Text("${gasto.motivo} - R\$${gasto.valor.toStringAsFixed(2)}"),
                    subtitle: Text("Dia: ${gasto.dia}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editarGasto(gasto),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _excluirGasto(gasto.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: _adicionarGasto,
  backgroundColor: Colors.green,
  child: const Icon(Icons.add), // ✅ agora o child está por último
),

    );
  }
}
