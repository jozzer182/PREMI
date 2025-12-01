import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premi_1/bloc/main_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/resources/file_uploader.dart';
import 'package:premi_1/resources/env_config.dart';
import 'package:http/http.dart' as http;

import '../version.dart';

class FactDialog extends StatefulWidget {
  final RegistrosSingle registro;
  const FactDialog({
    required this.registro,
    super.key,
  });

  @override
  State<FactDialog> createState() => _FactDialogState();
}

class _FactDialogState extends State<FactDialog> {
  DateTime? _selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _facturaController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  bool isUploading = false;
  static const _locale = 'en';
  String _formatNumber(String s) {
    return NumberFormat.decimalPattern(_locale).format(int.parse(s));
  }

  @override
  void initState() {
    _dateController.addListener(() {
      setState(() {});
    });
    _facturaController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty =
        _dateController.text.isEmpty || _facturaController.text.isEmpty || _valorController.text.isEmpty;
    return AlertDialog(
      title: const Text('Confirmar Factura'),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Para confirmar la Factura informenos los siguientes datos:',
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _facturaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No. Factura',
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
                labelText: 'Fecha Factura',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _valorController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
                labelText: 'Valor Total',
              ),
              onChanged: (string) {
                string = _formatNumber(string);
                _valorController.value = TextEditingValue(
                  text: string,
                  selection: TextSelection.collapsed(offset: string.length),
                );
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      carpeta: "FACTURA",
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
            ),
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
                    widget.registro.facestado = "facturado";
                    widget.registro.facfecha = _dateController.text;
                    widget.registro.facfactura = _facturaController.text;
                    widget.registro.facvalor = _valorController.text;
                    widget.registro.facobservacion = _comentarioController.text;
                    widget.registro.facadjunto = _fileController.text;
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
