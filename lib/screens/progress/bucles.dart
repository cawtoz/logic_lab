import 'package:flutter/material.dart';
import 'package:logic_lab/services/user_service.dart';

class LoopsScreen extends StatefulWidget {
  const LoopsScreen({super.key});

  @override
  State<LoopsScreen> createState() => _LoopsScreenState();
}

class _LoopsScreenState extends State<LoopsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
  
  // Variables para la sección de aprendizaje
  int iterationCount = 5;
  String selectedLoop = 'for';
  bool isRunning = false;
  List<String> outputList = [];

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
        title: const Text("Bucles de Programación"),
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
          _buildPracticeSection(),
        ],
      ),
    );
  }

  Widget _buildPracticeSection() {
    return const PracticePage();
  }

  Widget _buildLearningSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLoopCard(
            "Bucle For",
            "El bucle for se utiliza cuando sabes exactamente cuántas veces quieres repetir una acción.",
            _buildInteractiveForLoop(),
            Colors.blue.shade100
          ),
          const SizedBox(height: 20),
          _buildLoopCard(
            "Bucle While",
            "El bucle while se ejecuta mientras una condición sea verdadera.",
            _buildInteractiveWhileLoop(),
            Colors.green.shade100
          ),
          const SizedBox(height: 20),
          _buildLoopCard(
            "Bucle Do-While",
            "Similar al while, pero garantiza al menos una ejecución del código.",
            _buildInteractiveDoWhileLoop(),
            Colors.purple.shade100
          ),
        ],
      ),
    );
  }

  Widget _buildLoopCard(String title, String description, Widget interactive, Color color) {
    return Card(
      color: color,
      elevation: 4,
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
            const SizedBox(height: 12),
            Text(description, style: const TextStyle(color: Colors.black)),
            const SizedBox(height: 16),
            interactive,
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveForLoop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Número de iteraciones:", style: const TextStyle(color: Colors.black)),
                  Slider(
                    value: iterationCount.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: iterationCount.toString(),
                    onChanged: (value) {
                      setState(() {
                        iterationCount = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Código:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '''
for (int i = 0; i < $iterationCount; i++) {
    print("Iteración \${i + 1}");
}''',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildInteractiveWhileLoop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Condición hasta:"),
                  Slider(
                    value: iterationCount.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: iterationCount.toString(),
                    onChanged: (value) {
                      setState(() {
                        iterationCount = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Código:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '''
int count = 1;
while (count <= $iterationCount) {
    print("Vuelta \$count");
    count++;
}''',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildInteractiveDoWhileLoop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Repetir hasta:"),
                  Slider(
                    value: iterationCount.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: iterationCount.toString(),
                    onChanged: (value) {
                      setState(() {
                        iterationCount = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Código:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '''
int count = 1;
do {
    print("Iteración \$count");
    count++;
} while (count <= $iterationCount);''',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Métodos para ejecutar los bucles
  void _runForLoop() async {
    setState(() {
      isRunning = true;
      outputList.clear();
    });

    for (int i = 0; i < iterationCount; i++) {
      setState(() {
        outputList.add("Iteración ${i + 1}");
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }

    setState(() {
      isRunning = false;
    });
  }

  void _runWhileLoop() async {
    setState(() {
      isRunning = true;
      outputList.clear();
    });

    int count = 1;
    while (count <= iterationCount) {
      setState(() {
        outputList.add("Vuelta $count");
      });
      await Future.delayed(const Duration(milliseconds: 500));
      count++;
    }

    setState(() {
      isRunning = false;
    });
  }

  void _runDoWhileLoop() async {
    setState(() {
      isRunning = true;
      outputList.clear();
    });

    int count = 1;
    do {
      setState(() {
        outputList.add("Iteración $count");
      });
      await Future.delayed(const Duration(milliseconds: 500));
      count++;
    } while (count <= iterationCount);

    setState(() {
      isRunning = false;
    });
  }

  Widget _buildExperimentSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Laboratorio de Bucles",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Selecciona el tipo de bucle y configura las iteraciones para ver cómo funciona:",
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedLoop,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: 'for',
                          child: Text('Bucle For'),
                        ),
                        DropdownMenuItem(
                          value: 'while',
                          child: Text('Bucle While'),
                        ),
                        DropdownMenuItem(
                          value: 'dowhile',
                          child: Text('Bucle Do-While'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedLoop = value!;
                          outputList.clear();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Iteraciones:"),
                        Slider(
                          value: iterationCount.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: iterationCount.toString(),
                          onChanged: (value) {
                            setState(() {
                              iterationCount = value.round();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: isRunning
                      ? null
                      : () {
                          switch (selectedLoop) {
                            case 'for':
                              _runForLoop();
                              break;
                            case 'while':
                              _runWhileLoop();
                              break;
                            case 'dowhile':
                              _runDoWhileLoop();
                              break;
                          }
                        },
                  child: const Text("Ejecutar bucle"),
                ),
              ),
              const SizedBox(height: 20),
              if (outputList.isNotEmpty) ...[
                const Text(
                  "Resultado:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 200,
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    itemCount: outputList.length,
                    itemBuilder: (context, index) {
                      return Text(
                        outputList[index],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  }
  
  class LoopPuzzle {
  final String question;
  final String code;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  LoopPuzzle({
    required this.question,
    required this.code,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  bool checkAnswer(int answer) => answer == correctAnswer;

  static List<LoopPuzzle> getAllPuzzles() {
    return [
      LoopPuzzle(
        question: "¿Cuántas veces se ejecutará este bucle for?",
        code: '''
for (int i = 0; i < 5; i++) {
    print(i);
}''',
        options: ["3 veces", "4 veces", "5 veces", "6 veces"],
        correctAnswer: 2,
        explanation: "El bucle se ejecuta 5 veces, comenzando desde 0 hasta 4 (i < 5).",
      ),
      LoopPuzzle(
        question: "¿Cuál será la salida de este bucle while?",
        code: '''
int x = 1;
while (x < 4) {
    print(x);
    x++;
}''',
        options: ["1, 2", "1, 2, 3", "1, 2, 3, 4", "0, 1, 2, 3"],
        correctAnswer: 1,
        explanation: "El bucle imprime 1, 2, 3 ya que se ejecuta mientras x sea menor que 4.",
      ),
      LoopPuzzle(
        question: "¿Cuántas veces se ejecutará este bucle do-while?",
        code: '''
int n = 5;
do {
    print(n);
    n--;
} while (n > 0);''',
        options: ["4 veces", "5 veces", "6 veces", "0 veces"],
        correctAnswer: 1,
        explanation: "El bucle se ejecuta 5 veces, imprimiendo 5, 4, 3, 2, 1.",
      ),
      LoopPuzzle(
        question: "¿Qué sucederá con este bucle for?",
        code: '''
for (int i = 10; i >= 0; i -= 2) {
    print(i);
}''',
        options: [
          "Imprime números del 10 al 0 de 2 en 2",
          "Imprime números del 0 al 10 de 2 en 2",
          "Se ejecuta infinitamente",
          "Da error de compilación"
        ],
        correctAnswer: 0,
        explanation: "El bucle imprime 10, 8, 6, 4, 2, 0 decrementando de 2 en 2.",
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProgressCard(),
          const SizedBox(height: 16),
          _buildPuzzleCard(),
          const SizedBox(height: 16),
          _buildAnswerSection(),
        ],
      ),
    );
  }

  late List<LoopPuzzle> allPuzzles;
  late LoopPuzzle currentPuzzle;
  int currentPuzzleIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    allPuzzles = LoopPuzzle.getAllPuzzles();
    currentPuzzle = allPuzzles[currentPuzzleIndex];
  }

  void checkAnswer(int answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      
      if (currentPuzzle.checkAnswer(answer)) {
        score += 25;
        
        Future.delayed(const Duration(seconds: 2), () async {
          if (mounted) {
            if (currentPuzzleIndex == allPuzzles.length - 1) {
              // Realizar la lógica asincrónica antes de actualizar el estado
              UserService userService = UserService();
              int? userLevel = await userService.getUserLevel();
              if (userLevel == 8) {
                await userService.updateUserLevel(9);
              }
              // Actualizar el estado y mostrar el diálogo de finalización
              setState(() {
                showCompletionDialog();
              });
            } else {
   
              // Avanzar al siguiente puzzle
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
                "Has completado todos los ejercicios\nPuntuación final: $score/100",
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
                  'Ejercicio',
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
              currentPuzzle.question,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentPuzzle.code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16,
                  color: Colors.black
                ),
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
        ...List.generate(
          currentPuzzle.options.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: showFeedback ? null : () => checkAnswer(index),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: selectedAnswer == index
                    ? (currentPuzzle.checkAnswer(index)
                        ? Colors.green[100]
                        : Colors.red[100])
                    : null,
              ),
              child: Text(
                currentPuzzle.options[index],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        if (showFeedback) ...[
          const SizedBox(height: 20),
          Card(
            color: currentPuzzle.checkAnswer(selectedAnswer!)
                ? Colors.green[100]
                : Colors.red[100],
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
                        ? "¡Correcto! +25 puntos"
                        : "Incorrecto",
                    style: TextStyle(
                      fontSize: 18,
                      color: currentPuzzle.checkAnswer(selectedAnswer!)
                          ? Colors.green[900]
                          : Colors.red[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentPuzzle.explanation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentPuzzle.checkAnswer(selectedAnswer!)
                          ? Colors.green[900]
                          : Colors.red[900],
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
