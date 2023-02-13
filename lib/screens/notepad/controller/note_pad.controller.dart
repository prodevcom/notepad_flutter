import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/application/model/note_pad.dart';
import 'package:notepad/application/services/note_pad.dart';
import 'package:notepad/helpers/snack.dart';

class NotePadController {
  final BuildContext _context;
  NotePadController._(this._context);

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final body = TextEditingController();
  final bodyFocusNode = FocusNode();

  factory NotePadController.of(BuildContext context) {
    return NotePadController._(context);
  }

  set setModel(NotePadModel? model) {
    if (model == null) return;
    title.text = model.title;
    body.text = model.body;
  }

  String getUserId() {
    var currentUser = FirebaseAuth.instance.currentUser;
    var userId = currentUser?.uid;
    if (userId == null) {
      throw "Erro ao salvar esta nota, tente novamente mais tarde.";
    }

    return userId;
  }

  Future<NotePadModel?> create() async {
    FocusScope.of(_context).unfocus();
    try {
      var model = NotePadModel.create(title.text, body.text);
      var id = await NotePadService.create(getUserId(), model);
      log("Notepad created with successfully: $id");
      model.setId = id;
      return model;
    } catch (error) {
      SnackBarHelper.show(_context, message: error.toString());
    }
    return null;
  }

  Future<NotePadModel?> update(NotePadModel update) async {
    FocusScope.of(_context).unfocus();
    try {
      var model = NotePadModel.update(title.text, body.text, update);
      await NotePadService.update(getUserId(), model);
      log("Notepad updated with successfully: ${model.id}");
      return model;
    } catch (error) {
      SnackBarHelper.show(_context, message: error.toString());
    }
    return null;
  }
}
