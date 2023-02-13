extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class ValidationHelper {
  static String? validateIsEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Este campo não pode ser vazio";
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return "Preencha seu nome completo";
    }
    var splitValue = value.split(' ');
    if (splitValue.length < 2) {
      return "Você deve preencher ao menos 2 nomes";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Preencha seu e-mail";
    } else if (!value.isValidEmail()) {
      return "Preencha seu e-mail corretamente";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    int minValue = 6;
    if (value == null || value.isEmpty) {
      return "Preencha uma senha";
    } else if (value.length < minValue) {
      return "Sua senha deve conter pelo menos 6 caracteres";
    }
    return null;
  }

  static String? validatePasswordCheck(String? value, String? confirm) {
    if (value == null || value.isEmpty) {
      return "Preencha a confirmação da sua senha";
    } else if (value != confirm) {
      return "As senhas preenchidas não estão iguais";
    }
    return null;
  }
}
