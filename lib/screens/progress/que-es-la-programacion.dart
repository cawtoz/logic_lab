import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class ProgrammingDefinitionScreen extends StatelessWidget {
  const ProgrammingDefinitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Que es la programacion"),
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
                '¿Qué es la programación?',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 10),

              Text(
                "La programación es el proceso de diseñar y construir un conjunto de instrucciones que le dicen a una computadora cómo realizar una tarea. Este proceso se lleva a cabo utilizando un lenguaje de programación, que proporciona un conjunto de reglas y sintaxis que los programadores deben seguir.",
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
