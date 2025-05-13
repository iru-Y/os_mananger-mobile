import 'dart:convert';
import 'dart:ffi';
import 'package:easy_os_mobile/domain/api/jwt_request.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CustomerApi {
  final Logger logger = Logger();
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<CustomerModel?> getCustomerById(int id) async {
    final url = Uri.parse('$apiPath/customers/$id/');
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
      return CustomerModel.fromJson(jsonResponse);
    } else {
      logger.e('Erro no GET detail: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  Future<void> postUser(CustomerModel customer) async {
    final url = Uri.parse('$apiPath/customers/');
    final body = jsonEncode(customer.toJson());

    final response = await _authenticatedRequestWithRetry(
      (token) => http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      ),
    );

    if (response == null) return;

    if (response.statusCode == 200 || response.statusCode == 201) {
      logger.i('Usuário criado com sucesso: ${response.body}');
    } else {
      logger.e('Erro no POST: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<CustomerResponse>?> getAllCustomers() async {
    final url = Uri.parse('$apiPath/customers');

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
      final jsonResponse = jsonDecode(response.body) as List;
      final customers =
          jsonResponse.map((item) => CustomerResponse.fromJson(item)).toList();
      logger.i('Clientes recuperados: ${customers.length}');
      return customers;
    } else {
      logger.e('Erro no GET: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  Future<CustomerModel?> patchCustomer(
    int id,
    Map<String, dynamic> updates,
  ) async {
    final url = Uri.parse('$apiPath/customers/$id/');
    final body = jsonEncode(updates);

    final response = await _authenticatedRequestWithRetry(
      (token) => http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      ),
    );

    if (response == null) return null;

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final updatedCustomer = CustomerModel.fromJson(jsonResponse);
      logger.i('Cliente atualizado: ${response.body}');
      return updatedCustomer;
    } else {
      logger.e('Erro no PATCH: ${response.statusCode} - ${response.body}');
      return null;
    }
  }

  Future<bool> deleteCustomer(int id) async {
    final url = Uri.parse('$apiPath/customers/$id/');

    final response = await _authenticatedRequestWithRetry(
      (token) => http.delete(url, headers: {'Authorization': 'Bearer $token'}),
    );

    if (response == null) return false;

    if (response.statusCode == 204) {
      logger.i('Cliente deletado com sucesso.');
      return true;
    } else {
      logger.e('Erro no DELETE: ${response.statusCode} - ${response.body}');
      return false;
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
          logger.i('Retrying request with new token');
          return await request(newToken);
        }
      }
      return null;
    }
    return response;
  }
}
