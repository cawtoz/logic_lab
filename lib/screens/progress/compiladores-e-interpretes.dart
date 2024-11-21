import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class CompilersAndInterpretersScreen extends StatelessWidget {
  const CompilersAndInterpretersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Compiladores e intérpretes"),
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
                '¿Qué son los compiladores e intérpretes?',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),

              // Texto de definición
              Text(
                "Los compiladores e intérpretes son herramientas que traducen el código fuente escrito en un lenguaje de programación a un lenguaje que la computadora puede entender. Un compilador convierte todo el código de una vez, mientras que un intérprete lo ejecuta línea por línea.",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // Campo de texto
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
