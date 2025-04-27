import 'dart:convert';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:http/http.dart' as http;

class CustomerApi {
  Future<CustomerModel?> postUser(CustomerRequest customer) async {
    final url = Uri.parse('$apiPath/customers/');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(customer.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        final baseStruct = CustomerModel.fromJson(jsonResponse);
        return baseStruct;
      } else {
        print('Erro no POST: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }

  Future<List<CustomerModel>?> getAllCustomers() async {
    final url = Uri.parse('$apiPath/customers');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List;
        final customers =
            jsonResponse.map((item) => CustomerModel.fromJson(item)).toList();

        return customers;
      } else {
        print('Erro no GET: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Erro na requisição: $e');
      return null;
    }
  }
}
