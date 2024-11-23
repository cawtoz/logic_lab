import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/services/user_service.dart';

class CompilersAndInterpretersScreen extends StatefulWidget {
  const CompilersAndInterpretersScreen({super.key});

  @override
  State<CompilersAndInterpretersScreen> createState() =>
      _CompilersAndInterpretersScreenState();
}

class _CompilersAndInterpretersScreenState
    extends State<CompilersAndInterpretersScreen> {
  final Map<int, String?> selectedOptions = {};
  final Map<int, String> correctAnswers = {
    0: "Traducir el código fuente", // Compiladores
    1: "Ejecutar el código línea por línea", // Intérpretes
    2: "Crear aplicaciones de manera más rápida", // Usos de compiladores
  };

  @override
  Widget build(BuildContext context) {
    void showCompletionDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("¡Felicitaciones!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.celebration,
                  color: Colors.amber,
                  size: 50,
                ),
                const SizedBox(height: 16),
                Text(
                  "Has completado el ejercicio",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("Finalizar"),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(title: "Compiladores e Intérpretes"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Compiladores e Intérpretes: una visión general",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildInfoCard(
                "¿Qué son los compiladores?",
                "Un compilador es un programa que traduce el código fuente de un lenguaje de programación de alto nivel a un lenguaje de bajo nivel (como el lenguaje de máquina) para que pueda ser ejecutado por la computadora.",
              ),
              const SizedBox(height: 20),
              buildInfoCard(
                "¿Qué son los intérpretes?",
                "Un intérprete es un programa que lee y ejecuta el código fuente línea por línea sin convertirlo en un archivo ejecutable. A menudo, se usan en lenguajes de programación como Python.",
              ),
              const SizedBox(height: 20),
              buildInfoCard(
                "Diferencias clave",
                "Los compiladores convierten todo el código de una vez antes de ejecutarlo, mientras que los intérpretes ejecutan el código línea por línea. Esto hace que los intérpretes sean más rápidos para la depuración, pero los compiladores producen programas más eficientes.",
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Ejercicio",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildExerciseQuestion(
                "¿Qué hace un compilador?",
                0,
                {
                  "Traducir el código fuente": true,
                  "Ejecutar el código línea por línea": false,
                },
              ),
              buildExerciseQuestion(
                "¿Qué hace un intérprete?",
                1,
                {
                  "Ejecutar el código línea por línea": true,
                  "Traducir el código fuente": false,
                },
              ),
              buildExerciseQuestion(
                "¿Cuál es el propósito principal de un compilador?",
                2,
                {"Crear aplicaciones de manera más rápida": true, "Compilar código en ejecución": false},
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 30,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (isValid()) {
                      UserService userService = UserService();
                      int? userLevel = await userService.getUserLevel();
                      if (userLevel == 4) {
                        await userService.updateUserLevel(5);
                      }
                      showCompletionDialog();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("¡Error!"),
                          content: const Text("Por favor, responde todas las preguntas correctamente."),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Aceptar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
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
                color: Colors.blue,
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
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...options.keys.map((option) {
              return RadioListTile<String>(
                activeColor: Colors.blue,
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

  // Función para validar las respuestas
  bool isValid() {
    bool allAnswered = true;
    bool allCorrect = true;

    for (var questionId in selectedOptions.keys) {
      String? selectedOption = selectedOptions[questionId];
      if (selectedOption == null) {
        allAnswered = false;
      } else if (selectedOption != correctAnswers[questionId]) {
        allCorrect = false;
      }
    }

    return allAnswered && allCorrect;
  }
}
