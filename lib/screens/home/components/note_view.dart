import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:notepad/application/model/note_pad.dart';
import 'package:notepad/application/services/note_pad.dart';
import 'package:notepad/screens/home/components/note_card.dart';

class NoteViewWidget extends StatelessWidget {
  const NoteViewWidget({super.key, required this.snapshot});

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  Widget build(BuildContext context) {
    var documents = snapshot.data?.docs ?? [];

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || documents.isEmpty) {
      return const Center(child: Text("Você ainda não tem notas criadas!"));
    }

    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        var note = documents[index].data() as NotePadModel;
        return NoteCardWidget(
          model: note,
          onDelete: (direction) {
            var userId = FirebaseAuth.instance.currentUser?.uid ?? "none";
            NotePadService.delete(userId, note);
          },
        );
      },
    );
  }
}
