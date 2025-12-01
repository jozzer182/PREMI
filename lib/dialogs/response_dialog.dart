import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/bloc/main_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/dialogs/reply_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:premi_1/resources/file_uploader.dart';
import 'package:premi_1/resources/env_config.dart';
import 'package:premi_1/version.dart';

class ResponseDialog extends StatefulWidget {
  final RegistrosSingle registro;
  const ResponseDialog({
    required this.registro,
    super.key,
  });

  @override
  State<ResponseDialog> createState() => _ResponseDialogState();
}

class _ResponseDialogState extends State<ResponseDialog> {
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
      title: const Text('Confirmar Respuesta'),
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
                    return ReplyDialog(
                      registro: widget.registro,
                    );
                  },
                );
              },
              child: const Text('No se recibió respuesta del contrato'),
            ),
            const SizedBox(height: 10),
            const Text(
                'Para confirmar la Respuesta informenos los siguientes datos:'),
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
                labelText: 'Fecha Respuesta',
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
                      carpeta: "RESPUESTA",
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
                    widget.registro.resfecha = _dateController.text;
                    widget.registro.resradicado = _radicadoController.text;
                    widget.registro.resobservacion = _comentarioController.text;
                    widget.registro.resadjunto = _fileController.text;
                    widget.registro.resusuario = version.user;
                    widget.registro.resfechareg =
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
                    setState(() => isUploading = false);
                    Navigator.of(context).pop();
                  },
            child: const Text('Aceptar'),
          ),
      ],
    );
  }
}
