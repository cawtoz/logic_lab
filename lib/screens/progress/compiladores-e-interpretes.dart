import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class CompilersAndInterpretersScreen extends StatelessWidget {
  const CompilersAndInterpretersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Compiladores e intérpretes"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "¿Qué son?",
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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Son herramientas que traducen el código escrito por los programadores en un lenguaje que la computadora puede entender.\n\n"
                    "Compiladores: Traducen todo el programa antes de ejecutarlo.\n"
                    "ntérpretes: Traducen y ejecutan línea por línea.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "¿Para qué funcionan?",
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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Permiten que los programas escritos en lenguajes de programación funcionen en computadoras u otros dispositivos.",
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
              Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "1. Piensa en traducir un libro completo a otro idioma:\n"
                    "Compilador: Traduce todo el libro de una vez antes de entregarlo.\n"
                    "Intérprete: Traduce una página a la vez mientras alguien la lee.\n\n"
                    "2. Lenguajes que usan compiladores: C, Java.\n"
                    "3. Lenguajes que usan intérpretes: Python, JavaScript.",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.justify,
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
                        "Relaciona cada tipo de traductor con su descripción:",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QuestionWidget(
                        question: "Compilador",
                        options: const [
                          "Traduce todo el programa de una vez antes de ejecutarlo.",
                          "Traduce y ejecuta línea por línea mientras se ejecuta.",
                        ],
                      ),
                      const SizedBox(height: 20),
                      QuestionWidget(
                        question: "Intérprete",
                        options: const [
                          "Traduce todo el programa de una vez antes de ejecutarlo.",
                          "Traduce y ejecuta línea por línea mientras se ejecuta.",
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
  final String question;
  final List<String> options;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.options,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          widget.question,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        ...widget.options.asMap().entries.map((entry) {
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
      ],
    );
  }
}
