import 'package:flutter/material.dart';
import 'package:logic_lab/services/user_service.dart';

class ConditionalStructuresScreen extends StatefulWidget {
  const ConditionalStructuresScreen({super.key});

  @override
  State<ConditionalStructuresScreen> createState() => _ConditionalStructuresScreenState();
}

class _ConditionalStructuresScreenState extends State<ConditionalStructuresScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
  
  // Variables para la sección experimental
  int age = 18;
  String dayOfWeek = 'Lunes';
  double temperature = 25;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estructuras Condicionales"),
        bottom: TabBar(
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
          _buildExperimentSection(),
          const PracticePage(),
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
          _buildConceptCard(
            "if-else",
            "La estructura if-else permite ejecutar código basado en una condición",
            '''
if (edad >= 18) {
    print("Eres mayor de edad");
} else {
    print("Eres menor de edad");
}''',
            Colors.blue.shade100,
          ),
          const SizedBox(height: 16),
          _buildConceptCard(
            "else if",
            "Puedes agregar múltiples condiciones usando else if",
            '''
if (temperatura < 10) {
    print("Hace frío");
} else if (temperatura < 25) {
    print("Temperatura agradable");
} else {
    print("Hace calor");
}''',
            Colors.green.shade100,
          ),
          const SizedBox(height: 16),
          _buildConceptCard(
            "switch",
            "La estructura switch es útil cuando tienes múltiples casos específicos",
            '''
switch (diaSemana) {
    case "Lunes":
        print("Inicio de semana");
        break;
    case "Viernes":
        print("¡Fin de semana!");
        break;
    default:
        print("Día normal");
}''',
            Colors.purple.shade100,
          ),
          const SizedBox(height: 16),
          _buildConceptCard(
            "Operador Ternario",
            "Una forma corta de escribir una condición simple",
            '''
String mensaje = edad >= 18 
    ? "Mayor de edad" 
    : "Menor de edad";''',
            Colors.orange.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildConceptCard(String title, String description, String codeExample, Color color) {
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
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                codeExample,
                style: const TextStyle(
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperimentSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExperimentCard(
            "Experimento con if-else",
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Edad actual: $age"),
                Slider(
                  value: age.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: age.toString(),
                  onChanged: (value) => setState(() => age = value.round()),
                ),
                Text(
                  age >= 18 ? "Eres mayor de edad" : "Eres menor de edad",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildExperimentCard(
            "Experimento con switch",
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: dayOfWeek,
                  isExpanded: true,
                  items: [
                    'Lunes',
                    'Martes',
                    'Miércoles',
                    'Jueves',
                    'Viernes',
                    'Sábado',
                    'Domingo'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => dayOfWeek = value);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  _getDayMessage(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildExperimentCard(
            "Experimento con else-if",
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Temperatura actual: ${temperature.toStringAsFixed(1)}°C"),
                Slider(
                  value: temperature,
                  min: -10,
                  max: 40,
                  divisions: 100,
                  label: temperature.toStringAsFixed(1),
                  onChanged: (value) => setState(() => temperature = value),
                ),
                Text(
                  _getTemperatureMessage(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperimentCard(String title, Widget content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  String _getDayMessage() {
    switch (dayOfWeek) {
      case 'Lunes':
        return "Inicio de semana";
      case 'Martes':
      case 'Miércoles':
      case 'Jueves':
        return "Entre semana";
      case 'Viernes':
        return "¡Casi fin de semana!";
      case 'Sábado':
      case 'Domingo':
        return "¡Fin de semana!";
      default:
        return "Día no válido";
    }
  }

  String _getTemperatureMessage() {
    if (temperature < 10) {
      return "Hace frío";
    } else if (temperature < 25) {
      return "Temperatura agradable";
    } else {
      return "Hace calor";
    }
  }
}

class ConditionalPuzzle {
  final String question;
  final Map<String, dynamic> scenario;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  ConditionalPuzzle({
    required this.question,
    required this.scenario,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  bool checkAnswer(String answer) => answer == correctAnswer;

  static List<ConditionalPuzzle> getAllPuzzles() {
    return [
      ConditionalPuzzle(
        question: "¿Qué mensaje se mostrará con las siguientes condiciones?",
        scenario: {
          'edad': 15,
          'code': '''
if (edad >= 18) {
    mensaje = "Mayor de edad";
} else {
    mensaje = "Menor de edad";
}''',
        },
        options: [
          "Mayor de edad",
          "Menor de edad",
          "Error de compilación",
          "Ningún mensaje",
        ],
        correctAnswer: "Menor de edad",
        explanation: "Como la edad (15) es menor que 18, se ejecuta el bloque else",
      ),
      ConditionalPuzzle(
        question: "Con la siguiente temperatura, ¿qué se imprimirá?",
        scenario: {
          'temperatura': 23,
          'code': '''
if (temperatura < 10) {
    print("Frío");
} else if (temperatura < 25) {
    print("Agradable");
} else {
    print("Calor");
}''',
        },
        options: [
          "Frío",
          "Agradable",
          "Calor",
          "Ninguna de las anteriores",
        ],
        correctAnswer: "Agradable",
        explanation: "23°C es menor que 25 pero mayor que 10, por lo que se ejecuta el bloque else if",
      ),
      ConditionalPuzzle(
        question: "¿Qué mensaje se mostrará para este día de la semana?",
        scenario: {
          'dia': "Sábado",
          'code': '''
switch (dia) {
    case "Lunes":
        mensaje = "Trabajo";
        break;
    case "Sábado":
    case "Domingo":
        mensaje = "Descanso";
        break;
    default:
        mensaje = "Rutina";
}''',
        },
        options: [
          "Trabajo",
          "Descanso",
          "Rutina",
          "Error",
        ],
        correctAnswer: "Descanso",
        explanation: "Los casos Sábado y Domingo comparten el mismo resultado",
      ),
      ConditionalPuzzle(
        question: "¿Cuál será el valor de la variable resultado?",
        scenario: {
          'puntos': 75,
          'code': '''
String resultado = puntos >= 60 ? "Aprobado" : "Reprobado";''',
        },
        options: [
          "Aprobado",
          "Reprobado",
          "Error de sintaxis",
          "Ninguno",
        ],
        correctAnswer: "Aprobado",
        explanation: "El operador ternario asigna 'Aprobado' porque 75 es mayor que 60",
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
  late List<ConditionalPuzzle> allPuzzles;
  late ConditionalPuzzle currentPuzzle;
  int currentPuzzleIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    allPuzzles = ConditionalPuzzle.getAllPuzzles();
    currentPuzzle = allPuzzles[currentPuzzleIndex];
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      
      if (currentPuzzle.checkAnswer(answer)) {
        score += 10;

        Future.delayed(const Duration(seconds: 2), () async {
          if (mounted) {
            if (currentPuzzleIndex == allPuzzles.length - 1) {

              // Lógica asincrónica antes de actualizar el estado
              UserService userService = UserService();
              int? userLevel = await userService.getUserLevel();
              if (userLevel == 7) {
                await userService.updateUserLevel(8);
              }

       
              // Mostrar el diálogo de finalización
              setState(() {
                showCompletionDialog();
              });
 
            } else {
              // Actualizar el estado para avanzar al siguiente puzzle
              setState(() {
                currentPuzzleIndex++;
                currentPuzzle = allPuzzles[currentPuzzleIndex];
                selectedAnswer = null;
                showFeedback = false;
              });
            }
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
                "Has completado todos los ejercicios\nPuntuación final: $score/40",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentPuzzleIndex = 0;
                  currentPuzzle = allPuzzles[currentPuzzleIndex];
                  score = 0;
                  selectedAnswer = null;
                  showFeedback = false;
                });
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
              '¡Resuelve el Puzzle!',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (currentPuzzle.scenario.containsKey('edad'))
                    Text('Edad: ${currentPuzzle.scenario['edad']}'),
                  if (currentPuzzle.scenario.containsKey('temperatura'))
                    Text('Temperatura: ${currentPuzzle.scenario['temperatura']}°C'),
                  if (currentPuzzle.scenario.containsKey('dia'))
                    Text('Día: ${currentPuzzle.scenario['dia']}'),
                  if (currentPuzzle.scenario.containsKey('puntos'))
                    Text('Puntos: ${currentPuzzle.scenario['puntos']}'),
                  const SizedBox(height: 8),
                  Text(
                    currentPuzzle.scenario['code'],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection() {
    return Column(
      children: [
        ...currentPuzzle.options.map((option) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ElevatedButton(
            onPressed: showFeedback ? null : () => checkAnswer(option),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(option),
          ),
        )),
        if (showFeedback) ...[
          const SizedBox(height: 20),
          Card(
            color: currentPuzzle.checkAnswer(selectedAnswer!)
                ? Colors.green.shade100
                : Colors.red.shade100,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    currentPuzzle.checkAnswer(selectedAnswer!)
                        ? Icons.check_circle
                        : Icons.close,
                    color: currentPuzzle.checkAnswer(selectedAnswer!)
                        ? Colors.green
                        : Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPuzzle.checkAnswer(selectedAnswer!)
                        ? '¡Correcto!'
                        : 'Incorrecto',
                    style: TextStyle(
                      fontSize: 20,
                      color: currentPuzzle.checkAnswer(selectedAnswer!)
                          ? Colors.green.shade900
                          : Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPuzzle.explanation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentPuzzle.checkAnswer(selectedAnswer!)
                          ? Colors.green.shade900
                          : Colors.red.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}