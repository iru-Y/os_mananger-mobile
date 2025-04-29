import 'dart:convert';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class JwtRequest {
  final Uri url = Uri.parse('$apiPath/token/');
  final Logger logger = Logger();

  Future<String> getToken(String username, String password) async {
    logger.d('fazendo requisição POST em $url');
    final response = await http.post(
      url,
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final token = data['access'] as String?;
      if (token == null) {
        logger.e('Resposta sem campo "access": ${response.body}');
        throw Exception('Resposta inválida ao obter token');
      }
      logger.i('Token recebido com sucesso');
      return token;
    } else {
      logger.e('Falha na requisição de token: ${response.statusCode} - ${response.body}');
      throw Exception('Erro ao fazer requisição de token: ${response.statusCode}');
    }
  }
}
