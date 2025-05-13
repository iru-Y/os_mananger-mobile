import 'dart:convert';

import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/utils/api_path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}
class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CustomerApi customerApi;
  late MockSecureStorageService mockSecureStorage;
  late MockHttpClient mockHttpClient;

  const String fakeToken = 'fakeToken123';
  String apiUrl = '$apiPath/customers/';

  setUp(() {
    mockSecureStorage = MockSecureStorageService();
    mockHttpClient = MockHttpClient();
    customerApi = CustomerApi();
  });

  group('CustomerApi', () {
    group('postUser', () {
      test('deve retornar um CustomerResponse em caso de sucesso', () async {
        final customer = CustomerModel(
          fullName: 'John Doe',
          email: 'john@example.com',
          phone: '123456789',
          description: 'Cliente teste',
          costPrice: "70",
          servicePrice: "200"
        );

        final responseBody = jsonEncode({
          'full_name': 'John Doe',
          'email': 'john@example.com',
          'phone': '123456789',
          'description': 'Cliente teste',
          'profit': '50.00',
        });

        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.post(
          Uri.parse(apiUrl),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(responseBody, 201));

        final result = await customerApi.postUser(customer);

        expect(result, isA<CustomerResponse>());
        expect(result?.fullName, equals('John Doe'));
      });

      test('deve retornar null em caso de erro 400', () async {
        final customer = CustomerModel(
          fullName: 'Invalid',
          email: 'invalid@example.com',
          phone: '123456789',
          description: 'Cliente teste',
          costPrice: "70",
          servicePrice: "200"
        );

        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.post(
          Uri.parse(apiUrl),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response('{"error": "Bad Request"}', 400));

        final result = await customerApi.postUser(customer);

        expect(result, isNull);
      });
    });

    group('getAllCustomers', () {
      test('deve retornar uma lista de CustomerResponse em caso de sucesso', () async {
        final responseBody = jsonEncode([
          {
            'full_name': 'John Doe',
            'email': 'john@example.com',
            'phone': '123456789',
            'description': 'Cliente teste',
            'profit': '50.00',
          },
          {
            'full_name': 'Jane Smith',
            'email': 'jane@example.com',
            'phone': '987654321',
            'description': 'Cliente teste 2',
            'profit': '75.00',
          },
        ]);

        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.get(Uri.parse(apiUrl), headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(responseBody, 200));

        final result = await customerApi.getAllCustomers();

        expect(result, isA<List<CustomerResponse>>());
        expect(result?.length, equals(2));
      });

      test('deve retornar null em caso de erro 500', () async {
        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.get(Uri.parse(apiUrl), headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('{"error": "Server Error"}', 500));

        final result = await customerApi.getAllCustomers();

        expect(result, isNull);
      });
    });

    group('deleteCustomer', () {
      test('deve retornar true em caso de sucesso', () async {
        const int customerId = 1;
        final url = Uri.parse('$apiUrl$customerId/');

        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.delete(url, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('', 204));

        final result = await customerApi.deleteCustomer(customerId);

        expect(result, isTrue);
      });

      test('deve retornar false em caso de erro', () async {
        const int customerId = 1;
        final url = Uri.parse('$apiUrl$customerId/');

        when(mockSecureStorage.getToken()).thenAnswer((_) async => fakeToken);
        when(mockHttpClient.delete(url, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('{"error": "Not Found"}', 404));

        final result = await customerApi.deleteCustomer(customerId);

        expect(result, isFalse);
      });
    });
  });
}
