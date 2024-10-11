import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logic_lab/firebase_options.dart';
import 'package:logic_lab/screens/admin/admin.dart';
import 'package:logic_lab/screens/config/config.dart';
import 'package:logic_lab/screens/home/home.dart';
import 'package:logic_lab/screens/progress/progress.dart';
import 'package:logic_lab/screens/welcome/welcome.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  static var theme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.blue,
      showUnselectedLabels: false,
    )
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logic Lab',
      home: const AuthWrapper(),
      theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si el usuario está autenticado, lo enviamos a HomeScreen
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const WelcomeScreen();
          } else {
            return const MainScreen(); // Pantalla principal si está logeado
          }
        } else {
          // Mostrar algo mientras se conecta
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {

  final int initialScreen;

  const MainScreen({super.key, this.initialScreen = 0});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<MainScreen> {

  int currentScreen = 0;

  @override
  void initState() {
    super.initState();
    currentScreen = widget.initialScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentScreen,
        onTap: (index) => setState(() {
          currentScreen = index;
        }),
      ),
    );
  }
  
}

List<Widget> screens = [
  const HomeScreen(),
  const ProgressScreen(),
  const AdminScreen(),
  const ConfigScreen(),
];

const List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Inicio',
    backgroundColor: Colors.black
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.school),
    label: 'Progreso',
    backgroundColor: Colors.black
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.admin_panel_settings),
    label: 'Admin',
    backgroundColor: Colors.black
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Perfil',
    backgroundColor: Colors.black
  )
];