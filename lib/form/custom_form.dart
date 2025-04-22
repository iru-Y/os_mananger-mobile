import 'package:easy_os_mobile/domain/fetch/fetch_customers.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController adressController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    final FetchCustomers fetchCustomers = FetchCustomers();

    Future<void> postCustomer() async {
      CustomerRequest customerRequest = CustomerRequest(
        fullName: nameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text,
        fullAddress: adressController.text.trim(),
        description: descriptionController.text.trim(),
      );
      var resp = await fetchCustomers.postUser(customerRequest);
      if (resp?.status == 'success')
        Navigator.of(context).pushNamed(AppRoutes.orders);
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
            labelTxt: 'Endereço',
            textEditingController: adressController,
          ),
          InputField(
            labelTxt: 'Descrição do problema',
            textEditingController: descriptionController,
          ),
          SizedBox(height: 20),
          CustomButton(onTap: postCustomer, txtBtn: 'Criar'),
          SizedBox(height: 20,),
          CustomButton(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.orders);
            },
            txtBtn: 'Pular',
          ),
        ],
      ),
    );
  }
}
