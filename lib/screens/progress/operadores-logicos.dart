import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logic_lab/services/user_service.dart';

class LogicalOperatorsScreen extends StatefulWidget {
  const LogicalOperatorsScreen({super.key});

  @override
  State<LogicalOperatorsScreen> createState() => _LogicalOperatorsScreenState();
}

class _LogicalOperatorsScreenState extends State<LogicalOperatorsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTab = 0;
  
  // Variables para la sección de aprendizaje
  bool value1 = true;
  bool value2 = true;
  String selectedOperator = '&&';
  bool showExplanation = false;

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
        title: const Text("Operadores Lógicos"),
        bottom: TabBar(
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.school), text: "Aprende", ),
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

  Widget _buildLearningSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOperatorCard(
            "Operador AND (&&)",
            "El operador AND devuelve verdadero solo si ambas condiciones son verdaderas",
            _buildInteractiveANDGate(),
          ),
          const SizedBox(height: 20),
          _buildOperatorCard(
            "Operador OR (||)",
            "El operador OR devuelve verdadero si al menos una condición es verdadera",
            _buildInteractiveORGate(),
          ),
          const SizedBox(height: 20),
          _buildOperatorCard(
            "Operador NOT (!)",
            "El operador NOT invierte el valor de la condición",
            _buildInteractiveNOTGate(),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorCard(String title, String description, Widget interactive) {
    return Card(
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
              ),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 16),
            interactive,
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveANDGate() {
    bool result = value1 && value2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildValueToggle("Valor 1", value1, (v) => setState(() => value1 = v)),
            _buildValueToggle("Valor 2", value2, (v) => setState(() => value2 = v)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Resultado: ${result ? 'verdadero' : 'falso'}",
          style: TextStyle(
            fontSize: 18,
            color: result ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveORGate() {
    bool result = value1 || value2;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildValueToggle("Valor 1", value1, (v) => setState(() => value1 = v)),
            _buildValueToggle("Valor 2", value2, (v) => setState(() => value2 = v)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Resultado: ${result ? 'verdadero' : 'falso'}",
          style: TextStyle(
            fontSize: 18,
            color: result ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveNOTGate() {
    bool result = !value1;
    return Column(
      children: [
        _buildValueToggle("Valor", value1, (v) => setState(() => value1 = v)),
        const SizedBox(height: 16),
        Center(
          child: Text(
          "Resultado: ${result ? 'verdadero' : 'falso'}",
          style: TextStyle(
            fontSize: 18,
            color: result ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        )
      ],
    );
  }

  Widget _buildValueToggle(String label, bool value, Function(bool) onChanged) {
    return Column(
      children: [
        Text(label),
        Switch(
          activeColor: Colors.blue,
          value: value,
          onChanged: onChanged,
        ),
        Text(value ? 'verdadero' : 'falso'),
      ],
    );
  }

  Widget _buildExperimentSection() {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Laboratorio de Operadores",
                style: TextStyle(
                  fontSize: 24, 
                fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildValueToggle("Valor 1", value1, (v) => setState(() => value1 = v)),
                  DropdownButton<String>(
                    value: selectedOperator,
                    items: ['&&', '||', '!'].map((op) => DropdownMenuItem(
                      value: op,
                      child: Text(op, style: const TextStyle(fontSize: 24)),
                    )).toList(),
                    onChanged: (val) => setState(() => selectedOperator = val!),
                  ),
                  if (selectedOperator != '!')
                    _buildValueToggle("Valor 2", value2, (v) => setState(() => value2 = v)),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Resultado: ${_evaluateExpression() ? 'verdadero' : 'falso'}",
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _evaluateExpression() {
    switch (selectedOperator) {
      case '&&':
        return value1 && value2;
      case '||':
        return value1 || value2;
      case '!':
        return !value1;
      default:
        return false;
    }
  }

  Widget _buildPracticeSection() {
    // Esta sección la implementaremos en la siguiente parte
    return const PracticePage();
  }
}

class LogicPuzzle {
  final String question;
  final List<bool> inputs;
  final String operator;
  final bool expectedOutput;

  LogicPuzzle({
    required this.question,
    required this.inputs,
    required this.operator,
    required this.expectedOutput,
  });

  bool checkAnswer(bool answer) => answer == expectedOutput;

  // Lista predefinida de puzzles
  static List<LogicPuzzle> getAllPuzzles() {
    return [
      LogicPuzzle(
        question: "Si A es true Y B es true, ¿cuál será el resultado?",
        inputs: [true, true],
        operator: '&&',
        expectedOutput: true,
      ),
      LogicPuzzle(
        question: "Si A es true Y B es false, ¿cuál será el resultado?",
        inputs: [true, false],
        operator: '&&',
        expectedOutput: false,
      ),
      LogicPuzzle(
        question: "Si A es false O B es true, ¿cuál será el resultado?",
        inputs: [false, true],
        operator: '||',
        expectedOutput: true,
      ),
      LogicPuzzle(
        question: "Si negamos el valor true, ¿cuál será el resultado?",
        inputs: [true],
        operator: '!',
        expectedOutput: false,
      ),
      // Puedes agregar más puzzles aquí
    ];
  }
}

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  late List<LogicPuzzle> allPuzzles;
  late LogicPuzzle currentPuzzle;
  int currentPuzzleIndex = 0;
  int score = 0;
  bool? selectedAnswer;
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();
    allPuzzles = LogicPuzzle.getAllPuzzles();
    currentPuzzle = allPuzzles[currentPuzzleIndex];
  }

  void checkAnswer(bool answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      
      if (currentPuzzle.checkAnswer(answer)) {
        score += 10;
        
        // Programar el avance al siguiente puzzle
        Future.delayed(const Duration(seconds: 2), () async {
          if (mounted) {
            if (currentPuzzleIndex == allPuzzles.length - 1) {
              Navigator.pop(context);
              UserService userService = UserService();
              int? userLevel = await userService.getUserLevel();
              if (userLevel == 5) {
                await userService.updateUserLevel(6);
              }
            } else {
              setState(() {
                // Avanzar al siguiente puzzle
                currentPuzzleIndex++;
                currentPuzzle = allPuzzles[currentPuzzleIndex];
                selectedAnswer = null;
                showFeedback = false;
              });
            }
          }
        });


      } else {
        // Si la respuesta es incorrecta, solo limpiar el feedback después de 2 segundos
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
            _buildOperatorVisual(),
          ],
        ),
      ),
    );
  }

  Widget _buildOperatorVisual() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInputBox(currentPuzzle.inputs[0]),
          Text(
            currentPuzzle.operator,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (currentPuzzle.operator != '!' && currentPuzzle.inputs.length > 1)
            _buildInputBox(currentPuzzle.inputs[1]),
        ],
      ),
    );
  }

  Widget _buildInputBox(bool value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: value ? Colors.green.shade300 : Colors.red.shade300,
        borderRadius: BorderRadius.circular(4),

      ),
      child: Text(
        value ? 'true' : 'false',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAnswerSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: showFeedback ? null : () => checkAnswer(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(
                  'Verdadero',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: showFeedback ? null : () => checkAnswer(false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(
                  'Falso',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        if (showFeedback) ...[
          const SizedBox(height: 20),
          _buildFeedback(),
        ],
      ],
    );
  }

  Widget _buildFeedback() {
    final correct = selectedAnswer == currentPuzzle.expectedOutput;
    return Card(
      color: correct ? Colors.green : Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              correct ? Icons.check_circle : Icons.close,
              size: 48,
            ),
            const SizedBox(height: 8),
            Text(
              correct ? '¡Correcto!' : 'Incorrecto',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              correct
                  ? '+10 puntos'
                  : 'Inténtalo de nuevo',
              style: TextStyle(
                color: correct ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}