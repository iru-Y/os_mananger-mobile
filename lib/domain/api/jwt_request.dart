import 'dart:convert';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final Logger logger = Logger();
class JwtRequest {

  final url = Uri.parse('$apiPath/token/');

  Future<String> getToken(String username, String password) async {
    final response = await http.post(
      url,
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      logger.i('Erro ao fazer requisição de token ${response.statusCode}');
      return json.decode(response.body);
    } else {
      logger.e('Erro ao fazer requisição de token ${response.statusCode}');
      throw Exception(
        'Erro ao fazer requisição de token: getToken ${response.statusCode}',
      );
    }
  }
}
