import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/services/user_service.dart';

class HowComputersWorkScreen extends StatefulWidget {
  const HowComputersWorkScreen({super.key});

  @override
  State<HowComputersWorkScreen> createState() => _HowComputersWorkScreenState();
}

class _HowComputersWorkScreenState extends State<HowComputersWorkScreen> {
  final Map<int, String?> selectedOptions = {};
  final Map<int, String> correctAnswers = {
    0: "Inteligencia artificial", // Python
    1: "Construir páginas web", // HTML
    2: "Aplicaciones móviles", // Java
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
      appBar: const CustomAppBar(title: "Lenguajes de programación"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "Lenguajes de programación: una visión general",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildInfoCard(
                "¿Qué son?",
                "Los lenguajes de programación son herramientas que los programadores usan para comunicarse con las computadoras, cada uno con su propia sintaxis y propósito.",
              ),
              const SizedBox(height: 20),
              buildInfoCard(
                "¿Para qué funcionan?",
                "Permiten desarrollar software, desde páginas web (HTML) hasta aplicaciones móviles (Java) o programas de inteligencia artificial (Python).",
              ),
              const SizedBox(height: 20),
              const Center(
                child: Image(
                  image: AssetImage('assets/comoFunciona1.png'),
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Image(
                  image: AssetImage('assets/comoFunciona2.png'),
                  height: 250,
                  fit: BoxFit.cover,
                ),
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
                      if (userLevel == 3) {
                        await userService.updateUserLevel(4);
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
