import 'package:flutter/material.dart';
import 'package:logic_lab/components/custom_app_bar.dart';
import 'package:intl/intl.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class AppUser {
  final String name;
  final String email;
  final String role;
  final DateTime creationDate;

  AppUser(this.name, this.email, this.role, this.creationDate);
}

class _AdminScreenState extends State<AdminScreen> {
  
  String? selectedUser;
  AppUser? selectedUserData;

  final List<AppUser> users = [
    AppUser('Carlos', 'Carlos@example.com', 'Admin', DateTime(2024, 7, 1)),
    AppUser('Bairon', 'Bairon@example.com', 'Editor', DateTime(2024, 8, 15)),
    AppUser('Ronald', 'Ronald@example.com', 'Viewer', DateTime(2024, 9, 10)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Administración"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                hint: Text('Selecciona un usuario'),
                value: selectedUser,
                isExpanded: true,
                items: users.map((AppUser user) {
                  return DropdownMenuItem<String>(
                    value: user.name,
                    child: Text(user.name, style: TextStyle(fontSize: 18)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUser = newValue;
                    selectedUserData = users.firstWhere((user) => user.name == newValue);
                  });
                },
              ),
              SizedBox(height: 20),
              if (selectedUserData != null) ...[
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Datos')),
                    DataColumn(label: Text('Datos Usuario')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Nombre')),
                      DataCell(Text(selectedUserData!.name)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Correo')),
                      DataCell(Text(selectedUserData!.email)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Rol')),
                      DataCell(Text(selectedUserData!.role)),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Fecha de creación')),
                      DataCell(Text(DateFormat('yyyy-MM-dd').format(selectedUserData!.creationDate))),
                    ]),
                  ],
                ),
              ] else ...[
                Text('Por favor, selecciona un usuario para ver los detalles.', style: TextStyle(fontSize: 18)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}