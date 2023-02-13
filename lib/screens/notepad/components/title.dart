import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notepad/widget/text_field.dart';

class NotePadTitleWidget extends StatefulWidget {
  const NotePadTitleWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<NotePadTitleWidget> createState() => _NotePadTitleWidgetState();
}

class _NotePadTitleWidgetState extends State<NotePadTitleWidget> {
  String title = "Untitled";
  final focusNode = FocusNode();
  bool isEditing = false;

  @override
  void initState() {
    title = makeTitle();
    widget.controller.text = title;
    focusNode.addListener(listenTitle);
    super.initState();
  }

  String makeTitle() {
    return widget.controller.text != "" ? widget.controller.text : "Untitled";
  }

  void listenTitle() {
    if (!focusNode.hasFocus) {
      title = makeTitle();
      setState(() => isEditing = false);
    }
  }

  void enableEditing() {
    setState(() => isEditing = true);
    Future.delayed(
      const Duration(microseconds: 250),
      () => focusNode.requestFocus(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isEditing
        ? WTextField(
            controller: widget.controller,
            focusNode: focusNode,
            type: WFieldType.reversedTitle,
            config: WTextFieldConfig(
              title: 'Titulo',
              maxLength: 140,
              actionIcon: FontAwesomeIcons.floppyDisk,
              action: () => focusNode.unfocus(),
            ),
          )
        : InkWell(
            onTap: enableEditing,
            child: Text(title),
          );
  }
}
