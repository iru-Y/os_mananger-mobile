import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:easy_os_mobile/orders/edit_order.dart';
import 'package:easy_os_mobile/widgets/custom_modal_bottom_sheet.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/text/custom_sub_title.dart';

class ShowOrders extends StatefulWidget {
  const ShowOrders({super.key});

  @override
  State<ShowOrders> createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  final CustomerApi _customerApi = CustomerApi();
  late Future<List<CustomerResponse>?> _futureCustomers;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  void _fetchCustomers() {
    setState(() {
      _futureCustomers = _customerApi.getAllCustomers();
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

  void _showEditModal(CustomerResponse resp) async {
    if (resp.id == null) {
      await _showError('Cliente sem ID, impossível editar');
      return;
    }

    final model = await _customerApi.getCustomerById(resp.id!);
    if (model == null) {
      await _showError('Erro ao carregar dados para edição');
      return;
    }

    final updated = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) {
        return CustomModalBottomSheet(child: EditOrder(customer: model));
      },
    );

    if (updated == true) {
      _fetchCustomers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CustomerResponse>?>(
        future: _futureCustomers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingAnimation(size: 120));
          }
          if (snapshot.hasError) {
            return Center(
              child: CustomSubTitle(
                title: 'Erro ao carregar clientes:\n${snapshot.error}',
                color: Colors.red,
              ),
            );
          }
          final customers = snapshot.data;
          if (customers == null || customers.isEmpty) {
            return const Center(
              child: CustomSubTitle(title: 'Nenhum cliente encontrado'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _fetchCustomers(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: CustomColors.outlineBorder),
                  ),
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  color: CustomColors.backgroundFormColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                     bottom: 26,
                     left: 20,
                     right: 20
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Ordem de serviço: ${customer.id}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),
                                    ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed:
                                            () => _showEditModal(customer),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          final confirm =
                                              await CustomAlertDialog.show(
                                                context,
                                                title: 'Confirmar exclusão',
                                                content:
                                                    'Deseja excluir este cliente?',
                                                confirmText: 'Excluir',
                                                cancelText: 'Cancelar',
                                                isInfo: true
                                              );
                                          if (confirm == true) {
                                            final deleted = await _customerApi
                                                .deleteCustomer(customer.id!);
                                            if (deleted) {
                                              await CustomAlertDialog.show(
                                                context,
                                                title: 'Sucesso',
                                                content:
                                                    'Cliente excluído com sucesso',
                                                confirmText: 'OK',
                                                cancelText: '',
                                              );
                                              _fetchCustomers();
                                            } else {
                                              await _showError(
                                                'Erro ao excluir cliente',
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              CustomSubTitle(
                                title: 'Nome: ${customer.fullName}',
                              ),
                              CustomSubTitle(
                                title: 'Telefone: ${customer.phone}',
                              ),
                              CustomSubTitle(title: 'Email: ${customer.email}'),
                              CustomSubTitle(
                                title:
                                    'Problema encontrado: ${customer.description}',
                              ),
                              CustomSubTitle(
                                title: 'Preço: R\$ ${customer.servicePrice}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
