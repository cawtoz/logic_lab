import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:logic_lab/main.dart';
import 'package:intl/intl.dart';
import 'package:logic_lab/services/user_service.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: const CustomAppBar(title: "Logic Lab"),

      body: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Column al contenido
        children: <Widget>[
          const SizedBox(height: 25), //Espacio entre el appBar y el icono
          
          // Primera sección con el texto
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el texto horizontalmente
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: currentUser?.photoURL != null 
                  ? NetworkImage(currentUser!.photoURL!) 
                  : const AssetImage('assets/usuario.jpg') as ImageProvider, // Imagen local si photoURL es null
              ),
              const SizedBox(height: 20),
              Text(currentUser?.displayName ?? ''), // Mostrar el nombre del usuario
              Text(currentUser?.email ?? 'No disponible'), // Mostrar el correo del usuario
              Text(
                'Se unió el ${currentUser?.metadata.creationTime != null ? DateFormat('dd/MM/yyyy')
                .format(currentUser!.metadata.creationTime!) : 'Fecha no disponible'}',
              ),
              FutureBuilder<int?>(
                future: UserService().getUserLevel(), // Llama a tu función asincrónica
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Indicador de carga mientras se espera el nivel
                  } else if (snapshot.hasError) {
                    return const Text('Error al obtener el nivel'); // Mensaje de error
                  } else if (snapshot.hasData) {
                    return Text('Nivel: ${snapshot.data}'); // Nivel del usuario
                  } else {
                    return const Text('Nivel no disponible'); // Manejo de null
                  }
                },
              ),
            ],
          ),

          
          const SizedBox(height: 20), // Espacio antes del Divider

          // Segunda sección con el texto alineado a la izquierda
          const Row(
            mainAxisAlignment: MainAxisAlignment.start, // Alinea el texto a la izquierda
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Añade padding
                child: Text("Logros",
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
                  backgroundImage: AssetImage('assets/logro3.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: AssetImage('assets/logro4.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: AssetImage('assets/logro2.png'),
                ),

                SizedBox(width: 25),
                CircleAvatar( //icono
                  radius: 30,
                  backgroundImage: AssetImage('assets/logro1.png'),
                ),
            ],
          ),

          //Carlos falta arreglar el boton
          Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el texto horizontalmente
            children: [
              const SizedBox(height: 55),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainScreen(initialScreen: 1)),
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
