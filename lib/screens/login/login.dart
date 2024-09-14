import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            const SizedBox(height: 20),
            titleText(),
            const SizedBox(height: 50),
            loginButton(context),
          ],
        ),
      ),
    );
  }
}

Text titleText() { 
  return const Text(
    'LogicLAB',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)
  );
}

var logo = Image.asset('logo.png', width: 200, height: 200);

Widget loginButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false, // Elimina todas las rutas anteriores
      );
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    ),
    child: const Text('Continuar con google'),
  );
}