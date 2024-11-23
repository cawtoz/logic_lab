import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/screens/progress/bucles.dart';
import 'package:logic_lab/screens/progress/como-funcionan-las-computadoras.dart';
import 'package:logic_lab/screens/progress/compiladores-e-interpretes.dart';
import 'package:logic_lab/screens/progress/estructuras-condicionales.dart';
import 'package:logic_lab/screens/progress/lenguajes-de-programacion.dart';
import 'package:logic_lab/screens/progress/operadores-logicos.dart';
import 'package:logic_lab/screens/progress/que-es-la-programacion.dart';
import 'package:logic_lab/screens/progress/variables-y-tipos-de-datos.dart';
import 'package:logic_lab/services/user_service.dart';

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

              // Barra de progreso con el nivel del usuario
              FutureBuilder<int?>(
                future: UserService().getUserLevel(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();  // Cargando
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error al obtener nivel del usuario',
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    int? userLevel = snapshot.data ;

                    if (userLevel == null) {
                      return const Text(
                        'Nivel de usuario no encontrado',
                        style: TextStyle(color: Colors.red),
                      );
                    }

                    double progress = (userLevel - 1) / 8;
                    if (progress > 1.0) {
                      progress = 1.0;
                    }

                    return LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[700],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    );
                  } else {
                    return const Text('No hay datos disponibles');
                  }
                },
              ),

              const SizedBox(height: 20),

              buildSectionTile('Introducción', [
                '¿Qué es la programación?',
                'Cómo funcionan las computadoras',
                'Lenguajes de programación: una visión general',
                'Compiladores e intérpretes',
              ],
              [1, 2, 3, 4],
              ),
              buildSectionTile('Lógica Básica', [
                'Operadores lógicos y matemáticos',
                'Variables y tipos de datos',
              ],
              [5, 6],
              ),
              buildSectionTile('Estructura de Control', [
                'Estructuras condicionales (if-else, switch)',
                'Bucles (for, while)',
              ],
              [7, 8],
              ),
            ],
          ),
        ),
      ),
    );
  }

Widget buildSectionTile(String title, List<String> buttonNames, List<int> levels) {
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
      leading: FutureBuilder<int?>(
        future: UserService().getUserLevel(), // Fetch user level
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return const Icon(Icons.error, color: Colors.red); // Handle errors
          } else if (snapshot.hasData) {
            int? userLevel = snapshot.data;

            // Ensure userLevel is not null
            if (userLevel == null) {
              return const Icon(Icons.lock, color: Colors.grey); // Default to locked if no level is found
            }

            int minLevel = levels[0];

            // Return the lock icon based on level comparison
            return Icon(
              minLevel <= userLevel ? Icons.lock_open : Icons.lock,
              color: minLevel <= userLevel ? Colors.green : Colors.grey,
            );
          } else {
            return const Icon(Icons.lock, color: Colors.grey); // Default to locked if no data
          }
        },
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
              return buildTextButton(context, buttonNames[index], levels[index]);
            },
          ),
        ),
      ],
    ),
  );
}

  Widget buildTextButton(BuildContext context, String text, level) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      ),
      onPressed: () async {
        UserService userService = UserService();
        int? userLevel = await userService.getUserLevel();

        if (level > userLevel) {
          return;
        }

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
        } else if (text == 'Estructuras condicionales (if-else, switch)') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConditionalStructuresScreen(),
            ),
          );
        } else if (text == 'Bucles (for, while)') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoopsScreen(),
            ),
          );
        }
      },
      child: Text(
        '${text} ${level}',
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
