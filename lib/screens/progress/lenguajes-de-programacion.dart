import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart'; 

class ProgrammingLanguagesScreen extends StatelessWidget {
  const ProgrammingLanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lenguajes de programación"),
      // Permitir el desplazamiento
      body: SingleChildScrollView( 
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                '¿Qué son los lenguajes de programación?',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),

              // Texto de definición
              Text(
                "Los lenguajes de programación son un conjunto de reglas y sintaxis que permiten a los programadores escribir instrucciones para que una computadora ejecute tareas. Existen diferentes tipos de lenguajes de programación, cada uno con sus propias características y propósitos.",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Escribe algo aquí...',
                ),
              ),
              const SizedBox(height: 20),

              // Centrando el botón
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Completar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
