import 'package:easy_os_mobile/domain/schema/customer_response.dart';
import 'package:easy_os_mobile/orders/edit_order.dart';
import 'package:easy_os_mobile/widgets/custom_modal_bottom_sheet.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

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
          child: EditOrder(customer: model),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CustomerResponse>?>(
        future: _futureCustomers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingAnimation(size: 120);
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
                                "Preço: R\$ ${customer.profit}",
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
                            bool confirm = false;

                            await Dialogs.materialDialog(
                              color: CustomColors.backgroundColor,
                              context: context,
                              title: "Confirmar exclusão",
                              msg: "Deseja excluir este cliente?",
                              titleAlign: TextAlign.center,
                              msgAlign: TextAlign.center,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancelar',
                                  iconData: Icons.cancel_outlined,
                                  textStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  iconColor: Colors.grey,
                                ),
                                IconsOutlineButton(
                                  onPressed: () {
                                    confirm = true;
                                    Navigator.pop(context);
                                  },
                                  text: 'Excluir',
                                  iconData: Icons.delete,
                                  textStyle: const TextStyle(color: Colors.red),
                                  iconColor: Colors.red,
                                ),
                              ],
                            );
                            if (confirm == true) {
                              final deleted = await _customerApi.deleteCustomer(
                                customer.id!,
                              );
                              if (deleted) {
                                await CustomAlertDialog.show(
                                  context,
                                  title: 'Sucesso',
                                  content: 'Cliente excluído com sucesso',
                                  confirmText: 'OK',
                                  cancelText: '',
                                );
                                _fetchCustomers();
                              } else {
                                await _showError('Erro ao excluir cliente');
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
