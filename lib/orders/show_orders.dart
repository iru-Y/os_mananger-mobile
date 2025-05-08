import 'package:easy_os_mobile/orders/edit_order.dart';
import 'package:easy_os_mobile/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';

class ShowOrders extends StatefulWidget {
  const ShowOrders({super.key});

  @override
  State<ShowOrders> createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  final CustomerApi _customerApi = CustomerApi();
  late Future<List<CustomerModel>?> _futureCustomers;

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

  void _showEditModal(CustomerModel customer) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) {
        return CustomModalBottomSheet(
          onDismiss: _fetchCustomers,
          child: EditOrder(customer: customer),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CustomerModel>?>(
        future: _futureCustomers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar clientes:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          final customers = snapshot.data;
          if (customers == null || customers.isEmpty) {
            return const Center(child: Text('Nenhum cliente encontrado'));
          }

          return RefreshIndicator(
            onRefresh: () async => _fetchCustomers(),
            child: ListView.builder(
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 26,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nome: ${customer.fullName}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Telefone: ${customer.phone}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Email: ${customer.email}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Problema encontrado: ${customer.description}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Preço: R\$ ${customer.price}",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditModal(customer),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await CustomAlertDialog.show(
                              context,
                              title: 'Confirmar exclusão',
                              content: 'Deseja excluir este cliente?',
                              confirmText: 'Excluir',
                              cancelText: 'Cancelar',
                            );
                            if (confirm == true) {
                              final deleted = await _customerApi.deleteCustomer(
                                customer.id!,
                              );
                              if (deleted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Cliente excluído com sucesso',
                                    ),
                                  ),
                                );
                                _fetchCustomers();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Erro ao excluir cliente'),
                                  ),
                                );
                              }
                            }
                          },
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
