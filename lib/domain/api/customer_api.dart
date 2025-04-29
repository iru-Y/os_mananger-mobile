import 'dart:convert';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class CustomerApi {
  final Logger logger = Logger();
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<CustomerModel?> postUser(CustomerRequest customer) async {
    final url = Uri.parse('$apiPath/customers/');
    final token = await _secureStorage.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(customer.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final baseStruct = CustomerModel.fromJson(jsonResponse);
        logger.i('Usuário criado com sucesso: ${response.body}');
        return baseStruct;
      } else {
        logger.e('Erro no POST: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      logger.e('Erro na requisição POST', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  Future<List<CustomerModel>?> getAllCustomers() async {
    final url = Uri.parse('$apiPath/customers');
    final token = await _secureStorage.getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List;
        final customers =
            jsonResponse.map((item) => CustomerModel.fromJson(item)).toList();
        logger.i('Clientes recuperados: ${customers.length}');
        return customers;
      } else {
        logger.e('Erro no GET: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e, stackTrace) {
      logger.e('Erro na requisição GET', error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
