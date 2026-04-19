class Gasto {
  final int? id;
  final double valor;
  final String motivo;
  final String dia;

  Gasto({this.id, required this.valor, required this.motivo, required this.dia});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'motivo': motivo,
      'dia': dia,
    };
  }

  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      id: map['id'],
      valor: map['valor'],
      motivo: map['motivo'],
      dia: map['dia'],
    );
  }
}
