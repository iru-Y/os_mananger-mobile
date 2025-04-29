import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    final CustomerApi fetchCustomers = CustomerApi();

    Future<void> postCustomer() async {
      CustomerRequest customerRequest = CustomerRequest(
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        description: descriptionController.text.trim(),
        price: priceController.text,
      );
      await fetchCustomers.postUser(customerRequest);
      if (!mounted) return;
      Navigator.of(context).pushNamed(AppRoutes.viewOrders);
    }

    return Form(
      child: Column(
        children: [
          InputField(
            labelTxt: 'Nome Completo',
            textEditingController: nameController,
          ),
          InputField(
            labelTxt: 'Telefone',
            textEditingController: phoneController,
          ),
          InputField(labelTxt: 'Email', textEditingController: emailController),
          InputField(
            labelTxt: 'Descrição do problema',
            textEditingController: descriptionController,
          ),
          InputField(
            labelTxt: 'Preço do serviço',
            textEditingController: priceController,
          ),
          SizedBox(height: 20),
          CustomButton(onTap: postCustomer, txtBtn: 'Criar'),
          SizedBox(height: 20),
          CustomButton(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.viewOrders);
            },
            txtBtn: 'Pular',
          ),
        ],
      ),
    );
  }
}
