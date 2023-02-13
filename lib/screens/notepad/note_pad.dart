import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notepad/application/model/note_pad.dart';
import 'package:notepad/screens/notepad/components/body.dart';
import 'package:notepad/screens/notepad/components/title.dart';
import 'package:notepad/screens/notepad/controller/note_pad.controller.dart';

class NotePadScreenArgs {
  final NotePadModel? model;
  NotePadScreenArgs({this.model});
}

class NotePadScreen extends StatefulWidget {
  const NotePadScreen({super.key, this.args});
  static const String id = "/note-pad";
  final NotePadScreenArgs? args;

  @override
  State<NotePadScreen> createState() => _NotePadScreenState();
}

class _NotePadScreenState extends State<NotePadScreen> {
  late NotePadController controller;
  NotePadModel? model;
  bool isLoading = false;

  @override
  void initState() {
    controller = NotePadController.of(context);
    controller.bodyFocusNode.requestFocus();
    model = widget.args?.model;
    controller.setModel = model;
    super.initState();
  }

  void onSave() async {
    setState(() => isLoading = true);
    model = (model == null)
        ? await controller.create()
        : await controller.update(model!);
    setState(() => isLoading = false);

    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) => onClose(),
    );
  }

  void onClose() async {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Scaffold(
        appBar: AppBar(title: NotePadTitleWidget(controller: controller.title)),
        body: SafeArea(
          child: NotePadBodyWidget(
            controller: controller.body,
            focusNode: controller.bodyFocusNode,
          ),
        ),
        floatingActionButton: isLoading
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: onSave,
                    heroTag: null,
                    child: const FaIcon(FontAwesomeIcons.solidFloppyDisk),
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton.small(
                    onPressed: onClose,
                    heroTag: null,
                    backgroundColor: Colors.red,
                    child: const FaIcon(FontAwesomeIcons.xmark),
                  ),
                ],
              ),
      ),
    );
  }
}
