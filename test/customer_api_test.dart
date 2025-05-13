import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/schema/customer_response.dart';

class TestCustomerApi extends CustomerApi {
  final http.Response fakeResponse;

  TestCustomerApi(this.fakeResponse);

  @override
  Future<http.Response?> _authenticatedRequestWithRetry(
    Future<http.Response> Function(String token) request,
  ) async {
    return Future.value(fakeResponse);
  }
}

void main() {
  group('CustomerApi.getAllCustomers', () {
    test('deve desserializar e retornar lista quando status 200', () async {
      final listJson = jsonEncode([
        {
          "id": 1,
          "full_name": "Alice",
          "email": "alice@example.com",
          "phone": "1234",
          "description": "Teste",
          "profit": "10.00"
        },
        {
          "id": 2,
          "full_name": "Bob",
          "email": "bob@example.com",
          "phone": "5678",
          "description": "Outro",
          "profit": "20.00"
        }
      ]);
      final fake = http.Response(listJson, 200);
      final api = TestCustomerApi(fake);

      final result = await api.getAllCustomers();

      expect(result, isNotNull);
      expect(result, hasLength(2));
      expect(result![0], isA<CustomerResponse>());
      expect(result[1].fullName, equals("Bob"));
    });

    test('deve retornar null quando status != 200', () async {
      final fake = http.Response('erro', 500);
      final api = TestCustomerApi(fake);

      final result = await api.getAllCustomers();
      expect(result, isNull);
    });
  });

  group('CustomerApi.postUser', () {
    test('deve completar a requisição com sucesso em 201', () async {
      final fake = http.Response('', 201);
      final api = TestCustomerApi(fake);

      final dto = CustomerModel(
        fullName: "Carol",
        email: "carol@example.com",
        phone: "9999",
        description: "Serviço X",
        costPrice: "50.00",
        servicePrice: "80.00",
      );

      expect(() async => await api.postUser(dto), returnsNormally);
    });

    test('deve completar a requisição com erro em 400', () async {
      final fake = http.Response('{"error":"bad"}', 400);
      final api = TestCustomerApi(fake);

      final dto = CustomerModel(
        fullName: "X",
        email: "x@x.com",
        phone: "0000",
        description: "Y",
        costPrice: "0",
        servicePrice: "0",
      );

      expect(() async => await api.postUser(dto), returnsNormally);
    });
  });

  group('CustomerApi.getCustomerById', () {
    test('deve retornar CustomerModel quando status 200', () async {
      final jsonBody = jsonEncode({
        "id": 5,
        "full_name": "Dani",
        "email": "dani@example.com",
        "phone": "1111",
        "description": "Teste",
        "cost_price": "40.00",
        "service_price": "70.00"
      });
      final fake = http.Response(jsonBody, 200);
      final api = TestCustomerApi(fake);

      final result = await api.getCustomerById(5);

      expect(result, isNotNull);
      expect(result, isA<CustomerModel>());
      expect(result!.id, equals(5));
      expect(result.costPrice, equals("40.00"));
    });

    test('deve retornar null quando status != 200', () async {
      final fake = http.Response('nope', 404);
      final api = TestCustomerApi(fake);

      final result = await api.getCustomerById(123);
      expect(result, isNull);
    });
  });

  group('CustomerApi.patchCustomer', () {
    test('deve retornar CustomerModel atualizado em 200', () async {
      final jsonBody = jsonEncode({
        "id": 5,
        "full_name": "Dani Alterada",
        "email": "dani2@example.com",
        "phone": "2222",
        "description": "Teste alterado",
        "cost_price": "45.00",
        "service_price": "75.00"
      });
      final fake = http.Response(jsonBody, 200);
      final api = TestCustomerApi(fake);

      final updates = {"description": "Teste alterado"};
      final result = await api.patchCustomer(5, updates);

      expect(result, isNotNull);
      expect(result, isA<CustomerModel>());
      expect(result!.fullName, equals("Dani Alterada"));
    });

    test('deve retornar null em erro 400', () async {
      final fake = http.Response('bad', 400);
      final api = TestCustomerApi(fake);

      final result = await api.patchCustomer(5, {"x": "y"});
      expect(result, isNull);
    });
  });

  group('CustomerApi.deleteCustomer', () {
    test('deve retornar true em 204', () async {
      final fake = http.Response('', 204);
      final api = TestCustomerApi(fake);

      final result = await api.deleteCustomer(7);
      expect(result, isTrue);
    });

    test('deve retornar false em status != 204', () async {
      final fake = http.Response('err', 500);
      final api = TestCustomerApi(fake);

      final result = await api.deleteCustomer(7);
      expect(result, isFalse);
    });
  });
}
