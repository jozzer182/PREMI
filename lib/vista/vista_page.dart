// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/bloc/main_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/version.dart';
import 'package:url_launcher/url_launcher.dart';

class VistaPage extends StatefulWidget {
  final RegistrosSingle registro;
  const VistaPage({
    required this.registro,
    super.key,
  });

  @override
  State<VistaPage> createState() => _VistaPageState();
}

class _VistaPageState extends State<VistaPage> {

  @override
  Widget build(BuildContext context) {
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
        title: SelectableText(widget.registro.id),
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
                          child: TextFormField(
                            initialValue: widget.registro.empresa,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Empresa',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.registro.contrato,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Contrato',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.registro.solicitante,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Solicitante',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.registro.coordinadorpmc,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
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
                          child: TextFormField(
                            initialValue: widget.registro.clasificacion,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Clasificación',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.registro.subclasificacion,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'SubClasificación',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Expanded(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       width < 750
                        //           ? const SizedBox()
                        //           : const Text('Tipos:'),
                        //       ActionChip(
                        //         onPressed: (){},
                        //         label: const Text('I'),
                        //         backgroundColor: widget.registro.i == 'x'
                        //             ? primaryContainer
                        //             : null,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       ActionChip(
                        //         onPressed: (){},
                        //         label: const Text('II'),
                        //         backgroundColor: widget.registro.ii == 'x'
                        //             ? primaryContainer
                        //             : null,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       ActionChip(
                        //         onPressed: (){},
                        //         label: const Text('III'),
                        //         backgroundColor: widget.registro.iii == 'x'
                        //             ? primaryContainer
                        //             : null,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue:
                                widget.registro.cantidadincumplimientos,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Cantidad Incumplimientos',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            initialValue: widget.registro.valor,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Valor Total',
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
                            initialValue: widget.registro.medio,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Medio',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (width < 579 &&
                                  widget.registro.inspeccion == 'x')
                                const SizedBox()
                              else
                                const Text('Inspección:'),
                              Checkbox(
                                value: widget.registro.inspeccion == 'x',
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (!(widget.registro.inspeccion == 'x'))
                          const SizedBox()
                        else
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    initialValue: widget.registro.numinspeccion,
                                    readOnly: true,
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
                            initialValue: widget.registro.titulo,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                              labelText: 'Titulo',
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
                            initialValue: widget.registro.proyecto,
                            readOnly: true,
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
                          child: TextFormField(
                            initialValue: widget.registro.numinspeccion,
                            readOnly: true,
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
                            initialValue: widget.registro.descripcion,
                            readOnly: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
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
                            initialValue: widget.registro.observaciongeneral,
                            readOnly: true,
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
                                          initialValue:
                                              widget.registro.solradicado,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
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
                                          initialValue:
                                              widget.registro.solfecha,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Fecha',
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
                                          initialValue:
                                              widget.registro.soldestinatario,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Destinatario',
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
                                          onTap: () async {
                                            var url = Uri.parse(
                                                widget.registro.soladjunto);
                                            await launchUrl(url);
                                          },
                                          initialValue:
                                              widget.registro.soladjunto,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Adjunto',
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
                                          initialValue:
                                              widget.registro.solobservacion,
                                          readOnly: true,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          initialValue:
                                              widget.registro.resradicado,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
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
                                          initialValue:
                                              widget.registro.resfecha,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Fecha',
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
                                          onTap: () async {
                                            var url = Uri.parse(
                                                widget.registro.resadjunto);
                                            await launchUrl(url);
                                          },
                                          initialValue:
                                              widget.registro.resadjunto,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Adjunto',
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
                                          initialValue:
                                              widget.registro.resfecha,
                                          readOnly: true,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          initialValue:
                                              widget.registro.repradicado,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
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
                                          initialValue:
                                              widget.registro.repfecha,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Fecha',
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
                                          onTap: () async {
                                            var url = Uri.parse(
                                                widget.registro.repadjunto);
                                            await launchUrl(url);
                                          },
                                          initialValue:
                                              widget.registro.repadjunto,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Adjunto',
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
                                          initialValue:
                                              widget.registro.repobservacion,
                                          readOnly: true,
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
                                        style: titleMedium,
                                      ),
                                      Icon(
                                        Icons.sports_score,
                                        color: primary,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          initialValue:
                                              widget.registro.facfactura,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Factura',
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
                                          initialValue:
                                              widget.registro.facfecha,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Fecha',
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
                                          initialValue:
                                              widget.registro.facvalor,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Valor Final',
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
                                          onTap: () async {
                                            var url = Uri.parse(
                                                widget.registro.facadjunto);
                                            await launchUrl(url);
                                          },
                                          initialValue:
                                              widget.registro.facadjunto,
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            border: OutlineInputBorder(),
                                            labelText: 'Adjunto',
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
                                          initialValue:
                                              widget.registro.facobservacion,
                                          readOnly: true,
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
