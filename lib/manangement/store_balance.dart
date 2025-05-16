import 'package:easy_os_mobile/domain/api/monthly_summary_api.dart';
import 'package:easy_os_mobile/domain/schema/monthly_summary_response.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';

class StoreBalance extends StatefulWidget {
  const StoreBalance({super.key});

  @override
  State<StoreBalance> createState() => _StoreBalanceState();
}

class _StoreBalanceState extends State<StoreBalance> {
  final MonthlySummaryApi monthlySummaryApi = MonthlySummaryApi();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showError(String msg) {
    return CustomAlertDialog.show(
      context,
      title: 'Erro',
      content: msg,
      confirmText: 'OK',
      cancelText: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MonthlySummaryResponse?>(
      future: monthlySummaryApi.getMonthlySummary(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimation(size: 120);
        }
        if (snapshot.hasError) {
          _showError("Erro ao carregar informações de movimentação do mês");
        }

        final summary = snapshot.data;
        if (summary == null) {
          _showError("Nenhum dado disponível");
        }

        return RefreshIndicator(
          onRefresh: () async => monthlySummaryApi.getMonthlySummary(),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: CustomColors.outlineBorder),
                ),
                margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
                color: CustomColors.backgroundFormColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26,
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Resumo financeiro do mês',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Custos de manutenção: R\$ ${summary?.totalCostPrice}" ??
                            "Sem informações",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Total de serviços: R\$ ${summary?.totalService} " ??
                            "Sem informações",
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Lucro total: R\$ ${summary?.totalProfit}" ??
                            "Sem informações",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
