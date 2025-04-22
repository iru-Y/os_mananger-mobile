import 'package:easy_os_mobile/domain/fetch/fetch_customers.dart';
import 'package:easy_os_mobile/domain/model/base_struct.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/widgets/custom_modal.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final FetchCustomers fetchCustomers = FetchCustomers();
  late Future<BaseStruct<List<CustomerModel>>?> futureCustomers;

  @override
  void initState() {
    super.initState();
    futureCustomers = fetchCustomers.getAllCustomers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes')),
      body: FutureBuilder<BaseStruct<List<CustomerModel>>?>(
        future: futureCustomers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar clientes'));
          } else if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('Nenhum cliente encontrado'));
          }

          final customers = snapshot.data!.data!;

          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              final customer = customers[index];
              return CustomModal(widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Nome: ${customer.fullName!}", style: TextStyle(
                    fontSize: 20
                  ),),
                  Text("Telefone ${customer.phone!}", style: TextStyle(
                    fontSize: 20
                  )),
                  Text("Email: ${customer.email!}", style: TextStyle(
                    fontSize: 20
                  )),
                  Text("Endereço: ${customer.fullAddress!}", style: TextStyle(
                    fontSize: 20
                  )),
                  Text("Problema encontrado: ${customer.description!}",  style: TextStyle(
                    fontSize: 20)),
                ],)
              );
            },
          );
        },
      ),
    );
  }
}
