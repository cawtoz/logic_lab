import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/services/user_service.dart';

class ProgrammingLanguagesScreen extends StatelessWidget {
  const ProgrammingLanguagesScreen({super.key});

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
      appBar: const CustomAppBar(title: "¿Como funcionan las computadoras?"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "¿Qué es?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Una computadora combina hardware (partes físicas) y software (programas) para procesar, almacenar y mostrar datos.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "¿Para qué funciona?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Permite realizar cálculos, guardar información, mostrar resultados y ejecutar programas para resolver problemas o realizar tareas específicas.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ejemplo:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
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
                        "Supongamos que escribes un documento en una computadora.\n\n",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            '../assets/lenguasProgramacion.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "1. El hardware (teclado) recibe tu entrada.\n"
                        "2. El procesador convierte tu entrada en instrucciones.\n"
                        "3. El software (procesador de texto) organiza y muestra el contenido en pantalla.\n"
                        "4. El almacenamiento guarda el archivo en el disco.\n\n",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Explicación:",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Las computadoras son sistemas que combinan hardware y software para procesar datos y realizar tareas.",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ejercicio:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
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
                        "1. ¿Qué función realiza el procesador?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        questionIndex: 0,
                        options: const [
                          "Procesa datos e instrucciones.",
                          "Almacena datos para usarlos después.",
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "2. ¿Qué función realiza la memoria RAM?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        questionIndex: 1,
                        options: const [
                          "Almacena datos temporalmente para ser usados por programas.",
                          "Convierte datos en información gráfica.",
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "3. ¿Qué función realiza el disco duro?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        questionIndex: 2,
                        options: const [
                          "Almacena datos de forma permanente.",
                          "Muestra imágenes en la pantalla.",
                        ],
                      ),
                    ],
                  ),
                ),
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
                    if (QuestionWidget.isValid()) {
   
                      UserService userService = UserService();
                      int? userLevel = await userService.getUserLevel();
                      if (userLevel == 2) {
                        await userService.updateUserLevel(3);
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
                  child: const Text("Finalizar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class QuestionWidget extends StatefulWidget {
  final List<String> options;
  final int questionIndex;

  const QuestionWidget({super.key, required this.options, required this.questionIndex});

  static final Map<int, int?> _selections = {};

  // Respuestas correctas (por ejemplo, 0 es la respuesta correcta para la primera pregunta)
  static const Map<int, int> _correctAnswers = {
    0: 0, // La primera pregunta tiene como respuesta correcta "Procesa datos e instrucciones."
    1: 0, // La segunda pregunta tiene como respuesta correcta "Almacena datos temporalmente..."
    2: 0, // La tercera pregunta tiene como respuesta correcta "Almacena datos de forma permanente."
  };

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();

  static bool isValid() {
    // Verifica que todas las preguntas tengan respuesta seleccionada y sean correctas
    return _selections.length == 3 &&
        !_selections.values.contains(null) &&
        _selections.entries.every((entry) => entry.value == _correctAnswers[entry.key]);
  }
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedOption;

  @override
  void initState() {
    super.initState();
    // Inicializar la selección en caso de que ya haya alguna respuesta guardada
    selectedOption = QuestionWidget._selections[widget.questionIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        return RadioListTile<int>(
          title: Text(
            option,
            style: const TextStyle(color: Colors.white),
          ),
          value: index,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
              QuestionWidget._selections[widget.questionIndex] = value;
            });
          },
        );
      }).toList(),
    );
  }
}
