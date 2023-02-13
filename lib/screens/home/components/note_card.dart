import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:notepad/application/model/note_pad.dart';
import 'package:notepad/screens/notepad/note_pad.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.model,
    this.onDelete,
  });
  final NotePadModel model;
  final Function(DismissDirection direction)? onDelete;

  @override
  Widget build(BuildContext context) {
    final inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    final outputFormat = DateFormat('dd/MM/yy hh:mm');

    var dates = <InlineSpan>[];
    if (model.createdAt == model.updatedAt) {
      var createdAt = inputFormat.parse(model.createdAt.toString());
      dates.add(const TextSpan(text: "Criado em: "));
      dates.add(TextSpan(text: outputFormat.format(createdAt)));
    } else {
      var updatedAt = inputFormat.parse(model.updatedAt.toString());
      dates.add(const TextSpan(text: "Atualizado em: "));
      dates.add(TextSpan(text: outputFormat.format(updatedAt)));
    }
    return Dismissible(
      key: Key(model.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const FaIcon(FontAwesomeIcons.trash, color: Colors.white),
      ),
      onDismissed: onDelete,
      child: ListTile(
        onTap: () {
          var args = NotePadScreenArgs(model: model);
          Navigator.of(context).pushNamed(NotePadScreen.id, arguments: args);
        },
        title: Text(model.title),
        subtitle: RichText(
          text: TextSpan(
            children: dates,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        trailing: const FaIcon(FontAwesomeIcons.caretRight),
      ),
    );
  }
}
