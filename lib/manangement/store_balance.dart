import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/api/monthly_summary_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:easy_os_mobile/domain/schema/monthly_summary_response.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';

class StoreBalance extends StatefulWidget {
  const StoreBalance({super.key});

  @override
  State<StoreBalance> createState() => _StoreBalanceState();
}

class _StoreBalanceState extends State<StoreBalance> {
  MonthlySummaryApi monthlySummaryApi = MonthlySummaryApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MonthlySummaryResponse?>(
      future: monthlySummaryApi.getMonthlySummary(),
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
          return FormWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saldo disponível:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'R\$ ${balance}',
                  style: const TextStyle(fontSize: 24, color: Colors.green),
                ),
              ],
            ),
          );
        } else {
          return const Text('Nenhum dado disponível.');
        }
      },
    );
  }
}
