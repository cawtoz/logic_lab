import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logic_lab/services/auth_service.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  // Obtener el usuario actual desde Firebase
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Controladores de texto para nombre y correo, que se inicializan con los valores del usuario actual
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: '01/09/2024');
  String _selectedCountry = 'Colombia';
  String? _photoUrl;

  @override
  void initState() {
    super.initState();

    // Establecer el nombre y el correo del usuario actual, si están disponibles
    _nameController.text = currentUser?.displayName ?? 'Usuario Desconocido';
    _emailController.text = currentUser?.email ?? 'Correo no disponible';
    _photoUrl = currentUser?.photoURL;
  }

  Future<void> _updateUserData() async {
    try {
      // Actualizar nombre
      if (_nameController.text.isNotEmpty && _nameController.text != currentUser?.displayName) {
        await currentUser?.updateDisplayName(_nameController.text);
      }

      // Actualizar correo electrónico
      if (_emailController.text.isNotEmpty && _emailController.text != currentUser?.email) {
        await currentUser?.updateEmail(_emailController.text);
      }

      // Actualizar foto de perfil (si ya has implementado lógica para cambiar la URL de la foto)
      if (_photoUrl != null && _photoUrl != currentUser?.photoURL) {
        await currentUser?.updatePhotoURL(_photoUrl);
      }

      // Recargar los datos del usuario para asegurarse de que los cambios se reflejan inmediatamente
      await currentUser?.reload();
      setState(() {
        // Actualizar el usuario en la pantalla
      });

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos actualizados exitosamente.')),
      );
    } catch (e) {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar los datos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Cerrar sesión usando el AuthService
              new AuthService().signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Sección para cambiar imagen de perfil
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _photoUrl != null
                        ? NetworkImage(_photoUrl!)
                        : const AssetImage('assets/default_avatar.png') as ImageProvider,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para cambiar imagen de perfil
                      // Esto actualizaría _photoUrl con la nueva URL de la imagen.
                    },
                    child: const Text('Cambiar'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Lógica para eliminar imagen de perfil
                      setState(() {
                        _photoUrl = null; // Borrar foto de perfil
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                  ),
                  const Text(
                    'JPG O PNG. Tamaño máximo 800k',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Campo para el nombre del usuario
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre del Usuario',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Lógica para editar nombre
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Campo para el correo electrónico
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _emailController.clear(); // Limpiar el campo de correo
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Campo para la fecha de unión (solo muestra, no se actualiza)
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Se unió el:',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    // Lógica para seleccionar fecha
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Selección de país
            DropdownButtonFormField<String>(
              value: _selectedCountry,
              items: const [
                DropdownMenuItem(value: 'Colombia', child: Text('Colombia')),
                DropdownMenuItem(value: 'Argentina', child: Text('Argentina')),
                DropdownMenuItem(value: 'México', child: Text('México')),
                // Agregar más países si es necesario
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountry = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'País:',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botones de Guardar y Cancelar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _updateUserData(); // Llamar a la función para actualizar los datos
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 20),
           
              ],
            ),
          ],
        ),
      ),
    );
  }
}
