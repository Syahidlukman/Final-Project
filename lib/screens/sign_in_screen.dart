import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:modul_6/provider/auth_notifier.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            ElevatedButton(
              onPressed: authNotifier.isLoading
                  ? null
                  : () async {
                final success = await authNotifier.signIn(
                  emailController.text,
                  passwordController.text,
                );

                if (!context.mounted) return;

                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal Sign In'),
                    ),
                  );
                }
              },
              child: authNotifier.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman Sign Up
              },
              child: const Text('Belum punya akun? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}