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
  final MonthlySummaryApi _api = MonthlySummaryApi();
  late Future<MonthlySummaryResponse?> _futureSummary;
  bool _errorShown = false;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  void _loadSummary() {
    setState(() {
      _errorShown = false;
      _futureSummary = _api.getMonthlySummary();
    });
  }

  Future<void> _showError(String msg) {
    return CustomAlertDialog.show(
      context,
      title: 'Erro',
      content: msg,
      confirmText: 'OK',
      cancelText: '',
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MonthlySummaryResponse?>(
      future: _futureSummary,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingAnimation(size: 120));
        }

        if (snapshot.hasError && !_errorShown) {
          _errorShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showError('Erro ao carregar informações do mês');
          });
          return const SizedBox.shrink();
        }

        final summary = snapshot.data;
        if (summary == null) {
          if (!_errorShown) {
            _errorShown = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showError('Nenhum dado disponível');
            });
          }
          return const SizedBox.shrink();
        }

        final cost = summary.totalCostPrice ?? 'Sem informações';
        final service = summary.totalService ?? 'Sem informações';
        final profit = summary.totalProfit ?? 'Sem informações';

        return RefreshIndicator(
          onRefresh: () async {
            _loadSummary();
            await _futureSummary;
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Card(
                elevation: 10,
                color: CustomColors.backgroundFormColor,
                margin: const EdgeInsets.only(top: 120, left: 20, right: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: CustomColors.outlineBorder),
                ),
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
                        'Custos de manutenção: R\$ $cost',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Total de serviços: R\$ $service',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Lucro total: R\$ $profit',
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
