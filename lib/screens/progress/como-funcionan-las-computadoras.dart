import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class HowComputersWorkScreen extends StatelessWidget {
  const HowComputersWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Cómo funcionan las computadoras"),
      body: SingleChildScrollView( 
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              const Text(
                '¿Cómo funcionan las computadoras?',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),

              Text(
                "Las computadoras funcionan mediante la ejecución de instrucciones en forma de código. Estas instrucciones son procesadas por la unidad central de procesamiento (CPU), que realiza cálculos y operaciones lógicas para llevar a cabo tareas. La información se almacena en memoria y se comunica a través de buses, permitiendo que los distintos componentes de hardware trabajen juntos para ejecutar programas.",
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
              // Espacio entre el texto y el campo
              const SizedBox(height: 20), 
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Escribe algo aquí...',
                ),
              ),
              // Espacio entre el campo de texto y el botón
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
