import 'package:logic_lab/main.dart';
import 'package:logic_lab/services/auth_service.dart';
import 'package:logic_lab/components/dialog_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'register_page.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();

}

class LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', width: 200, height: 200),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 20),
            SignInButton(
              Buttons.googleDark,
              text: 'Iniciar Sesión con Google',
              onPressed: loginWithGoogle
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('¿No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      User? user = await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
      
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(initialScreen: 0),
          ),
        );
      }
      
    } catch (e) {
      String message;
      if (e is FirebaseAuthException) {
        switch(e.code) {
          case 'wrong-password': message = 'La contraseña es incorrecta.'; break;
          case 'invalid-email': message = 'Correo electrónico inválido.'; break;
          case 'invalid-credential': message = 'Credenciales incorrectas.';break;
          default: message = 'Error: ${e.message}';
        }
      } else {
        message = 'Error desconocido.';
      }
      DialogUtil.showCustomDialog(context, 'Error', message);
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      await authService.signInWithGoogle();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen(initialScreen: 0)),
      );
    } catch (e) {
      DialogUtil.showCustomDialog(context, 'Error', 'Error durante el inicio de sesión con Google');
    }
  }
  
}
