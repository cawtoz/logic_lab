import 'package:flutter/material.dart';
import 'package:logic_lab/screens/login/login.dart';

// Pantalla de bienvenida de la aplicación.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  logo,
                  const SizedBox(height: 20),
                  titleText()
                  ]),
                const SizedBox(height: 150),
                Column(
                  children: [
                    welcomeText(),
                    const SizedBox(height: 5),
                    descriptionText(),
                    const SizedBox(height: 30),
                    startButton(context),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}


var logo = Image.asset('assets/logo.jpg', width: 200, height: 200);

Text titleText() { 
  return const Text(
    'LogicLAB',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
  );
}

Text welcomeText() {
  return const Text(
    'Bienvenido a LogicLAB',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
  );
}

Text descriptionText() {
  return const Text(
    'Esta app te guiará en tus primeros pasos en programación. Sin necesidad de experiencia previa, aquí aprenderás cómo funciona la programación, entendiendo la lógica detrás de cómo las computadoras toman decisiones y resuelven problemas.',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.black),
  );
}

Widget startButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    child: const Text('Comenzar'),
  );
}
