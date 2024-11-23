import 'package:flutter/material.dart';
import 'package:logic_lab/services/user_service.dart';

class VariablesAndDataTypesScreen extends StatefulWidget {
  const VariablesAndDataTypesScreen({super.key});

  @override
  State<VariablesAndDataTypesScreen> createState() => _VariablesAndDataTypesScreenState();
}

class _VariablesAndDataTypesScreenState extends State<VariablesAndDataTypesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Variables para el juego de tipos
  String? selectedType;
  String currentValue = "42";
  int score = 0;
  bool showFeedback = false;
  bool isCorrect = false;
  
  // Variables para el laboratorio
  String variableName = "";
  dynamic variableValue;
  List<Map<String, dynamic>> declaredVariables = [];
  
  final Map<String, List<String>> validValues = {
    'int': ['42', '-17', '0', '1000'],
    'double': ['3.14', '-0.5', '2.0', '100.75'],
    'String': ['"Hola"', '"Flutter"', '"2024"', '"true"'],
    'bool': ['true', 'false'],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _generateNewValue();
  }

  void _generateNewValue() {
    final allValues = validValues.values.expand((e) => e).toList();
    currentValue = allValues[DateTime.now().microsecond % allValues.length];
  }

  String _getCorrectType() {
    if (currentValue.startsWith('"')) return 'String';
    if (currentValue == 'true' || currentValue == 'false') return 'bool';
    if (currentValue.contains('.')) return 'double';
    return 'int';
  }

  void _checkAnswer(String type) {
    setState(() {
      selectedType = type;
      isCorrect = type == _getCorrectType();
      showFeedback = true;
      
      if (isCorrect) {
        score += 10;
      }
      
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            showFeedback = false;
            selectedType = null;
            _generateNewValue();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Variables y Tipos de Datos"),
        bottom: TabBar(
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.school), text: "Aprende"),
            Tab(icon: Icon(Icons.science), text: "Experimenta"),
            Tab(icon: Icon(Icons.games), text: "Practica"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLearningSection(),
          _buildLaboratorySection(),
          _buildPracticeSection(),
        ],
      ),
    );
  }

  Widget _buildLearningSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypeCard(
            "Enteros (int)",
            "Los números enteros son valores numéricos sin decimales.",
            ["42", "-17", "0", "1000"],
            Colors.blue.shade100,
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            "Decimales (double)",
            "Los números decimales pueden tener valores fraccionarios.",
            ["3.14", "-0.5", "2.0", "100.75"],
            Colors.green.shade100,
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            "Texto (String)",
            "Las cadenas de texto pueden contener cualquier carácter.",
            ['"Hola"', '"Flutter"', '"2024"', '"true"'],
            Colors.purple.shade100,
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            "Booleanos (bool)",
            "Los valores booleanos solo pueden ser verdadero o falso.",
            ["true", "false"],
            Colors.orange.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String title, String description, List<String> examples, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: examples.map((e) => Chip(
                label: Text(e),
                backgroundColor: Colors.black,
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPracticeSection() {
    return const PracticePage();
  }

  Widget _buildLaboratorySection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la variable',
                      hintText: 'Ejemplo: edad, nombre, precio',
                    ),
                    onChanged: (value) => setState(() => variableName = value),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                      hintText: 'Ejemplo: 25, "Juan", true, 3.14',
                    ),
                    onChanged: (value) => setState(() => variableValue = value),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (variableName.isNotEmpty && variableValue != null) {
                        setState(() {
                          declaredVariables.add({
                            'name': variableName,
                            'value': variableValue,
                            'type': _inferType(variableValue),
                          });
                          variableName = '';
                          variableValue = null;
                        });
                      }
                    },
                    child: const Text('Declarar Variable'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (declaredVariables.isNotEmpty)
            Card(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: declaredVariables.length,
                itemBuilder: (context, index) {
                  final variable = declaredVariables[index];
                  return ListTile(
                    title: Text('${variable['name']}: ${variable['value']}'),
                    subtitle: Text('Tipo: ${variable['type']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => setState(() => declaredVariables.removeAt(index)),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  String _inferType(String value) {
    if (value == 'true' || value == 'false') return 'bool';
    if (value.startsWith('"') && value.endsWith('"')) return 'String';
    if (value.contains('.')) return 'double';
    return 'int';
  }
}

class VariablePuzzle {
  final String question;
  final String value;
  final String expectedType;
  final String explanation;

  VariablePuzzle({
    required this.question,
    required this.value,
    required this.expectedType,
    required this.explanation,
  });

  bool checkAnswer(String answer) => answer == expectedType;

  static List<VariablePuzzle> getAllPuzzles() {
    return [
      VariablePuzzle(
        question: "¿Qué tipo de dato sería más apropiado para almacenar el siguiente valor?",
        value: "42",
        expectedType: "int",
        explanation: "Los números enteros sin decimales se almacenan como 'int'",
      ),
      VariablePuzzle(
        question: "Si queremos guardar el siguiente valor en una variable, ¿qué tipo deberíamos usar?",
        value: '"Juan"',
        expectedType: "String",
        explanation: "Los textos entre comillas se almacenan como 'String'",
      ),
      VariablePuzzle(
        question: "¿Qué tipo de dato es el más adecuado para este valor?",
        value: "3.14",
        expectedType: "double",
        explanation: "Los números con decimales se almacenan como 'double'",
      ),
      VariablePuzzle(
        question: "Para guardar el siguiente estado, ¿qué tipo de variable usarías?",
        value: "true",
        expectedType: "bool",
        explanation: "Los valores verdadero/falso se almacenan como 'bool'",
      ),
      VariablePuzzle(
        question: "¿Cuál es el tipo correcto para almacenar este valor de temperatura?",
        value: "-5.5",
        expectedType: "double",
        explanation: "Las temperaturas con decimales se almacenan como 'double'",
      ),
    ];
  }
}

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  late List<VariablePuzzle> allPuzzles;
  late VariablePuzzle currentPuzzle;
  int currentPuzzleIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool showFeedback = false;

  final List<String> dataTypes = ['int', 'double', 'String', 'bool'];

  @override
  void initState() {
    super.initState();
    allPuzzles = VariablePuzzle.getAllPuzzles();
    currentPuzzle = allPuzzles[currentPuzzleIndex];
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      
      if (currentPuzzle.checkAnswer(answer)) {
        score += 10;
        
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              if (currentPuzzleIndex == allPuzzles.length - 1) {
                // Al completar todos los puzzles, mostrar diálogo y volver
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text('¡Felicitaciones!'),
                    content: Text('Has completado todos los ejercicios\nPuntuación final: $score'),
                    actions: [
                      TextButton(
                        onPressed: () async {

                          Navigator.pop(context); // Cierra el diálogo
                          Navigator.pop(context);

                          UserService userService = UserService();
                          int? userLevel = await userService.getUserLevel();
                          if (userLevel == 6) {
                            await userService.updateUserLevel(7);
                          }
                           // Vuelve a la pantalla anterior
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                );
              } else {
                currentPuzzleIndex++;
                currentPuzzle = allPuzzles[currentPuzzleIndex];
                selectedAnswer = null;
                showFeedback = false;
              }
            });
          }
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              selectedAnswer = null;
              showFeedback = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProgressCard(),
          const SizedBox(height: 20),
          _buildPuzzleCard(),
          const SizedBox(height: 20),
          _buildAnswerSection(),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  'Pregunta',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '${currentPuzzleIndex + 1}/${allPuzzles.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Puntuación',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  score.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPuzzleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '¡Identifica el Tipo!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              currentPuzzle.question,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentPuzzle.value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection() {
    if (showFeedback) {
      return _buildFeedback();
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dataTypes.map((type) => SizedBox(
        width: (MediaQuery.of(context).size.width - 42) / 2,
        child: ElevatedButton(
          onPressed: () => checkAnswer(type),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: _getColorForType(type),
          ),
          child: Text(
            type,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      )).toList(),
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'int':
        return Colors.blue.shade100;
      case 'double':
        return Colors.green.shade100;
      case 'String':
        return Colors.purple.shade100;
      case 'bool':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  Widget _buildFeedback() {
    final correct = selectedAnswer == currentPuzzle.expectedType;
    return Card(
      color: correct ? Colors.green.shade100 : Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              correct ? Icons.check_circle : Icons.close,
              color: correct ? Colors.green : Colors.red,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              correct ? '¡Correcto!' : 'Incorrecto',
              style: TextStyle(
                fontSize: 20,
                color: correct ? Colors.green.shade900 : Colors.red.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              correct ? '+10 puntos' : currentPuzzle.explanation,
              style: TextStyle(
                color: correct ? Colors.green.shade900 : Colors.red.shade900,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}