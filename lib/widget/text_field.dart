import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum WFieldType { text, email, password, reversedTitle }

class WTextFieldConfig {
  WTextFieldConfig({
    required this.title,
    this.hintText,
    this.maxLength,
    this.validator,
    this.actionIcon,
    this.action,
  });

  final String title;
  final String? hintText;
  final int? maxLength;
  final String? Function(String?)? validator;
  final IconData? actionIcon;
  final void Function()? action;
}

class WTextField extends StatefulWidget {
  const WTextField({
    super.key,
    this.type = WFieldType.text,
    required this.controller,
    required this.config,
    this.focusNode,
    this.icon,
    this.iconDisabled = false,
  });

  final WFieldType type;
  final TextEditingController controller;
  final WTextFieldConfig config;
  final FocusNode? focusNode;
  final IconData? icon;
  final bool iconDisabled;

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  bool obscure = false;

  @override
  void initState() {
    obscure = widget.type == WFieldType.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isReverse = widget.type == WFieldType.reversedTitle;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: isReverse ? Colors.white : null,
      decoration: InputDecoration(
        icon: getIconByType(),
        label: isReverse ? null : Text(widget.config.title),
        labelStyle: isReverse ? const TextStyle(color: Colors.white) : null,
        hintText: isReverse ? widget.config.title : widget.config.hintText,
        suffixIcon: getSuffixAction(),
        counter: isReverse ? const Offstage() : null,
        border: isReverse ? InputBorder.none : null,
      ),
      style:
          isReverse ? const TextStyle(fontSize: 20, color: Colors.white) : null,
      textAlignVertical: TextAlignVertical.center,
      obscureText: obscure,
      keyboardType: getTextInputType(),
      validator: widget.config.validator,
      maxLength: widget.config.maxLength,
    );
  }

  TextInputType? getTextInputType() {
    switch (widget.type) {
      case WFieldType.email:
        return TextInputType.emailAddress;
      case WFieldType.password:
        return TextInputType.visiblePassword;
      default:
        return null;
    }
  }

  Widget? getIconByType() {
    if (widget.iconDisabled) {
      return null;
    }

    if (widget.icon != null) {
      return FaIcon(widget.icon);
    }

    switch (widget.type) {
      case WFieldType.email:
        return const FaIcon(FontAwesomeIcons.solidEnvelope);
      case WFieldType.password:
        return const FaIcon(FontAwesomeIcons.lock);
      case WFieldType.text:
      default:
        return null;
    }
  }

  Widget? getSuffixAction() {
    if (widget.config.action != null) {
      var icon = widget.config.actionIcon ?? FontAwesomeIcons.eraser;
      return IconButton(
        onPressed: widget.config.action,
        icon: FaIcon(icon, color: Colors.white),
      );
    } else {
      if (widget.type == WFieldType.password) {
        var icon = obscure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash;
        return IconButton(
          onPressed: () => setState(() => obscure = !obscure),
          icon: FaIcon(icon),
        );
      }
    }
    return null;
  }
}
