import 'package:flutter/material.dart';
import 'package:firebase_web/presentation/screens_widgets.dart';
import 'package:image_network/image_network.dart';

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
    final titleStyleLarge = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2V6IIe85O5QimsrqMOh2VuMsvpTVEMLa3RCAe6F5NnQ&s'),
              PaddingCustom(
                height: 10,
              ),
              Text(
                'Login',
                style: titleStyleLarge,
              ),
              const PaddingCustom(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Email (helpdesk@dgaep.gov.pt)')),
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text('Palabra-passe (abc123.)')),
              ),
              const PaddingCustom(
                height: 10,
              ),
              FilledButton(
                  onPressed: () {
                    try {
                      signIn();
                      context.go('/');
                      prefs.ultimaScreen = '/';
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
