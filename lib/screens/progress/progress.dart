import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'que-es-la-programacion.dart';
import 'lenguajes-de-programacion.dart';
import 'compiladores-e-interpretes.dart';
import 'como-funcionan-las-computadoras.dart';
import 'operadores-logicos.dart';
import 'variables-y-tipos-de-datos.dart';
import 'entradas-y-salidas-de-datos.dart';
import 'tablas-de-verdad-y-logica.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Progreso"),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Pensamiento Algorítmico',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              const SizedBox(height: 10),

              LinearProgressIndicator(
                value: 0.3,
                backgroundColor: Colors.grey[700],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(height: 20),

              buildSectionTile('Introducción', true, [
                '¿Qué es la programación?',
                'Cómo funcionan las computadoras',
                'Lenguajes de programación: una visión general',
                'Compiladores e intérpretes',
              ]),
              buildSectionTile('Lógica Básica', false, [
                'Operadores lógicos y matemáticos',
                'Variables y tipos de datos',
                'Entrada y salida de datos',
                'Tablas de verdad y lógica condicional',
              ]),
              buildSectionTile('Algoritmo y Pseudocódigo', false, [
                '¿Qué es un algoritmo?',
                'Cómo escribir pseudocódigo',
                'Diagramas de flujo',
                'Ejemplos prácticos de algoritmos simples',
              ]),
              buildSectionTile('Estructura de Control', false, [
                'Estructuras condicionales (if-else, switch)',
                'Bucles (for, while)',
                'Control de flujo con operadores lógicos',
                'Manejo de excepciones y errores básicos',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTile(String title, bool isUnlocked, List<String> buttonNames) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        maintainState: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(
          isUnlocked ? Icons.lock_open : Icons.lock,
          color: isUnlocked ? Colors.green : Colors.grey,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
              ),
              itemCount: buttonNames.length,
              itemBuilder: (context, index) {
                return buildTextButton(context, buttonNames[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextButton(BuildContext context, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      ),
      onPressed: () {
        if (text == '¿Qué es la programación?') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProgrammingDefinitionScreen(),
            ),
          );
        } else if (text == 'Lenguajes de programación: una visión general') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HowComputersWorkScreen(),
            ),
          );
        } else if (text == 'Cómo funcionan las computadoras') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProgrammingLanguagesScreen(),
            ),
          );
        } else if (text == 'Compiladores e intérpretes') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompilersAndInterpretersScreen(),
            ),
          );
        } else if (text == 'Operadores lógicos y matemáticos') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogicalOperatorsScreen(),
            ),
          );
        } else if (text == 'Variables y tipos de datos') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VariablesAndDataTypesScreen(),
            ),
          );
        } else if (text == 'Entrada y salida de datos') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InputAndOutputScreen(),
            ),
          );
        } else if (text == 'Tablas de verdad y lógica condicional') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TruthTablesAndLogicScreen(),
            ),
          );
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
