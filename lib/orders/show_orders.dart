import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:flutter/material.dart';

class ShowOrders extends StatefulWidget {
  const ShowOrders({super.key});

  @override
  State<ShowOrders> createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  final CustomerApi fetchCustomers = CustomerApi();
  late Future<List<CustomerModel>?> futureCustomers;

  @override
  void initState() {
    super.initState();
    futureCustomers = fetchCustomers.getAllCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CustomerModel>?>(
        future: futureCustomers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar clientes'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Nenhum cliente encontrado'));
          }

          final customers = snapshot.data!;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return Card(
                elevation: 4,
                shape: Border.all(color: CustomColors.outlineBorder),
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                color: CustomColors.registerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Nome: ${customer.fullName!}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Telefone ${customer.phone!}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Email: ${customer.email!}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Problema encontrado: ${customer.description!}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Preço: R\$ ${customer.price!}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
