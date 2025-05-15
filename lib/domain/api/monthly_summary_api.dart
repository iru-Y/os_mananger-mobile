import 'dart:convert';
import 'package:easy_os_mobile/domain/schema/monthly_summary_response.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:easy_os_mobile/domain/api/jwt_request.dart';

class MonthlySummaryApi {
  final Logger logger = Logger();
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<MonthlySummaryResponse?> getMonthlySummary() async {
    final url = Uri.parse('$apiPath/customers/monthly-summary/');

    final response = await _authenticatedRequestWithRetry(
      (token) => http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response == null) return null;

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return MonthlySummaryResponse.fromJson(jsonResponse);
    } else {
      logger.e(
        'Erro no monthly-summary: ${response.statusCode} - ${response.body}',
      );
      return null;
    }
  }

  Future<http.Response?> _authenticatedRequestWithRetry(
    Future<http.Response> Function(String token) request,
  ) async {
    String? token = await _secureStorage.getToken();
    if (token == null) return null;

    http.Response response = await request(token);
    if (response.statusCode == 401) {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken != null) {
        final newToken = await JwtRequest().refreshAccessToken(refreshToken);
        if (newToken != null) {
          logger.i('Retrying MonthlySummary request with new token');
          return await request(newToken);
        }
      }
      return null;
    }

    return response;
  }
}
