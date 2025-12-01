import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:premi_1/Home/card_data.dart';
import 'package:premi_1/Home/listeners.dart';
import 'package:premi_1/Todos/facturados_page.dart';
import 'package:premi_1/Todos/replicas_page.dart';
import 'package:premi_1/Todos/respuestas_page.dart';
import 'package:premi_1/Todos/solicitados_page.dart';
import 'package:premi_1/Todos/todos_page.dart';
import 'package:premi_1/apremio/view/apremio_page.dart';
import 'package:premi_1/version.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ans_seguridad/view/ans_seguridad_page.dart';
import '../bloc/main_bloc.dart';
import '../user/model/user_model.dart';

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return CupertinoPageTransition(
        primaryRouteAnimation: CurveTween(
          curve: Curves.easeInOutCirc,
        ).animate(animation),
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: false,
        child: child,
      );
    },
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double elevationCard1 = 1.0;
  double elevationCard2 = 1.0;
  double elevationCard3 = 1.0;
  double elevationCard4 = 1.0;
  double elevationCard5 = 1.0;
  @override
  Widget build(BuildContext context) {
    Color primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    Color onPrimaryContainer = Theme.of(context).colorScheme.onPrimaryContainer;
    Color tertiaryContainer = Theme.of(context).colorScheme.tertiaryContainer;
    Color onTertiaryContainer =
        Theme.of(context).colorScheme.onTertiaryContainer;
    Color secondaryContainer = Theme.of(context).colorScheme.secondaryContainer;
    Color onSecondaryContainer =
        Theme.of(context).colorScheme.onSecondaryContainer;
    Color background = Theme.of(context).colorScheme.surface;
    Color onBackground = Theme.of(context).colorScheme.onSurface;
    Color primary = Theme.of(context).colorScheme.primary;
    void goTo(Widget page) {
      Navigator.push(context, _createRoute(page));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PREMI+",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: primary,
            fontWeight: FontWeight.w900,
          ),
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
        actions: [
          ElevatedButton(
            onPressed: () {
              launchUrl(
                Uri.parse(
                  'https://enelcom.sharepoint.com/sites/ProjectManagementConstructionColombia/cm/SitePages/PREMI.aspx',
                ),
              );
            },
            child: const Text('Ayuda'),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              showDialog(
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Escoge un color'),
                    content: SingleChildScrollView(
                      child: MaterialColorPicker(
                        allowShades: false,
                        onMainColorChange: (value) {
                          if (value != null) {
                            BlocProvider.of<MainBloc>(
                              context,
                            ).add(ThemeColorChange(color: Color(value.value)));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  );
                },
                context: context,
              );
            },
            icon: const Icon(Icons.color_lens),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              BlocProvider.of<MainBloc>(context).add(ThemeChange());
            },
            icon: const Icon(Icons.brightness_4_outlined),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.logout, color: primary, size: 16),
            onPressed: () async => await FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(version.data, style: Theme.of(context).textTheme.labelSmall),
            Text(
              version.status('Home', '$runtimeType'),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],
      floatingActionButton: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state.user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          User user = state.user!;
          return FloatingActionButton(
            onPressed: () {
              if (user.permisos.contains('premi_nuevo')) {
                goTo(const ApremioPage(esNuevo: true));
                // goTo(const NuevoPage());
              }
            },
            child: const Icon(Icons.add),
          );
        },
      ),
      body: Listeners(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state.user == null || state.registros == null) {
                return const Center(child: CircularProgressIndicator());
              }
              // User user = state.user!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'A PEDIDO',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(10),
                    GridView(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.5,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                      children: [
                        CardData(
                          elevationCard: elevationCard1,
                          color: primaryContainer,
                          colorText: onPrimaryContainer,
                          icon1: Icons.outgoing_mail,
                          number1: state.registros?.totalSolicitados,
                          title1: "Solicitados",
                          number2: state.registros?.totalSolicitadosVencidos,
                          title2: "Vencidos",
                          onTap: () {
                            goTo(const SolicitadosPage());
                          },
                          onTapDown:
                              (details) => setState(() => elevationCard1 = 0.0),
                          onHover:
                              (hover) => setState(
                                () => elevationCard1 = hover ? 3.0 : 1.0,
                              ),
                        ),
                        CardData(
                          elevationCard: elevationCard2,
                          color: tertiaryContainer,
                          colorText: onTertiaryContainer,
                          icon1: Icons.pending_actions,
                          number1: state.registros?.totalRespuesta,
                          title1: "Respuestas",
                          number2: state.registros?.totalRespuestaVencidos,
                          title2: "Vencidos",
                          onTap: () {
                            goTo(const RespuestasPage());
                          },
                          onTapDown:
                              (details) => setState(() => elevationCard2 = 0.0),
                          onHover:
                              (hover) => setState(
                                () => elevationCard2 = hover ? 3.0 : 1.0,
                              ),
                        ),
                        CardData(
                          elevationCard: elevationCard3,
                          color: secondaryContainer,
                          colorText: onSecondaryContainer,
                          icon1: Icons.airline_stops,
                          number1: state.registros?.totalReplica,
                          title1: "Réplicas",
                          number2: state.registros?.totalReplicaVencidos,
                          title2: "Vencidos",
                          onTap: () {
                            goTo(const ReplicasPage());
                          },
                          onTapDown:
                              (details) => setState(() => elevationCard3 = 0.0),
                          onHover:
                              (hover) => setState(
                                () => elevationCard3 = hover ? 3.0 : 1.0,
                              ),
                        ),
                        CardData(
                          elevationCard: elevationCard4,
                          color: background,
                          colorText: onBackground,
                          icon1: Icons.sports_score,
                          number1: state.registros?.totalFactura,
                          title1: "Facturados",
                          number2: state.registros?.totalFacturaVencidos,
                          title2: "Cerrados SF",
                          onTap: () {
                            goTo(const FacturadosPage());
                          },
                          onTapDown:
                              (details) => setState(() => elevationCard4 = 0.0),
                          onHover:
                              (hover) => setState(
                                () => elevationCard4 = hover ? 3.0 : 1.0,
                              ),
                        ),
                        CardData(
                          elevationCard: elevationCard5,
                          color: tertiaryContainer,
                          colorText: onTertiaryContainer,
                          icon1: Icons.fact_check,
                          number1: state.registros?.totalRegistros,
                          title1: "Todos",
                          number2: state.registros?.totalRegistrosVencidos,
                          title2: "Vencidos",
                          onTap: () {
                            goTo(const TodosPage());
                          },
                          onTapDown:
                              (details) => setState(() => elevationCard5 = 0.0),
                          onHover:
                              (hover) => setState(
                                () => elevationCard5 = hover ? 3.0 : 1.0,
                              ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     goTo(const ApremioPage(esNuevo: true));
                        //   },
                        //   child: Card(
                        //     child: Text('Nuevo de prueba'),
                        //   ),
                        // )
                      ],
                    ),
                    const Gap(10),
                    Text(
                      'CÍCLICOS',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Gap(10),
                    BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        return GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                              ),
                          children: [
                            ElevatedButton(
                              onPressed: 
                              // null,
                              // state.nuevoIngresoB == null ||
                              //         !user.permisos.contains(
                              //           "nuevo_ingreso",
                              //         )
                              //     ? null
                              //     : 
                                  () => goTo(const AnsSeguridadPage()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                              ),
                              child: Text(
                                'ANS SEGURIDAD\n[EN DESARROLLO]',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: null,
                              // state.nuevoTrasladoB == null ||
                              //         !user.permisos.contains(
                              //           "nuevo_traslado",
                              //         )
                              //     ? null
                              //     : () => goTo(TrasladoScreen()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.tertiary,
                              ),

                              child: Text(
                                'ANS OPERATIVOS\n[EN DESARROLLO]',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
