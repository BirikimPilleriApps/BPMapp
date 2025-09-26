import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bpmapp/infrastructure/auth/auth_repository.dart';

class AuthViewModel extends StateNotifier<User?> {
  final AuthRepository _repo;

  AuthViewModel(this._repo) : super(_repo.currentUser) {
    _repo.authStateChanges().listen((user) {
      state = user;
    });
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await _repo.signUp(email, password);
      return null; // hata yok
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _repo.signIn(email, password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }
}

// Providers
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

final authViewModelProvider =
StateNotifierProvider<AuthViewModel, User?>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthViewModel(repo);
});
