import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/screens/login/login.dart';

class ConfigScreen extends StatelessWidget {
  
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar(title: "Configuracion"),

      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Cerrar sesión'),
          )
        ],
      )
      
    );
  }
  
}