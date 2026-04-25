import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class IAuthService {
  Future<Map<String, dynamic>> login(String username, String password);
}

class AuthService implements IAuthService {
  final String baseUrl = "http://10.0.2.2:8085/api/auth/login";

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Falha no login: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Erro de conexão: $e");
    }
  }
}

// --- IMPLEMENTAÇÃO MOCK ---
class AuthServiceMock implements IAuthService {
  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (username == "ztiago" && password == "123456") {
      return {
        "access_token": "token_exemplo",
        "expires_in": 299,
        "refresh_expires_in": 1799,
        "refresh_token": "refresh_token_exemplo",
        "token_type": "Bearer",
        "session_state": "abc123",
        "scope": "profile email"
      };
    } else {
      throw Exception("Usuário ou senha inválidos (Mock)");
    }
  }
}
