import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/screens/progress/progress.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Logic Lab"),

      body: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Column al contenido
        children: <Widget>[
          const SizedBox(height: 25), //Espacio entre el appBar y el icono
          
          // Primera sección con el texto centrado
          const Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el texto horizontalmente
            children: [
              CircleAvatar( //icono
                  radius: 70,
                  backgroundImage: NetworkImage('assets/usuario.jpg'),
                ),

                //INFORMACION PERSONAL DEL USUARIO
                const SizedBox(height: 20),
                const Text("Ejemplo nombre de usuario"),
                const Text("Ejemplo@uts.edu.co"),
                const Text("Se unio el 01/09/2024"),
            ],
          ),

          
          const SizedBox(height: 20), // Espacio antes del Divider

          // Segunda sección con el texto alineado a la izquierda
          const Row(
            mainAxisAlignment: MainAxisAlignment.start, // Alinea el texto a la izquierda
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Añade padding
                child: const Text("Logros",
                style: TextStyle(
                  fontSize: 20, // Cambia el tamaño de la fuente aquí
                  fontWeight: FontWeight.bold, // Opcional: puedes hacer el texto negrita
                  ),
                ),
              ),
            ],
          ),

          // Divider entre secciones
          const Divider(
            color: Colors.grey,  // Cambia el color de la línea
            thickness: 2,        // Grosor de la línea
            indent: 20,          // Margen de la línea desde la izquierda
            endIndent: 20,       // Margen de la línea desde la derecha
          ),
          const SizedBox(height: 25),

          const Row(
            mainAxisAlignment: MainAxisAlignment.center, // Alinea el texto a la izquierda
            children: [
              CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: NetworkImage('assets/logro3.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: NetworkImage('assets/logro4.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: NetworkImage('assets/logro2.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: NetworkImage('assets/logro1.png'),
                ),
            ],
          ),

          //Carlos falta arreglar el boton
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el texto horizontalmente
            children: [
              SizedBox(height: 55),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const ProgressScreen()),
                  (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(270, 70),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Ir a progreso'),
              )
            ],
          )
          
        ],
      )
    );
  }
}
