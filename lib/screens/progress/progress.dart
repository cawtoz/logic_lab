import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class ProgressScreen extends StatelessWidget {
  
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      appBar: CustomAppBar(title: "Progreso"),

      body: Column(
        children: <Widget>[
          // Agregar todo lo necesario aqui :)
        ],
      )
      
    );
  }
  
}