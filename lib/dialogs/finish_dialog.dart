import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../bloc/main_bloc.dart';
import '../Todos/todos_model.dart';
import '../resources/env_config.dart';
import '../version.dart';

class FinishDialog extends StatefulWidget {
  final RegistrosSingle registro;
  const FinishDialog({
    required this.registro,
    super.key,
  });

  @override
  State<FinishDialog> createState() => _FinishDialogState();
}

class _FinishDialogState extends State<FinishDialog> {
  bool isUploading = false;
  final TextEditingController comentario = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Finalizar sin Factura'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Va a proceder con el cierre del apremio en el sistema sin cobro alguno. por favor indiquenos un comentario para el registro de la acción.'),
            const SizedBox(height: 10),
            TextFormField(
              controller: comentario,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comentario',
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        if (isUploading)
          const CircularProgressIndicator()
        else
          TextButton(
            onPressed: () async {
              setState(() => isUploading = true);
              DateTime now = DateTime.now();
              widget.registro.facestado = 'no facturado';
              widget.registro.facobservacion =comentario.text;
              widget.registro.facusuario = version.user;
              widget.registro.facfechareg =
                  '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
              widget.registro.estadousuario = version.user;
              widget.registro.estadofecha =
                  '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
              Map dataSend = {
                "info": {
                  "libro": "DB",
                  "hoja": "reg",
                  "data": [widget.registro.toMap()],
                },
                "fname": "update",
              };
              // print(jsonEncode(dataSend));
              final response = await http
                  .post(
                EnvConfig.apiPremiUri,
                body: jsonEncode(dataSend),
              )
                  .then(
                (value) {
                  context.read<MainBloc>().add(Load());
                  return value;
                },
              );
              var dataAsListMap;
              if (response.statusCode == 302) {
                var response2 = await http
                    .get(Uri.parse(response.headers["location"] ?? ''));
                dataAsListMap = jsonDecode(response2.body);
              } else {
                dataAsListMap = jsonDecode(response.body);
              }
              // print(dataAsListMap);
              await showModalBottomSheet(
                  context: context,
                  builder: (c) {
                    return SizedBox(
                      height: 30,
                      child: Center(child: Text(dataAsListMap.toString())),
                    );
                  });
              setState(() => isUploading = true);
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          ),
      ],
    );
  }
}
