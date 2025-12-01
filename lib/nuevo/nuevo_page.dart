// ignore_for_file: avoid_print

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
import 'package:premi_1/version.dart';
import 'package:http/http.dart' as http;

class NuevoPage extends StatefulWidget {
  const NuevoPage({super.key});

  @override
  State<NuevoPage> createState() => _NuevoPageState();
}

class _NuevoPageState extends State<NuevoPage> {
  RegistrosSingle registro = RegistrosSingle.fromZero();
  bool iSelected = false;
  bool iiSelected = false;
  bool iiiSelected = false;
  bool inspection = false;
  bool isUploading = false;
  bool response = false;
  bool failResponse = false;
  bool replica = false;
  bool failReplica = false;
  bool factura = false;
  bool failFactura = false;
  final _valorInicialcontroller = TextEditingController();
  final _valorFinalController = TextEditingController();
  final _solicitadoRadicado = TextEditingController();
  final _solicitadoFecha = TextEditingController();
  final _solicitadoDestinatario = TextEditingController();
  final _solicitadoFile = TextEditingController();
  final _respuestaRadicado = TextEditingController();
  final _respuestaFecha = TextEditingController();
  final _respuestaFile = TextEditingController();
  final _replicaRadicado = TextEditingController();
  final _replicaFecha = TextEditingController();
  final _replicaFile = TextEditingController();
  final _facturaRadicado = TextEditingController();
  final _facturaFecha = TextEditingController();
  final _facturaFile = TextEditingController();
  static const _locale = 'en';
  DateTime? _selectedDate = DateTime.now();
  String _formatNumber(String s) {
    return NumberFormat.decimalPattern(_locale).format(int.parse(s));
  }

  @override
  void initState() {
    _solicitadoRadicado.addListener(() {
      setState(() {});
    });
    _solicitadoFecha.addListener(() {
      setState(() {});
    });
    _solicitadoDestinatario.addListener(() {
      setState(() {});
    });
    _solicitadoFile.addListener(() {
      setState(() {});
    });
    _respuestaRadicado.addListener(() {
      setState(() {});
    });
    _respuestaFecha.addListener(() {
      setState(() {});
    });
    _respuestaFile.addListener(() {
      setState(() {});
    });
    _replicaRadicado.addListener(() {
      setState(() {});
    });
    _replicaFecha.addListener(() {
      setState(() {});
    });
    _replicaFile.addListener(() {
      setState(() {});
    });
    _facturaRadicado.addListener(() {
      setState(() {});
    });
    _facturaFecha.addListener(() {
      setState(() {});
    });
    _facturaFile.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool solicitadoDone = _solicitadoRadicado.text.isNotEmpty &&
        _solicitadoFecha.text.isNotEmpty &&
        _solicitadoDestinatario.text.isNotEmpty;
    bool responseDone = (_respuestaRadicado.text.isNotEmpty &&
            _respuestaFecha.text.isNotEmpty) ||
        failResponse;
    bool replicaDone =
        (_replicaRadicado.text.isNotEmpty && _replicaFecha.text.isNotEmpty) ||
            failReplica;
    bool facturaDone = (_facturaFecha.text.isNotEmpty &&
            _facturaRadicado.text.isNotEmpty &&
            _valorFinalController.text.isNotEmpty) ||
        failFactura;
    List<bool> registrosObligatorios = [
      registro.empresa.isNotEmpty,
      registro.contrato.isNotEmpty,
      registro.solicitante.isNotEmpty,
      registro.coordinadorpmc.isNotEmpty,
      registro.clasificacion.isNotEmpty,
      _valorInicialcontroller.text.isNotEmpty,
      registro.medio.isNotEmpty,
      registro.descripcion.isNotEmpty,
    ];
    bool readyToSave =
        solicitadoDone && registrosObligatorios.every((e) => e == true);
    Color primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    Color background = Theme.of(context).colorScheme.surface;
    Color primary = Theme.of(context).colorScheme.primary;
    TextStyle titleMedium = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: primary,
          fontWeight: FontWeight.w900,
        );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo'),
        automaticallyImplyLeading: !isUploading,
        actions: [
          isUploading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  onPressed: !readyToSave
                      ? null
                      : () async {
                          setState(() => isUploading = true);
                          DateTime? now = DateTime.now();
                          registro.valor =
                              _valorInicialcontroller.text.replaceAll(',', '');
                          registro.solfecha = _solicitadoFecha.text;
                          registro.solradicado = _solicitadoRadicado.text;
                          registro.soldestinatario =
                              _solicitadoDestinatario.text;
                          registro.soladjunto = _solicitadoFile.text;
                          registro.solusuario = version.user;
                          registro.solfechareg =
                              '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          registro.estadousuario = version.user;
                          registro.estadofecha =
                              '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          registro.usuario = version.user;
                          registro.fechareg =
                              '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          if (responseDone) {
                            registro.resfecha = _respuestaFecha.text;
                            registro.resradicado = _respuestaRadicado.text;
                            registro.resadjunto = _respuestaFile.text;
                            registro.resusuario = version.user;
                            registro.resfechareg =
                                '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          }
                          if (replicaDone) {
                            registro.repfecha = _replicaFecha.text;
                            registro.repradicado = _replicaRadicado.text;
                            registro.repadjunto = _replicaFile.text;
                            registro.repusuario = version.user;
                            registro.repfechareg =
                                '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          }
                          if (facturaDone) {
                            if (failFactura) {
                              registro.facestado = 'no facturado';
                            } else {
                              registro.facestado = 'facturado';
                            }
                            registro.facfecha = _facturaFecha.text;
                            registro.facfactura = _facturaRadicado.text;
                            registro.facadjunto = _facturaFile.text;
                            registro.facvalor =
                                _valorFinalController.text.replaceAll(',', '');
                            registro.facusuario = version.user;
                            registro.facfechareg =
                                '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
                          }
                          Map dataSend = {
                            "info": {
                              "libro": "DB",
                              "hoja": "reg",
                              "data": [registro.toMap()],
                            },
                            "fname": "add",
                          };
                          print(jsonEncode(dataSend));
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
                            var response2 = await http.get(
                                Uri.parse(response.headers["location"] ?? ''));
                            dataAsListMap = jsonDecode(response2.body);
                          } else {
                            dataAsListMap = jsonDecode(response.body);
                          }
                          print(dataAsListMap);
                          await showModalBottomSheet(
                              context: context,
                              builder: (c) {
                                return SizedBox(
                                  height: 30,
                                  child: Center(
                                      child: Text(dataAsListMap.toString())),
                                );
                              });
                          setState(() => isUploading = false);
                          Navigator.of(context).pop();
                        },
                  child: const Text('Guardar'),
                ),
        ],
        flexibleSpace: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: primaryContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: BlocSelector<MainBloc, MainState, bool>(
            selector: (state) => state.isLoading,
            builder: (context, state) {
              // print('called');
              return state ? const LinearProgressIndicator() : const SizedBox();
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              version.data,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              version.status('Todos', '$runtimeType'),
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.empresa?.empresaList
                                    .map((e) => e.tipo)
                                    .toSet()
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.empresa = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.empresa.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Empresa',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.empresa?.empresaList
                                    .where((e) => e.tipo == registro.empresa)
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.contrato,
                                        child: Text(e.contrato),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.contrato = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.empresa.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Contrato',
                            ),
                          ),
                        ),
                        // const SizedBox(width: 10),
                        // Expanded(
                        //   child: TextFormField(
                        //     onChanged: (value) {
                        //       setState(() {
                        //         registro.contrato = value.toString();
                        //       });
                        //     },
                        //     decoration: InputDecoration(
                        //       contentPadding:
                        //           const EdgeInsets.symmetric(horizontal: 10),
                        //       border: const OutlineInputBorder(),
                        //       labelStyle: TextStyle(
                        //         color: registro.contrato.isEmpty
                        //             ? Colors.red
                        //             : null,
                        //       ),
                        //       labelText: 'Contrato',
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.solicitante?.solicitanteList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.correo,
                                        child: Text(e.correo),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.solicitante = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.solicitante.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Solicitante',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.coordinador?.coordinadorList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.correo,
                                        child: Text(e.correo),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.coordinadorpmc = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.coordinadorpmc.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Coordinador PM&C',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.clasificacion?.clasificacionList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.tipo,
                                        child: Text(e.tipo),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.clasificacion = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.clasificacion.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Clasificación',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.subclasificacion?.subclasificacionList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.tipo,
                                        child: Text(e.tipo),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.subclasificacion = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.subclasificacion.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Subclasificación',
                            ),
                          ),
                        ),

                        // Expanded(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       width < 750
                        //           ? const SizedBox()
                        //           : const Text('Tipos:'),
                        //       ActionChip(
                        //         label: const Text('I'),
                        //         onPressed: () {
                        //           setState(() {
                        //             iSelected = !iSelected;
                        //             registro.i = iSelected ? 'x' : '';
                        //           });
                        //         },
                        //         backgroundColor:
                        //             iSelected ? primaryContainer : null,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       ActionChip(
                        //         label: const Text('II'),
                        //         onPressed: () {
                        //           setState(() {
                        //             iiSelected = !iiSelected;
                        //             registro.ii = iiSelected ? 'x' : '';
                        //           });
                        //         },
                        //         backgroundColor:
                        //             iiSelected ? primaryContainer : null,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       ActionChip(
                        //         label: const Text('III'),
                        //         onPressed: () {
                        //           setState(() {
                        //             iiiSelected = !iiiSelected;
                        //             registro.iii = iiiSelected ? 'x' : '';
                        //           });
                        //         },
                        //         backgroundColor:
                        //             iiiSelected ? primaryContainer : null,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                registro.cantidadincumplimientos =
                                    value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Ctd. Incumplimientos',
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _valorInicialcontroller,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: _valorInicialcontroller.text.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Valor Total',
                            ),
                            onChanged: (string) {
                              if (string.isNotEmpty) {
                                string = _formatNumber(string);
                                setState(() {
                                  _valorInicialcontroller.value =
                                      TextEditingValue(
                                    text: string,
                                    selection: TextSelection.collapsed(
                                      offset: string.length,
                                    ),
                                  );
                                });
                              } else {
                                setState(() {
                                  _valorInicialcontroller.text = string;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.medio?.medioList
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.tipo,
                                        child: Text(e.tipo),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.medio = value.toString();
                              });
                            },
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color:
                                    registro.medio.isEmpty ? Colors.red : null,
                              ),
                              labelText: 'Medio',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (width < 579 && inspection)
                                const SizedBox()
                              else
                                const Text('Inspección:'),
                              Checkbox(
                                value: inspection,
                                onChanged: (value) {
                                  setState(() {
                                    registro.inspeccion = value! ? 'x' : '';
                                    inspection = !inspection;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (!inspection)
                          const SizedBox()
                        else
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      setState(() {
                                        registro.numinspeccion =
                                            value.toString();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(),
                                      labelText: '# Inspección',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        // const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                registro.titulo = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Título',
                            ),
                          ),
                        ),
                        // const SizedBox(width: 10),
                        // Expanded(
                        //   child: TextFormField(
                        //     decoration: const InputDecoration(
                        //       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        //       border: OutlineInputBorder(),
                        //       labelText: 'Proyecto',
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                registro.proyecto = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Proyecto',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField(
                            items: state.nt?.ntlist.map((nt) {
                                  return DropdownMenuItem(
                                    value: nt.niveldetension,
                                    child: Text(nt.niveldetension),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                registro.nt = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Área',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                registro.descripcion = value.toString();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: registro.descripcion.isEmpty
                                    ? Colors.red
                                    : null,
                              ),
                              labelText: 'Descripción',
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                registro.observaciongeneral = value.toString();
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Observaciones',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Card(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        'Solicitado',
                                        style: titleMedium,
                                      ),
                                      Icon(
                                        Icons.outgoing_mail,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _solicitadoRadicado,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: const OutlineInputBorder(),
                                            labelStyle: TextStyle(
                                              color: _solicitadoRadicado
                                                      .text.isEmpty
                                                  ? Colors.red
                                                  : null,
                                            ),
                                            labelText: 'Radicado',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: _solicitadoFecha,
                                          onTap: () async {
                                            _selectedDate =
                                                await showDatePicker(
                                              locale: const Locale('es', 'ES'),
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100),
                                            );
                                            if (_selectedDate != null) {
                                              DateTime date = _selectedDate!;
                                              _solicitadoFecha.text =
                                                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                            }
                                          },
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: const OutlineInputBorder(),
                                            labelStyle: TextStyle(
                                              color:
                                                  _solicitadoFecha.text.isEmpty
                                                      ? Colors.red
                                                      : null,
                                            ),
                                            labelText: 'Fecha de Radicado',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: _solicitadoDestinatario,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: const OutlineInputBorder(),
                                            labelStyle: TextStyle(
                                              color: _solicitadoDestinatario
                                                      .text.isEmpty
                                                  ? Colors.red
                                                  : null,
                                            ),
                                            labelText: 'Destinatario',
                                            hintText:
                                                'Email o dirección física',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: isUploading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : TextFormField(
                                                readOnly: true,
                                                controller: _solicitadoFile,
                                                onTap: () async {
                                                  setState(
                                                      () => isUploading = true);
                                                  final result =
                                                      await FilePicker.platform
                                                          .pickFiles();
                                                  if (result != null) {
                                                    var file =
                                                        result.files.first;
                                                    print(file.name);
                                                    _solicitadoFile.text =
                                                        await FileUploadToDrive
                                                            .uploadAndGetUrl(
                                                      file: file,
                                                      carpeta: "SOLICITADO",
                                                    );
                                                    setState(() =>
                                                        isUploading = false);
                                                  }
                                                  setState(() =>
                                                      isUploading = false);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Adjunto',
                                                  suffixIcon:
                                                      Icon(Icons.attach_file),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          onChanged: (value) {
                                            setState(() {
                                              registro.solobservacion =
                                                  value.toString();
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Observaciones',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        'Respuesta',
                                        style: titleMedium,
                                      ),
                                      Icon(
                                        Icons.pending_actions,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                  //make an overflow menu
                                  if (!solicitadoDone)
                                    const Text(
                                        'sin datos completos en solicitado')
                                  else
                                    Column(
                                      children: [
                                        OverflowBar(
                                          spacing: 10,
                                          children: [
                                            failResponse
                                                ? const SizedBox()
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          response = !response);
                                                    },
                                                    child: !response
                                                        ? const Text(
                                                            'Ya tengo una respuesta')
                                                        : const Text(
                                                            'Esperaré la respuesta'),
                                                  ),
                                            if (response)
                                              const SizedBox()
                                            else
                                              ActionChip(
                                                onPressed: () {
                                                  setState(() {
                                                    failResponse =
                                                        !failResponse;
                                                  });
                                                },
                                                label: const Text(
                                                    'El contrato no respondió'),
                                                backgroundColor: failResponse
                                                    ? primaryContainer
                                                    : null,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        if (!response)
                                          const SizedBox()
                                        else
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller:
                                                          _respuestaRadicado,
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Radicado',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      controller:
                                                          _respuestaFecha,
                                                      onTap: () async {
                                                        _selectedDate =
                                                            await showDatePicker(
                                                          locale: const Locale(
                                                              'es', 'ES'),
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(2100),
                                                        );
                                                        if (_selectedDate !=
                                                            null) {
                                                          DateTime date =
                                                              _selectedDate!;
                                                          _respuestaFecha.text =
                                                              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                                        }
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Fecha de Radicado',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: isUploading
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          )
                                                        : TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                _respuestaFile,
                                                            onTap: () async {
                                                              setState(() =>
                                                                  isUploading =
                                                                      true);
                                                              final result =
                                                                  await FilePicker
                                                                      .platform
                                                                      .pickFiles();
                                                              if (result !=
                                                                  null) {
                                                                var file =
                                                                    result.files
                                                                        .first;
                                                                print(
                                                                    file.name);
                                                                _respuestaFile
                                                                        .text =
                                                                    await FileUploadToDrive
                                                                        .uploadAndGetUrl(
                                                                  file: file,
                                                                  carpeta:
                                                                      "RESPUESTA",
                                                                );
                                                                setState(() =>
                                                                    isUploading =
                                                                        false);
                                                              }
                                                              setState(() =>
                                                                  isUploading =
                                                                      false);
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10),
                                                              border:
                                                                  OutlineInputBorder(),
                                                              labelText:
                                                                  'Adjunto',
                                                              suffixIcon: Icon(Icons
                                                                  .attach_file),
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        setState(() {
                                                          registro.resobservacion =
                                                              value.toString();
                                                        });
                                                      },
                                                      decoration:
                                                          const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText:
                                                            'Observaciones',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Card(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        'Réplica',
                                        style: titleMedium,
                                      ),
                                      Icon(
                                        Icons.airline_stops,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  if (!responseDone)
                                    const Text('sin dato de respuesta')
                                  else
                                    Column(
                                      children: [
                                        OverflowBar(
                                          spacing: 10,
                                          children: [
                                            failReplica
                                                ? const SizedBox()
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          replica = !replica);
                                                    },
                                                    child: !replica
                                                        ? const Text(
                                                            'Ya tengo una réplica')
                                                        : const Text(
                                                            'Esperaré la réplica'),
                                                  ),
                                            if (replica)
                                              const SizedBox()
                                            else
                                              ActionChip(
                                                onPressed: () {
                                                  setState(() {
                                                    failReplica = !failReplica;
                                                  });
                                                },
                                                label: const Text(
                                                    'No se dió réplica'),
                                                backgroundColor: failReplica
                                                    ? primaryContainer
                                                    : null,
                                              ),
                                            const SizedBox(height: 10),
                                            if (!replica)
                                              const SizedBox()
                                            else
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              _replicaRadicado,
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Radicado',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          controller:
                                                              _replicaFecha,
                                                          onTap: () async {
                                                            _selectedDate =
                                                                await showDatePicker(
                                                              locale:
                                                                  const Locale(
                                                                      'es',
                                                                      'ES'),
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2000),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100),
                                                            );
                                                            if (_selectedDate !=
                                                                null) {
                                                              DateTime date =
                                                                  _selectedDate!;
                                                              _replicaFecha
                                                                      .text =
                                                                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                                            }
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Fecha de Radicado',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: isUploading
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            : TextFormField(
                                                                readOnly: true,
                                                                controller:
                                                                    _replicaFile,
                                                                onTap:
                                                                    () async {
                                                                  setState(() =>
                                                                      isUploading =
                                                                          true);
                                                                  final result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles();
                                                                  if (result !=
                                                                      null) {
                                                                    var file = result
                                                                        .files
                                                                        .first;
                                                                    print(file
                                                                        .name);
                                                                    _replicaFile
                                                                            .text =
                                                                        await FileUploadToDrive
                                                                            .uploadAndGetUrl(
                                                                      file:
                                                                          file,
                                                                      carpeta:
                                                                          "REPLICA",
                                                                    );
                                                                    setState(() =>
                                                                        isUploading =
                                                                            false);
                                                                  }
                                                                  setState(() =>
                                                                      isUploading =
                                                                          false);
                                                                },
                                                                decoration:
                                                                    const InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'Adjunto',
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .attach_file),
                                                                ),
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              registro.repobservacion =
                                                                  value
                                                                      .toString();
                                                            });
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Observaciones',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: background,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        'Factura',
                                        style: titleMedium.copyWith(
                                          color: facturaDone
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      Icon(
                                        Icons.sports_score,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  if (!replicaDone)
                                    const Text('sin dato de respuesta')
                                  else
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        OverflowBar(
                                          spacing: 10,
                                          children: [
                                            failFactura
                                                ? const SizedBox()
                                                : ElevatedButton(
                                                    onPressed: () {
                                                      setState(() =>
                                                          factura = !factura);
                                                    },
                                                    child: !factura
                                                        ? const Text(
                                                            'Ya tengo una factura')
                                                        : const Text(
                                                            'Esperaré la factura'),
                                                  ),
                                            if (factura)
                                              const SizedBox()
                                            else
                                              ActionChip(
                                                onPressed: () {
                                                  setState(() {
                                                    failFactura = !failFactura;
                                                  });
                                                },
                                                label: const Text(
                                                    'No se dió factura'),
                                                backgroundColor: failFactura
                                                    ? primaryContainer
                                                    : null,
                                              ),
                                            const SizedBox(height: 10),
                                            if (!factura)
                                              const SizedBox()
                                            else
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              _facturaRadicado,
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Factura',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          readOnly: true,
                                                          controller:
                                                              _facturaFecha,
                                                          onTap: () async {
                                                            _selectedDate =
                                                                await showDatePicker(
                                                              locale:
                                                                  const Locale(
                                                                      'es',
                                                                      'ES'),
                                                              context: context,
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2000),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100),
                                                            );
                                                            if (_selectedDate !=
                                                                null) {
                                                              DateTime date =
                                                                  _selectedDate!;
                                                              _facturaFecha
                                                                      .text =
                                                                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                                            }
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Fecha de Expedición',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller:
                                                              _valorFinalController,
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Valor Final',
                                                          ),
                                                          onChanged: (string) {
                                                            string =
                                                                _formatNumber(
                                                                    string);
                                                            setState(() {
                                                              _valorFinalController
                                                                      .value =
                                                                  TextEditingValue(
                                                                text: string,
                                                                selection: TextSelection
                                                                    .collapsed(
                                                                        offset:
                                                                            string.length),
                                                              );
                                                            });
                                                          },
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.center,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: isUploading
                                                            ? const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            : TextFormField(
                                                                readOnly: true,
                                                                controller:
                                                                    _facturaFile,
                                                                onTap:
                                                                    () async {
                                                                  setState(() =>
                                                                      isUploading =
                                                                          true);
                                                                  final result =
                                                                      await FilePicker
                                                                          .platform
                                                                          .pickFiles();
                                                                  if (result !=
                                                                      null) {
                                                                    var file = result
                                                                        .files
                                                                        .first;
                                                                    print(file
                                                                        .name);
                                                                    _facturaFile
                                                                            .text =
                                                                        await FileUploadToDrive
                                                                            .uploadAndGetUrl(
                                                                      file:
                                                                          file,
                                                                      carpeta:
                                                                          "FACTURA",
                                                                    );
                                                                    setState(() =>
                                                                        isUploading =
                                                                            false);
                                                                  }
                                                                  setState(() =>
                                                                      isUploading =
                                                                          false);
                                                                },
                                                                decoration:
                                                                    const InputDecoration(
                                                                  contentPadding:
                                                                      EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  labelText:
                                                                      'Adjunto',
                                                                  suffixIcon:
                                                                      Icon(Icons
                                                                          .attach_file),
                                                                ),
                                                              ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (value) {
                                                            setState(() {
                                                              registro.facobservacion =
                                                                  value
                                                                      .toString();
                                                            });
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                            border:
                                                                OutlineInputBorder(),
                                                            labelText:
                                                                'Observaciones',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
