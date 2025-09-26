import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bpmapp/domain/history/history_record.dart';
import 'package:bpmapp/infrastructure/history/history_repository.dart';

class HistoryViewModel extends StateNotifier<List<HistoryRecord>> {
  final HistoryRepository repo;
  final FirebaseAuth auth;

  HistoryViewModel(this.repo, this.auth) : super([]) {
    _init();
  }

  void _init() {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      repo.observe(uid).listen((list) {
        state = list;
      });
    }
  }

  Future<void> save(HistoryRecord record) async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;
    await repo.add(uid, record);
  }
}

// Provider (Riverpod için)
final historyRepositoryProvider =
Provider<HistoryRepository>((ref) => HistoryRepository());

final historyViewModelProvider =
StateNotifierProvider<HistoryViewModel, List<HistoryRecord>>((ref) {
  final repo = ref.watch(historyRepositoryProvider);
  final auth = FirebaseAuth.instance;
  return HistoryViewModel(repo, auth);
});
