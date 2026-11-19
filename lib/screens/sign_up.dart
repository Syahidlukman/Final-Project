import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_notifier.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
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
                final success = await authNotifier.signUp(
                  emailController.text.trim(),
                  passwordController.text,
                );

                if (!context.mounted) return;

                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal melakukan registrasi'),
                    ),
                  );
                }
              },
              child: authNotifier.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Register'),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Sudah punya akun? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}