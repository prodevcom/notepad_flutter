import 'package:flutter/material.dart';

import 'package:notepad/helpers/forms.dart';
import 'package:notepad/helpers/validation.dart';
import 'package:notepad/screens/login/controller/login.controller.dart';
import 'package:notepad/screens/register/register.dart';
import 'package:notepad/widget/buttons.dart';
import 'package:notepad/widget/scrollview.dart';
import 'package:notepad/widget/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  late bool isLoading;

  @override
  void initState() {
    controller = LoginController.of(context);
    isLoading = false;
    super.initState();
  }

  void authenticate() async {
    setState(() => isLoading = true);
    if (FormsHelper.validate(controller.formKey)) {
      await controller.authenticate();
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        center: true,
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo ao NotePad",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              WTextField(
                controller: controller.email,
                focusNode: controller.emailFocus,
                type: WFieldType.email,
                config: WTextFieldConfig(
                  title: "Email",
                  validator: ValidationHelper.validateEmail,
                ),
              ),
              const SizedBox(height: 16),
              WTextField(
                controller: controller.password,
                focusNode: controller.passwordFocus,
                type: WFieldType.password,
                config: WTextFieldConfig(
                  title: "Senha",
                  validator: ValidationHelper.validatePassword,
                ),
              ),
              const SizedBox(height: 16),
              WButton(
                label: "Entrar",
                onPressed: authenticate,
                isLoading: isLoading,
                loadingLabel: "Entrando",
              ),
              const SizedBox(height: 16),
              const Text("ou"),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RegisterScreen.id),
                child: const Text("CADASTRE-SE!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
