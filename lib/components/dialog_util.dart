import 'package:flutter/material.dart';

class DialogUtil {
  static Future<void> showCustomDialog(
    BuildContext context, // Asegúrate de que el contexto está definido aquí
    String title,
    String message,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
