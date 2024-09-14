import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';

class AdminScreen extends StatelessWidget {
  
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      appBar: CustomAppBar(title: "Administracion"),

      body: Column(
        children: <Widget>[
          // Agregar todo lo necesario aqui :)
        ],
      )
      
    );
  }
  
}