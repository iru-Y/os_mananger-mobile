import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';

class StoreBalance extends StatefulWidget {
  const StoreBalance({super.key});

  @override
  State<StoreBalance> createState() => _StoreBalanceState();
}

class _StoreBalanceState extends State<StoreBalance> {
  CustomerApi customerApi = CustomerApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CustomerResponse>?>(
      future: customerApi.getAllCustomers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Erro ao carregar saldo: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final balance = snapshot.data!;
          var balances = balance.map((e) => e.profit).toList();
          return ListView.builder(
            itemCount: balances.length,
            itemBuilder: 
                (context, index) => FormWrapper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Saldo disponível:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'R\$ ${balances[index]}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
          );
        } else {
          return const Text('Nenhum dado disponível.');
        }
      },
    );
  }
}
