import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/services/user_service.dart';

class ProgrammingDefinitionScreen extends StatefulWidget {
  const ProgrammingDefinitionScreen({super.key});

  @override
  State<ProgrammingDefinitionScreen> createState() => _ProgrammingDefinitionScreenState();
}

class _ProgrammingDefinitionScreenState extends State<ProgrammingDefinitionScreen> {
  // Controladores para los TextField
  final TextEditingController step1Controller = TextEditingController();
  final TextEditingController step2Controller = TextEditingController();
  final TextEditingController step3Controller = TextEditingController();
  final TextEditingController step4Controller = TextEditingController();

  // Respuestas correctas
  final Map<int, String> correctAnswers = {
    1: "pan",
    2: "mantequilla",
    3: "pollo y queso",
    4: "come",
  };

  // Método para validar las respuestas
  bool _validateInputs() {
    return step1Controller.text.trim().toLowerCase() == correctAnswers[1] &&
        step2Controller.text.trim().toLowerCase() == correctAnswers[2] &&
        step3Controller.text.trim().toLowerCase() == correctAnswers[3] &&
        step4Controller.text.trim().toLowerCase() == correctAnswers[4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "¿Qué es la programación?"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "¿Qué es la programación?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Tarjeta para "¿Qué es?"
              buildCard(
                title: "¿Qué es?",
                content:
                    "La programación es el proceso de crear instrucciones que una computadora puede entender y ejecutar para realizar tareas o resolver problemas.",
              ),

              // Tarjeta para "¿Para qué funciona?"
              buildCard(
                title: "¿Para qué funciona?",
                content:
                    "Sirve para automatizar tareas, construir aplicaciones y sistemas, y resolver problemas de forma lógica y estructurada.",
              ),

              // Tarjeta de ejemplo
              buildCard(
                title: "Ejemplo:",
                content:
                    "Supongamos que quieres explicarle a alguien cómo preparar un sándwich.",
                imagePath: 'assets/sandwich.png',
                footer:
                    "Relación con programación: Cada paso es una instrucción que la persona sigue para completar una tarea. En programación, estas instrucciones son las líneas de código.",
              ),

              const SizedBox(height: 20),
              const Text(
                "Ejercicio:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Crea un sándwich de pollo.",
                style: TextStyle(
                  color: Color.fromARGB(255, 200, 200, 200),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Inputs para completar
              buildExerciseInput("1. Toma dos rebanadas de ", "pan/tomate", step1Controller),
              buildExerciseInput("2. Unta ", "mantequilla/agua", step2Controller),
              buildExerciseInput("3. Coloca ", "pollo y queso/carne y queso", step3Controller),
              buildExerciseInput("4. Pon la otra rebanada encima y ", "come/juega", step4Controller),

              const SizedBox(height: 20),

              // Botón "Completar"
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
                    if (_validateInputs()) {
                      UserService userService = UserService();
                      int? userLevel = await userService.getUserLevel();
                      if (userLevel == 1) {
                        await userService.updateUserLevel(2);
                      }
                      showCompletionDialog();
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Respuestas incorrectas"),
                          content: const Text("Por favor verifica tus respuestas e intenta nuevamente."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Aceptar"),
                            ),
                          ],
                        ),
                      );
                    }
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
                step1Controller.clear();
                step2Controller.clear();
                step3Controller.clear();
                step4Controller.clear();
              },
              child: const Text("Volver a intentar"),
            ),
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


  // Widget para tarjetas
  Widget buildCard({
    required String title,
    required String content,
    String? imagePath,
    String? footer,
  }) {
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
              content,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
            if (imagePath != null) ...[
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  imagePath,
                  height: 450,
                ),
              ),
            ],
            if (footer != null) ...[
              const SizedBox(height: 10),
              Text(
                footer,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.justify,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget para inputs de ejercicio
  Widget buildExerciseInput(String text, String hint, TextEditingController controller) {
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
              controller: controller,
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

  @override
  void dispose() {
    // Liberar los controladores para evitar fugas de memoria
    step1Controller.dispose();
    step2Controller.dispose();
    step3Controller.dispose();
    step4Controller.dispose();
    super.dispose();
  }
}
