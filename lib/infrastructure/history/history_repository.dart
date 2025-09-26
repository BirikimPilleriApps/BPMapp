import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bpmapp/domain/history/history_record.dart';

class HistoryRepository {
  final FirebaseFirestore db;

  HistoryRepository({FirebaseFirestore? firestore})
      : db = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) {
    return db.collection("users").doc(uid).collection("history");
  }

  Future<void> add(String uid, HistoryRecord record) async {
    await _col(uid).add(record.toJson());
  }

  Stream<List<HistoryRecord>> observe(String uid, {int limit = 100}) {
    return _col(uid)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) =>
        HistoryRecord.fromJson(doc.data(), id: doc.id))
        .toList());
  }

  Future<List<HistoryRecord>> getOnce(String uid, {int limit = 100}) async {
    final q = await _col(uid)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .get();
    return q.docs
        .map((doc) => HistoryRecord.fromJson(doc.data(), id: doc.id))
        .toList();
  }
}
