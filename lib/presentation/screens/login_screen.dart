import 'package:flutter/material.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';

class DashBoardScreen extends StatefulWidget {
  static const name = '/login_screen';
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final FirebaseauthService auth = FirebaseauthService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Inicio de sesión'),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Username')),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Contraseña')),
              ),
              FilledButton(
                  onPressed: () {
                    try {
                      signIn();
                      context.go('/home_screen');
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: const Text('Iniciar sesión')),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.sigInWithEmailAndPassword(email, password);

    if (user != null) {
      print('Inicio correcto');
    } else {
      print('Inicio fallado');
    }
  }
}
