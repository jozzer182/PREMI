import 'package:flutter/material.dart';

class AnsSeguridadPageEdit extends StatefulWidget {
  const AnsSeguridadPageEdit({super.key});

  @override
  State<AnsSeguridadPageEdit> createState() => _AnsSeguridadPageEditState();
}

class _AnsSeguridadPageEditState extends State<AnsSeguridadPageEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Seguridad'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Página de edición de seguridad'),
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}