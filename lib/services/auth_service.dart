import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/auth_response_dto.dart';

abstract class IAuthService {
  Future<AuthResponseDto> login(String username, String password);
}

class AuthService implements IAuthService {
  final String baseUrl = "https://mobile-ios-login.zani0x03.eti.br/api/auth/login";
  final String sistemaId = "55688c9f-6bd6-4c1c-9329-7138f3012f56";

  @override
  Future<AuthResponseDto> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "password": password,
          "sistemaId": sistemaId,
        }),
      );

      if (response.statusCode == 200) {
        return AuthResponseDto.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Credenciais inválidas ou erro no servidor (${response.statusCode}).");
      }
    } catch (e) {
      throw Exception("Erro ao conectar na API: $e");
    }
  }
}
