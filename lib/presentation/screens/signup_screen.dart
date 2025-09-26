import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bpmapp/application/auth/auth_viewmodel.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  String? _error;
  bool _busy = false;

  void _doSignup() async {
    if (_passwordController.text != _password2Controller.text) {
      setState(() => _error = "Şifreler uyuşmuyor");
      return;
    }
    setState(() => _busy = true);
    final vm = ref.read(authViewModelProvider.notifier);
    final msg = await vm.signUp(
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
            Text("Kayıt Ol", style: Theme.of(context).textTheme.headlineMedium),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-posta"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Şifre"),
              obscureText: true,
            ),
            TextField(
              controller: _password2Controller,
              decoration: const InputDecoration(labelText: "Şifre (tekrar)"),
              obscureText: true,
            ),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _busy ? null : _doSignup,
              child: Text(_busy ? "..." : "Kayıt Ol"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Geri"),
            )
          ],
        ),
      ),
    );
  }
}
