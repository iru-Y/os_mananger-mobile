import 'dart:convert';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
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
      logger.e(
        'Falha na requisição de token: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Erro ao fazer requisição de token: ${response.statusCode}',
      );
    }
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final url = Uri.parse('$apiPath/token/refresh/');
    logger.d('Solicitando novo access token...');

    final response = await http.post(
      url,
      body: jsonEncode({'refresh': refreshToken}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newToken = data['access'] as String?;
      if (newToken != null) {
        logger.i('Novo token de acesso obtido com sucesso');
        await SecureStorageService().saveToken(newToken);
        return newToken;
      }
    } else {
      logger.e(
        'Erro ao renovar token: ${response.statusCode} - ${response.body}',
      );
    }
    return null;
  }
}
