import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      appBar: CustomAppBar(title: "Logic Lab"),

      body: Column(
        children: <Widget>[
          //Rama de diseño de Brayan 
        ],
      )
      
    );
  }
  
}