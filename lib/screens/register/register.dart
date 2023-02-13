import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notepad/helpers/forms.dart';
import 'package:notepad/helpers/validation.dart';
import 'package:notepad/screens/register/controller/register.controller.dart';
import 'package:notepad/widget/buttons.dart';
import 'package:notepad/widget/scrollview.dart';
import 'package:notepad/widget/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String id = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterController controller;
  bool isLoading = false;

  @override
  void initState() {
    controller = RegisterController.of(context);
    controller.nameFocus.requestFocus();
    super.initState();
  }

  void register() async {
    setState(() => isLoading = true);
    if (FormsHelper.validate(controller.formKey)) {
      await controller.register();
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seja bem-vindo")),
      body: WScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Ficamos felizes tem ter você aqui, preencha seus dados abaixo e tenha acesso exclusivo ao nosso App!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              WTextField(
                controller: controller.name,
                focusNode: controller.nameFocus,
                type: WFieldType.text,
                icon: FontAwesomeIcons.solidCircleUser,
                config: WTextFieldConfig(
                  title: "Nome completo",
                  validator: ValidationHelper.validateIsEmpty,
                ),
              ),
              const SizedBox(height: 12),
              WTextField(
                controller: controller.email,
                focusNode: controller.emailFocus,
                type: WFieldType.email,
                config: WTextFieldConfig(
                  title: "Email",
                  validator: ValidationHelper.validateEmail,
                ),
              ),
              const SizedBox(height: 12),
              WTextField(
                controller: controller.password,
                focusNode: controller.passwordFocus,
                type: WFieldType.password,
                config: WTextFieldConfig(
                  title: "Senha",
                  validator: ValidationHelper.validatePassword,
                ),
              ),
              const SizedBox(height: 12),
              WTextField(
                controller: controller.checkPassword,
                focusNode: controller.checkPasswordFocus,
                type: WFieldType.password,
                config: WTextFieldConfig(
                  title: "Confirme sua Senha",
                  validator: (String? value) {
                    return ValidationHelper.validatePasswordCheck(
                      controller.password.text,
                      value,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              WButton(
                label: "Cadastrar",
                onPressed: register,
                isLoading: isLoading,
                loadingLabel: "Cadastrando",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
