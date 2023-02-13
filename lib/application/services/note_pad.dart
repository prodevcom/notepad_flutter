import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notepad/application/model/note_pad.dart';

class NotePadService {
  static final _collection =
      FirebaseFirestore.instance.collection("user_workspace");

  // Reference

  static CollectionReference<NotePadModel> getCollection(String userId) {
    var refs = _collection.doc(userId).collection("note_pads");
    return refs.withConverter<NotePadModel>(
      fromFirestore: (snap, _) => NotePadModel.fromJson(snap.id, snap.data()!),
      toFirestore: (snap, _) => snap.toJson(),
    );
  }

  // CRUDs
  static Future<String> create(String userId, NotePadModel notePadModel) async {
    return (await getCollection(userId).add(notePadModel)).id;
  }

  static Future<void> update(String userId, NotePadModel notePadModel) async {
    await getCollection(userId).doc(notePadModel.id).set(notePadModel);
  }

  static Stream<QuerySnapshot<Object?>> notes(String userId) {
    return getCollection(userId)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  static Future<void> delete(String userId, NotePadModel notePadModel) async {
    await getCollection(userId).doc(notePadModel.id).delete();
  }
}
