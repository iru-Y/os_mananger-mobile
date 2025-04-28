import 'dart:convert';
import 'package:http/http.dart' as http;

class JwtRequest {
  final String baseUrl = 'https://exemplo.com/api/';

  Future<void> fetchToken(String token) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse('$baseUrl/data'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Dados recebidos: $data');
    } else {
      print('Erro ao fazer requisição: ${response.statusCode}');
    }
  }

  Future<void> postToken(String token, Map<String, dynamic> body) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      print('Sucesso: ${response.body}');
    } else {
      print('Erro: ${response.statusCode}');
    }
  }
}
