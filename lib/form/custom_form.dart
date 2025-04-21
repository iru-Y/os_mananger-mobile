import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
 
  const CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController  = TextEditingController();
  final TextEditingController emailController  = TextEditingController();
  final TextEditingController adressController  = TextEditingController();
  final TextEditingController descriptionController  = TextEditingController();

  

    return Form(
      child: Column(
        children: [
          InputField(labelTxt: 'Nome Completo', textEditingController: nameController,),
          InputField(labelTxt: 'Telefone', textEditingController: phoneController,),
          InputField(labelTxt: 'Email', textEditingController: emailController,),
          InputField(labelTxt: 'Endereço', textEditingController: adressController,),
          InputField(labelTxt: 'Descrição do problema', textEditingController: descriptionController,),
          SizedBox(height: 20),
          CustomButton(onTap: () => {}, txtBtn: 'Criar'),
        ],
      ),
    );
  }
}
