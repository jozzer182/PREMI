// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/apremio/model/apremio_model.dart';
import 'package:premi_1/apremio/view/apremio_page.dart';
import 'package:premi_1/dialogs/fact_dialog.dart';
import 'package:premi_1/dialogs/finish_dialog.dart';
import 'package:premi_1/dialogs/reply_dialog.dart';
import 'package:premi_1/dialogs/response_dialog.dart';

import '../bloc/main_bloc.dart';
import '../user/model/user_model.dart';

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CupertinoPageTransition(
        primaryRouteAnimation:
            CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: false,
        child: child,
      );
    },
  );
}

class CardDataRow extends StatelessWidget {
  final RegistrosSingle registro;
  Color solicitadoColor = Colors.grey;
  Color respuestaColor = Colors.grey;
  Color replicaColor = Colors.grey;
  Color facturaColor = Colors.grey;
  Color estadoColor = Colors.green[300]!;
  CardDataRow({
    required this.registro,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void goTo(Widget page) {
      Navigator.push(context, _createRoute(page));
    }

    Color tertiary = Theme.of(context).colorScheme.tertiary;
    if (registro.solestado == 'a tiempo') solicitadoColor = Colors.green[200]!;
    if (registro.solestado == 'en tiempo') solicitadoColor = Colors.green[300]!;
    if (registro.solestado == 'vencido') solicitadoColor = Colors.red[300]!;
    if (registro.solestado == 'tardio') solicitadoColor = Colors.orange[200]!;
    if (registro.resestado == 'a tiempo') respuestaColor = Colors.green[200]!;
    if (registro.resestado == 'vencido') respuestaColor = Colors.red[300]!;
    if (registro.resestado == 'tardio') respuestaColor = Colors.orange[200]!;
    if (registro.resestado == 'no informado') respuestaColor = Colors.white;
    if (registro.repestado == 'a tiempo') replicaColor = Colors.green[200]!;
    if (registro.repestado == 'en tiempo') replicaColor = Colors.green[300]!;
    if (registro.repestado == 'vencido') replicaColor = Colors.red[300]!;
    if (registro.repestado == 'tardio') replicaColor = Colors.orange[200]!;
    if (registro.repestado == 'no informado') replicaColor = Colors.white;
    if (registro.facestado == 'a tiempo') facturaColor = Colors.green[200]!;
    if (registro.facestado == 'vencido') facturaColor = Colors.red[300]!;
    if (registro.facestado == 'tardio') facturaColor = Colors.orange[200]!;
    if (registro.facestado == 'no facturado') facturaColor = Colors.green[800]!;
    if (registro.facestado == 'facturado') facturaColor = Colors.green[200]!;
    if (registro.estado.contains('vencido')) estadoColor = Colors.red[300]!;
    if (registro.estado.contains('facturado')) estadoColor = Colors.grey;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 82,
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          Icon(
                            Icons.square,
                            size: 10,
                            color: estadoColor,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              context.read<MainBloc>().add(
                                    SetApremio(
                                      apremio:
                                          Apremio.fromRegistrosSingle(registro),
                                    ),
                                  );
                              goTo(
                                const ApremioPage(esNuevo: false),
                              );
                              // goTo(
                              //   VistaPage(
                              //     registro: registro,
                              //   ),
                              // );
                            },
                            child: Text('#${registro.id}'),
                          ),
                          const SizedBox(width: 10),
                          Text(registro.empresa),
                          const SizedBox(width: 10),
                          Text("- ${registro.titulo}"),
                          const SizedBox(width: 30),
                          Text(
                            "👉 ${registro.coordinadorpmc}",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 3),
                              AutoSizeText(
                                registro.solicitante,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                registro.solfecha,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.pending,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                registro.clasificacion,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.monetization_on_outlined,
                                size: 12,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                registro.facvalor.isEmpty
                                    ? registro.valor
                                    : registro.facvalor,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          Icon(
                            Icons.outgoing_mail,
                            color: solicitadoColor,
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              thickness: 1,
                            ),
                          ),
                          Icon(
                            Icons.pending_actions,
                            color: respuestaColor,
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              thickness: 1,
                            ),
                          ),
                          Icon(
                            Icons.airline_stops,
                            color: replicaColor,
                          ),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              thickness: 1,
                            ),
                          ),
                          Icon(
                            Icons.sports_score,
                            color: facturaColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (registro.estado.contains('facturado'))
                  const SizedBox()
                else
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      if (state.user == null) {
                        return const SizedBox();
                      }
                      User user = state.user!;
                      return Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: typeDialog(
                                estado: registro.estado,
                                context: context,
                                registro: registro,
                                cambiarEstado: user.permisos
                                    .contains('premi_cambiar_estado'),
                              ),
                              child: Icon(
                                Icons.directions_sharp,
                                color: tertiary,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (user.permisos
                                    .contains('premi_cambiar_estado')) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return FinishDialog(
                                        registro: registro,
                                      );
                                    },
                                  );
                                }
                              },
                              child: Icon(
                                Icons.sports_score,
                                color: tertiary,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

typeDialog({
  required String estado,
  required BuildContext context,
  required RegistrosSingle registro,
  required bool cambiarEstado,
}) {
  if (cambiarEstado) {
    if (estado.contains('solicitado')) {
      return () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return ResponseDialog(
                registro: registro,
              );
            },
          );
    }
    if (estado.contains('respuesta')) {
      return () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return ReplyDialog(
                registro: registro,
              );
            },
          );
    }
    if (estado.contains('replica')) {
      return () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return FactDialog(
                registro: registro,
              );
            },
          );
    }
  }
  return () {};
}
