// ignore_for_file: sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/apremio/view/fields_v1.dart';

import '../../bloc/main_bloc.dart';
import '../model/apremio_enum.dart';
import '../model/apremio_model.dart';
import 'card_estado.dart';

class ApremioPage extends StatefulWidget {
  final bool esNuevo;
  const ApremioPage({
    required this.esNuevo,
    super.key,
  });

  @override
  State<ApremioPage> createState() => _ApremioPageState();
}

class _ApremioPageState extends State<ApremioPage> {
  bool loadingFile = false;
  bool editAllFields = false;
  bool response = false;
  bool failResponse = false;
  bool replica = false;
  bool failReplica = false;
  bool factura = false;
  bool failFactura = false;

  @override
  void initState() {
    if (widget.esNuevo) {
      context.read<MainBloc>().add(SetApremio(apremio: Apremio.fromInit()));
      editAllFields = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color background = Theme.of(context).colorScheme.surface;
    TextStyle titleMedium = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: primaryColor,
          fontWeight: FontWeight.w900,
        );

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state.apremio == null || state.user == null) {
              return const CircularProgressIndicator();
            }
            if (widget.esNuevo) {
              return const Text('Nuevo Apremio');
            }
            return SelectableText('Apremio no. ${state.apremio!.id}');
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: BlocSelector<MainBloc, MainState, bool>(
            selector: (state) => state.isLoading,
            builder: (context, state) {
              return state || loadingFile
                  ? const LinearProgressIndicator()
                  : const SizedBox();
            },
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              if (!widget.esNuevo && !editAllFields) return const SizedBox();
              return ElevatedButton(
                child: const Text('Guardar'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  if (widget.esNuevo) {
                    BlocProvider.of<MainBloc>(context).add(
                      AddToDbApremio(context: context),
                    );
                  } else {
                    BlocProvider.of<MainBloc>(context).add(
                      UpdateToDbApremio(context: context),
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(width: 10),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (widget.esNuevo || state.user == null ||!state.user!.permisos.contains('premi_editar')) return const SizedBox();
              return ElevatedButton(
                child: Text(editAllFields ? 'Cancelar' : 'Editar'),
                onPressed: () {
                  setState(() {
                    editAllFields = !editAllFields;
                  });
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state.apremio == null || state.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Apremio data = state.apremio!;
          Iterable<String> empresas =
              state.empresa!.empresaList.map((e) => e.tipo);
          Iterable<String> contratos = state.empresa!.empresaList
              .where((e) => e.tipo == data.empresa)
              .map((e) => e.contrato);
          // print('From Page contratos: $contratos');
          Iterable<String> solicitantes =
              state.solicitante!.solicitanteList.map((e) => e.correo);
          Iterable<String> coordinadores =
              state.coordinador!.coordinadorList.map((e) => e.correo);
          Iterable<String> clasificacion =
              state.clasificacion!.clasificacionList.map((e) => e.tipo);
          Iterable<String> subclasificacion =
              state.subclasificacion!.subclasificacionList.map((e) => e.tipo);
          Iterable<String> medio = state.medio!.medioList.map((e) => e.tipo);
          return BodySingle(
            children: [
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.empresa,
                      campo: Campo.empresa,
                      label: 'Empresa',
                      color: empresas.contains(data.empresa)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: empresas,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.contrato,
                      campo: Campo.contrato,
                      label: 'Contrato',
                      color: contratos.contains(data.contrato)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: contratos,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.solicitante,
                      campo: Campo.solicitante,
                      label: 'Solicitante',
                      color: solicitantes.contains(data.solicitante)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: solicitantes,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.coordinadorpmc,
                      campo: Campo.coordinadorpmc,
                      label: 'Coordinador SCS',
                      color: coordinadores.contains(data.coordinadorpmc)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: coordinadores,
                      tipoCampo: TipoCampo.texto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.clasificacion,
                      campo: Campo.clasificacion,
                      label: 'Clasificación',
                      color: clasificacion.contains(data.clasificacion)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: clasificacion,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.subclasificacion,
                      campo: Campo.subclasificacion,
                      label: 'Subclasificación',
                      color: subclasificacion.contains(data.subclasificacion)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: subclasificacion,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.cantidadincumplimientos,
                      campo: Campo.cantidadincumplimientos,
                      label: 'Ctd Incumplimientos',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                      isNumber: true,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.valor,
                      campo: Campo.valor,
                      label: 'Valor Total',
                      color: data.valor.isEmpty ? Colors.red : Colors.green,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                      isNumber: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.medio,
                      campo: Campo.medio,
                      label: 'Medio',
                      color: medio.contains(data.medio)
                          ? Colors.green
                          : Colors.red,
                      edit: editAllFields,
                      opciones: medio,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.inspeccion,
                      campo: Campo.inspeccion,
                      label: 'Inspección',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.switcher,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.numinspeccion,
                      campo: Campo.numinspeccion,
                      label: '# Inspección',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.titulo,
                      campo: Campo.titulo,
                      label: 'Titulo',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.proyecto,
                      campo: Campo.proyecto,
                      label: 'Proyecto',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                    const SizedBox(width: 10),
                    FieldPre(
                      flex: 1,
                      initialValue: data.nt,
                      campo: Campo.nt,
                      label: 'Area',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.descripcion,
                      campo: Campo.descripcion,
                      label: 'Descripción',
                      color:
                          data.descripcion.isEmpty ? Colors.red : Colors.green,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    FieldPre(
                      flex: 1,
                      initialValue: data.observaciongeneral,
                      campo: Campo.observaciongeneral,
                      label: 'Observaciones',
                      color: Colors.grey,
                      edit: editAllFields,
                      tipoCampo: TipoCampo.texto,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CardEstado(
                    background: background,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            'Solicitado',
                            style: titleMedium,
                          ),
                          Icon(
                            Icons.outgoing_mail,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FieldPre(
                            flex: 1,
                            initialValue: data.solradicado,
                            campo: Campo.solradicado,
                            label: 'Radicado',
                            color: data.solradicado.isEmpty
                                ? Colors.red
                                : Colors.green,
                            edit: editAllFields,
                            tipoCampo: TipoCampo.texto,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FieldPre(
                            flex: 1,
                            initialValue: data.solfecha,
                            campo: Campo.solfecha,
                            label: 'Fecha de Radicado',
                            color: data.solfecha.isEmpty
                                ? Colors.red
                                : Colors.green,
                            edit: editAllFields,
                            tipoCampo: TipoCampo.fecha,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FieldPre(
                            flex: 1,
                            initialValue: data.soldestinatario,
                            campo: Campo.soldestinatario,
                            label: 'Destinatario',
                            color: data.soldestinatario.isEmpty
                                ? Colors.red
                                : Colors.green,
                            edit: editAllFields,
                            tipoCampo: TipoCampo.texto,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FieldPre(
                            flex: 1,
                            initialValue: data.soladjunto,
                            campo: Campo.soladjunto,
                            label: 'Adjunto',
                            color: Colors.grey,
                            edit: editAllFields,
                            tipoCampo: TipoCampo.file,
                            carpeta: "SOLICITADO",
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          FieldPre(
                            flex: 1,
                            initialValue: data.solobservacion,
                            campo: Campo.solobservacion,
                            label: 'Observaciones',
                            color: Colors.grey,
                            edit: editAllFields,
                            tipoCampo: TipoCampo.texto,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CardEstado(
                    background: background,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            'Respuesta',
                            style: titleMedium,
                          ),
                          Icon(
                            Icons.pending_actions,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) {
                          if (widget.esNuevo) {
                            if (data.solradicado.isEmpty ||
                                data.solfecha.isEmpty ||
                                data.soldestinatario.isEmpty) {
                              return const Text(
                                'sin datos completos en solicitado',
                              );
                            }
                            if (!(response || failResponse)) {
                              return OverflowBar(
                                spacing: 10,
                                children: [
                                  ElevatedButton(
                                    child: const Text('Ya tengo una respuesta'),
                                    onPressed: () {
                                      setState(() => response = !response);
                                    },
                                  ),
                                  ElevatedButton(
                                    child:
                                        const Text('El contrato no respondio'),
                                    onPressed: () {
                                      setState(
                                          () => failResponse = !failResponse);
                                    },
                                  ),
                                ],
                              );
                            }
                            if (failResponse) {
                              return ElevatedButton(
                                child: const Text('El contrato si respondio'),
                                onPressed: () {
                                  setState(() => failResponse = !failResponse);
                                },
                              );
                            }
                          }
                          return Column(
                            children: [
                              ElevatedButton(
                                child: const Text('Esperare respuesta'),
                                onPressed: () {
                                  setState(() => response = !response);
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  FieldPre(
                                    flex: 1,
                                    initialValue: data.resradicado,
                                    campo: Campo.resradicado,
                                    label: 'Radicado',
                                    color: data.resradicado.isEmpty
                                        ? Colors.red
                                        : Colors.green,
                                    edit: editAllFields,
                                    tipoCampo: TipoCampo.texto,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  FieldPre(
                                    flex: 1,
                                    initialValue: data.resfecha,
                                    campo: Campo.resfecha,
                                    label: 'Fecha de Radicado',
                                    color: data.resfecha.isEmpty
                                        ? Colors.red
                                        : Colors.green,
                                    edit: editAllFields,
                                    tipoCampo: TipoCampo.fecha,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  FieldPre(
                                    flex: 1,
                                    initialValue: data.resadjunto,
                                    campo: Campo.resadjunto,
                                    label: 'Adjunto',
                                    color: Colors.grey,
                                    edit: editAllFields,
                                    tipoCampo: TipoCampo.file,
                                    carpeta: "RESPUESTA",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  FieldPre(
                                    flex: 1,
                                    initialValue: data.resobservacion,
                                    campo: Campo.resobservacion,
                                    label: 'Observaciones',
                                    color: Colors.grey,
                                    edit: editAllFields,
                                    tipoCampo: TipoCampo.texto,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  CardEstado(
                    background: background,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            'Réplica',
                            style: titleMedium,
                          ),
                          Icon(
                            Icons.airline_stops,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        if (widget.esNuevo) {
                          if (data.solradicado.isEmpty ||
                              data.solfecha.isEmpty ||
                              data.soldestinatario.isEmpty) {
                            return const Text(
                                'sin datos completos en solicitado');
                          }
                          if ((data.resradicado.isEmpty ||
                                  data.resfecha.isEmpty ||
                                  !response) &&
                              !failResponse) {
                            return const Text(
                                'sin datos completos en respuesta');
                          }
                          if (!(replica || failReplica)) {
                            return OverflowBar(
                              spacing: 10,
                              children: [
                                ElevatedButton(
                                  child: const Text('Ya tengo una replica'),
                                  onPressed: () {
                                    setState(() => replica = !replica);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('No se dio replica'),
                                  onPressed: () {
                                    setState(() => failReplica = !failReplica);
                                  },
                                ),
                              ],
                            );
                          }
                          if (failReplica) {
                            return ElevatedButton(
                              child: const Text('Si se dio replica'),
                              onPressed: () {
                                setState(() => failReplica = !failReplica);
                              },
                            );
                          }
                        }
                        return Column(
                          children: [
                            ElevatedButton(
                              child: const Text('Esperare replica'),
                              onPressed: () {
                                setState(() => replica = !replica);
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.repradicado,
                                  campo: Campo.repradicado,
                                  label: 'Radicado',
                                  color: data.repradicado.isEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.repfecha,
                                  campo: Campo.repfecha,
                                  label: 'Fecha de Radicado',
                                  color: data.repfecha.isEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.fecha,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.repadjunto,
                                  campo: Campo.repadjunto,
                                  label: 'Adjunto',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.file,
                                  carpeta: "REPLICA",
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.repobservacion,
                                  campo: Campo.repobservacion,
                                  label: 'Observaciones',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  CardEstado(
                    background: background,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          Text(
                            'Factura',
                            style: titleMedium,
                          ),
                          Icon(
                            Icons.sports_score,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Builder(builder: (context) {
                        if (widget.esNuevo) {
                          if (data.solradicado.isEmpty ||
                              data.solfecha.isEmpty ||
                              data.soldestinatario.isEmpty) {
                            return const Text(
                                'sin datos completos en solicitado');
                          }
                          if ((data.resradicado.isEmpty ||
                                  data.resfecha.isEmpty ||
                                  !response) &&
                              !failResponse) {
                            return const Text(
                                'sin datos completos en respuesta');
                          }
                          if ((data.repradicado.isEmpty ||
                              data.repfecha.isEmpty ||
                              !replica) && !failReplica) {
                            return const Text('sin datos completos en replica');
                          }
                          if (!(factura || failFactura)) {
                            return OverflowBar(
                              spacing: 10,
                              children: [
                                ElevatedButton(
                                  child: const Text('Ya tengo una factura'),
                                  onPressed: () {
                                    setState(() => factura = !factura);
                                  },
                                ),
                                ElevatedButton(
                                  child: const Text('No se dio factura'),
                                  onPressed: () {
                                    setState(() => failFactura = !failFactura);
                                  },
                                ),
                              ],
                            );
                          }
                          if (failFactura) {
                            return ElevatedButton(
                              child: const Text('Si se dio factura'),
                              onPressed: () {
                                setState(() => failFactura = !failFactura);
                              },
                            );
                          }
                        }
                        return Column(
                          children: [
                            ElevatedButton(
                              child: const Text('Esperare factura'),
                              onPressed: () {
                                setState(() => factura = !factura);
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.facfactura,
                                  campo: Campo.facfactura,
                                  label: 'Factura',
                                  color: data.facfactura.isEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.facfecha,
                                  campo: Campo.facfecha,
                                  label: 'Fecha de Radicado',
                                  color: data.facfecha.isEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.fecha,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.facvalor,
                                  campo: Campo.facvalor,
                                  label: 'Valor Final',
                                  color: data.facvalor.isEmpty
                                      ? Colors.red
                                      : Colors.green,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                  isNumber: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.facadjunto,
                                  campo: Campo.facadjunto,
                                  label: 'Adjunto',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.file,
                                  carpeta: "FACTURA",
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.facobservacion,
                                  campo: Campo.facobservacion,
                                  label: 'Observaciones',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.soportepago,
                                  campo: Campo.soportepago,
                                  label: 'Soporte de Pago',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.texto,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                FieldPre(
                                  flex: 1,
                                  initialValue: data.soportepagoadjunto,
                                  campo: Campo.soportepagoadjunto,
                                  label: 'Soporte de Pago (adjunto)',
                                  color: Colors.grey,
                                  edit: editAllFields,
                                  tipoCampo: TipoCampo.file,
                                  carpeta: "FACTURA",
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}



class BodySingle extends StatelessWidget {
  final List<Widget> children;
  const BodySingle({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
