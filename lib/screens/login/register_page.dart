import 'package:logic_lab/services/auth_service.dart';
import 'package:logic_lab/components/dialog_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();

}

class RegisterPageState extends State<RegisterPage> {

  final displayNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(labelText: 'Nombre de Usuario'),
            ),
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
              onPressed: register,
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> register() async {
    try {

      User? user = await authService.registerWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      await user?.updateProfile(displayName: displayNameController.text);
      await user?.reload();

      DialogUtil.showCustomDialog(context, 'Registro exitoso', '¡Te has registrado exitosamente!');
      
    } catch (e) {
      String message;
      if (e is FirebaseAuthException) {
        switch(e.code) {
          case 'weak-password': message = 'La contraseña es muy débil.'; break;
          case 'invalid-email': message = 'Correo electrónico inválido.'; break;
          case 'email-already-in-use': message = 'Ya hay una cuenta registrada con este correo.'; break;
          default: message = 'Error: ${e.message}';
        }
      } else {
        message = 'Error desconocido.';
      }
      DialogUtil.showCustomDialog(context, 'Error', message);
    }
  }

}
