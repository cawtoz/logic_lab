import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class HowComputersWorkScreen extends StatefulWidget {
  const HowComputersWorkScreen({super.key});

  @override
  State<HowComputersWorkScreen> createState() => _HowComputersWorkScreenState();
}

class _HowComputersWorkScreenState extends State<HowComputersWorkScreen> {
  final Map<int, String?> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lenguajes de programación"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[900],
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Título principal
              const Center(
                child: Text(
                  "Lenguajes de programación: una visión general",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Tarjeta "¿Qué son?"
              buildInfoCard(
                "¿Qué son?",
                "Los lenguajes de programación son herramientas que los programadores usan para comunicarse con las computadoras, cada uno con su propia sintaxis y propósito.",
              ),
              const SizedBox(height: 20),

              // Tarjeta "¿Para qué funcionan?"
              buildInfoCard(
                "¿Para qué funcionan?",
                "Permiten desarrollar software, desde páginas web (HTML) hasta aplicaciones móviles (Java) o programas de inteligencia artificial (Python).",
              ),
              const SizedBox(height: 20),

              // Imagen
              const Center(
                child: Image(
                  image: AssetImage('../assets/comoFunciona1.png'),
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Image(
                  image: AssetImage('../assets/comoFunciona2.png'),
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Título del ejercicio
              const Center(
                child: Text(
                  "Ejercicio",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Preguntas del ejercicio
              buildExerciseQuestion(
                "Python: ¿Para qué se utiliza?",
                0,
                {
                  "Construir páginas web": false,
                  "Inteligencia artificial": true
                },
              ),
              buildExerciseQuestion(
                "HTML: ¿Para qué se utiliza?",
                1,
                {
                  "Construir páginas web": true,
                  "Inteligencia artificial": false
                },
              ),
              buildExerciseQuestion(
                "Java: ¿Para qué se utiliza?",
                2,
                {"Aplicaciones móviles": true, "Crear videojuegos": false},
              ),

              const SizedBox(height: 20),

              // Botón para finalizar
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
                  child: const Text("Finalizar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función para construir tarjetas de información
  Widget buildInfoCard(String title, String description) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Función para construir preguntas con selección única
  Widget buildExerciseQuestion(
      String question, int questionId, Map<String, bool> options) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                question,
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...options.keys.map((option) {
              return RadioListTile<String>(
                activeColor: Colors.cyanAccent,
                title: Text(
                  option,
                  style: const TextStyle(color: Colors.white),
                ),
                value: option,
                groupValue: selectedOptions[questionId],
                onChanged: (value) {
                  setState(() {
                    selectedOptions[questionId] = value;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
