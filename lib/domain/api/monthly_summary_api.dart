import 'dart:convert';
import 'package:easy_os_mobile/domain/schema/monthly_summary_response.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MonthlySummaryApi {
  final Logger logger = Logger();
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<MonthlySummaryResponse?> getMonthlySummary() async {
    final url = Uri.parse('$apiPath/customers/monthly-summary/');

    final token = await _secureStorage.getToken();
    if (token == null) return null;

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return MonthlySummaryResponse.fromJson(jsonResponse);
    } else {
      logger.e('Erro no monthly-summary: ${response.statusCode} - ${response.body}');
      return null;
    }
  }
}
