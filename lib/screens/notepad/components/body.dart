import 'package:flutter/material.dart';

class NotePadBodyWidget extends StatelessWidget {
  const NotePadBodyWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    var fontSize = 18.0;

    return SizedBox(
      height: double.infinity,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        style: TextStyle(fontSize: fontSize),
        decoration: const InputDecoration(
          hintText: "Digite seu texto aqui!",
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
