import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class ProgrammingDefinitionScreen extends StatelessWidget {
  const ProgrammingDefinitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "¿Qué es la programación?"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[900],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título principal
              const SizedBox(height: 10),
              const Text(
                "¿Qué es la programación?",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Tarjeta para "¿Qué es?"
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "¿Qué es?",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "La programación es el proceso de crear instrucciones que una computadora puede entender y ejecutar para realizar tareas o resolver problemas.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tarjeta para "¿Para qué funciona?"
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "¿Para qué funciona?",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Sirve para automatizar tareas, construir aplicaciones y sistemas, y resolver problemas de forma lógica y estructurada.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Ejemplo con imagen
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ejemplo:",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Supongamos que quieres explicarle a alguien cómo preparar un sándwich.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Image.asset(
                          '../assets/sandwich.png', // Imagen ilustrativa
                          height: 450,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Relación con programación: Cada paso es una instrucción que la persona sigue para completar una tarea. En programación, estas instrucciones son las líneas de código.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Ejercicio
              const Text(
                "Ejercicio:",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "crea un sandwch de pollo.",
                style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Inputs para completar
              buildExerciseInput("1. Toma dos rebanadas de ", "pan/tomate"),
              buildExerciseInput("2. Unta ", "mantequilla/agua"),
              buildExerciseInput("3. Coloca ", "pollo y queso/carne y queso"),
              buildExerciseInput("4. Pon la otra rebanada encima y ", "come/juega"),

              const SizedBox(height: 20),

              // Botón "Completar"
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 30,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
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

  // Widget para crear inputs de ejercicio
  Widget buildExerciseInput(String text, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hint,
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
