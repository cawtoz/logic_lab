import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class ProgrammingLanguagesScreen extends StatelessWidget {
  const ProgrammingLanguagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.cyanAccent,
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
                  color: Colors.cyanAccent,
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
                  color: Colors.cyanAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Ejemplo con imagen y explicación
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

                      // Imagen
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            '../assets/lenguasProgramacion.png', // Ruta de tu imagen
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Texto de ejemplo
                      const Text(
                        "1. El hardware (teclado) recibe tu entrada.\n"
                        "2. El procesador convierte tu entrada en instrucciones.\n"
                        "3. El software (procesador de texto) organiza y muestra el contenido en pantalla.\n"
                        "4. El almacenamiento guarda el archivo en el disco.\n\n",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),

                      // Explicación
                      const SizedBox(height: 10),
                      const Text(
                        "Explicación:",
                        style: TextStyle(
                          color: Colors.cyanAccent,
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
                  color: Colors.cyanAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Ejercicio con preguntas
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
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        options: const [
                          "Procesa datos e instrucciones.",
                          "Almacena datos para usarlos después.",
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        "2. ¿Qué función realiza la memoria RAM?",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        options: const [
                          "Almacena datos temporalmente para ser usados por programas.",
                          "Convierte datos en información gráfica.",
                        ],
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        "3. ¿Qué función realiza el disco duro?",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
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

              // Botón de Finalizar
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
}

class QuestionWidget extends StatefulWidget {
  final List<String> options;

  const QuestionWidget({super.key, required this.options});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;

        return RadioListTile<int>(
          value: index,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value;
            });
          },
          title: Text(
            option,
            style: const TextStyle(color: Colors.white),
          ),
          activeColor: Colors.cyanAccent,
        );
      }).toList(),
    );
  }
}
