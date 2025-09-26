import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bpmapp/application/auth/auth_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _busy = false;

  void _doLogin() async {
    setState(() => _busy = true);
    final vm = ref.read(authViewModelProvider.notifier);
    final msg = await vm.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    setState(() {
      _busy = false;
      _error = msg;
    });
    if (msg == null && mounted) {
      Navigator.pushReplacementNamed(context, "/main");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Giriş Yap", style: Theme.of(context).textTheme.headlineMedium),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-posta"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Şifre"),
              obscureText: true,
            ),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _busy ? null : _doLogin,
              child: Text(_busy ? "..." : "Giriş Yap"),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, "/signup"),
              child: const Text("Hesabın yok mu? Kayıt Ol"),
            )
          ],
        ),
      ),
    );
  }
}
