import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/bloc/main_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/dialogs/fact_dialog.dart';
import 'package:premi_1/resources/file_uploader.dart';
import 'package:premi_1/resources/env_config.dart';
import 'package:premi_1/version.dart';
import 'package:http/http.dart' as http;

class ReplyDialog extends StatefulWidget {
  final RegistrosSingle registro;
  const ReplyDialog({
    required this.registro,
    super.key,
  });

  @override
  State<ReplyDialog> createState() => _ReplyDialogState();
}

class _ReplyDialogState extends State<ReplyDialog> {
  bool isUploading = false;
  DateTime? _selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _typeController = TextEditingController();
  final TextEditingController _radicadoController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  @override
  void initState() {
    _dateController.addListener(() {
      setState(() {});
    });
    // _typeController.addListener(() {
    //   setState(() {});
    // });
    _radicadoController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = _dateController.text.isEmpty ||
        // _typeController.text.isEmpty ||
        _radicadoController.text.isEmpty;
    return AlertDialog(
      title: const Text('Confirmar Réplica'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FactDialog(
                      registro: widget.registro,
                    );
                  },
                );
              },
              child: const Text('No se envió réplica al contrato'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Para confirmar la réplica informenos los siguientes datos:',
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _radicadoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No. Radicado',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              readOnly: true,
              controller: _dateController,
              onTap: () async {
                _selectedDate = await showDatePicker(
                  locale: const Locale('es', 'ES'),
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (_selectedDate != null) {
                  DateTime newDate = _selectedDate!;
                  _dateController.text =
                      '${newDate.day.toString().padLeft(2, '0')}/${newDate.month.toString().padLeft(2, '0')}/${newDate.year}';
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Fecha Réplica',
              ),
            ),
            const SizedBox(height: 10),
            if (isUploading)
              const Center(child: CircularProgressIndicator())
            else
              TextFormField(
                readOnly: true,
                controller: _fileController,
                onTap: () async {
                  setState(() => isUploading = true);
                  final result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    var file = result.files.first;
                    // print(file.name);
                    _fileController.text =
                        await FileUploadToDrive.uploadAndGetUrl(
                      file: file,
                      carpeta: "REPLICA",
                    );

                    setState(() => isUploading = false);
                  }
                  setState(() => isUploading = false);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adjunto',
                  suffixIcon: Icon(Icons.attach_file),
                ),
              ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _comentarioController,
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        if (isUploading)
          const CircularProgressIndicator()
        else
          TextButton(
            onPressed: isEmpty
                ? null
                : () async {
                    setState(() => isUploading = true);
                    DateTime now = DateTime.now();
                    widget.registro.repfecha = _dateController.text;
                    widget.registro.repradicado = _radicadoController.text;
                    widget.registro.repobservacion = _comentarioController.text;
                    widget.registro.repadjunto = _fileController.text;
                    widget.registro.repusuario = version.user;
                    widget.registro.repfechareg =
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
                            child:
                                Center(child: Text(dataAsListMap.toString())),
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
