import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Progreso"),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Pensamiento Algorítmico',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(height: 10),

            // Barra de progreso
            LinearProgressIndicator(
              value: 0.3, // Progreso
              backgroundColor: Colors.grey[700],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 20),

            // Secciones con Dropdown
            buildSectionTile('Introducción', true),
            buildSectionTile('Lógica Básica', false),
            buildSectionTile('Algoritmos y Pseudocódigo', false),
            buildSectionTile('Estructuras de Control', false),
          ],
        ),
      ),
    );
  }

  // Función para crear un widget con estilo de Dropdown
  Widget buildSectionTile(String title, bool isUnlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), // Espaciado entre secciones
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white), // Contorno blanco
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
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
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Contenido de $title',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
