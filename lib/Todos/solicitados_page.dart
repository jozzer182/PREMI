import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/Todos/todos_u_row.dart';
import 'package:premi_1/resources/descarga_hojas.dart';

import '../bloc/main_bloc.dart';
import '../version.dart';

class SolicitadosPage extends StatefulWidget {
  const SolicitadosPage({super.key});
  @override
  State<SolicitadosPage> createState() => _SolicitadosPageState();
}

class _SolicitadosPageState extends State<SolicitadosPage> {
  bool _isLoading = true;
  final ScrollController _controller = ScrollController();

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('cargando mas datos');
      BlocProvider.of<MainBloc>(context).add(
        ListLoadMore(table: 'solicitados'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 800), () {
      setState(() => _isLoading = false);
    });
    _controller.addListener(_onScroll);
    context.read<MainBloc>().add(Busqueda(value: ' ', table: 'Solicitados'));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    Color primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'SolicitadosIcon',
              child: Material(
                type: MaterialType.transparency,
                child: Icon(
                  Icons.fact_check,
                  color: primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Hero(
              tag: 'Solicitados',
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  'Solicitados',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              return Row(
                children: [
                  Text(
                    'Total: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: primary,
                          fontSize: 15,
                        ),
                  ),
                  Hero(
                    tag: 'Solicitadosn1',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        '${state.registros?.totalSolicitados ?? 'error'}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: primary,
                                  fontSize: 15,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Hero(
                    tag: 'Solicitadost1',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        'Vencidos: ',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: primary,
                                  fontSize: 15,
                                ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'Solicitadosn2',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        '${state.registros?.totalSolicitadosVencidos ?? 'error'}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: primary,
                                  fontSize: 15,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              );
            },
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
              version.status('Solicitados', '$runtimeType'),
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
      ],
      floatingActionButton: BlocSelector<MainBloc, MainState, Registros?>(
        selector: (state) => state.registros,
        builder: (context, state) {
          if (state == null) return const CircularProgressIndicator();
          return FloatingActionButton(
            onPressed: () {
              descarga.ahora(
                  datos: state.solicitadosList, nombre: 'Solicitados');
            },
            child: const Icon(Icons.download),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //1st line of filters
            filters1(),
            const SizedBox(height: 10),
            // //2nd line of filters
            // const Filters2(),
            // const SizedBox(height: 10),
            //Table of data
            if (_isLoading)
              const SizedBox()
            else
              Expanded(
                child: SingleChildScrollView(
                  controller: _controller,
                  child: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      List<RegistrosSingle> registros =
                          state.registros?.solicitadosListSearch ?? [];
                      int endList = (state.registros?.viewSolicitados ?? 0) >
                              registros.length
                          ? registros.length
                          : state.registros?.viewSolicitados ?? 0;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: registros.sublist(0, endList).length,
                        itemBuilder: (context, index) => CardDataRow(
                            registro: registros.sublist(0, endList)[index]),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget filters1() {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButtonFormField(
                items: state.registros?.solicitadosList
                        .map((e) => e.solicitante)
                        .toSet()
                        .toList()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList() ??
                    [],
                onChanged: (value) {
                  context.read<MainBloc>().add(
                      Busqueda(value: value.toString(), table: "Solicitados"));
                },
                isExpanded: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                  labelText: 'Solicitante',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField(
                items: state.registros?.solicitadosList
                        .map((e) => e.empresa)
                        .toSet()
                        .toList()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList() ??
                    [],
                onChanged: (value) {
                  context.read<MainBloc>().add(
                      Busqueda(value: value.toString(), table: "Solicitados"));
                },
                isExpanded: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                  labelText: 'Empresa',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: DropdownButtonFormField(
                items: state.registros?.solicitadosList
                        .map((e) => e.clasificacion)
                        .toSet()
                        .toList()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList() ??
                    [],
                onChanged: (value) {
                  context.read<MainBloc>().add(
                      Busqueda(value: value.toString(), table: "Solicitados"));
                },
                isExpanded: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                  labelText: 'Clasificación',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: TextFormField(
                onChanged: (value) {
                  context.read<MainBloc>().add(
                      Busqueda(value: value.toString(), table: "Solicitados"));
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                  labelText: 'Búsqueda',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Filters2 extends StatefulWidget {
  const Filters2({super.key});

  @override
  State<Filters2> createState() => _Filters2State();
}

class _Filters2State extends State<Filters2> {
  bool iSelected = true;
  bool iiSelected = true;
  bool iiiSelected = true;
  @override
  Widget build(BuildContext context) {
    Color primaryContainer = Theme.of(context).colorScheme.primaryContainer;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Text('Tipo Apremio: '),
              ActionChip(
                label: const Text('I'),
                onPressed: () {
                  setState(() {
                    iSelected = !iSelected;
                  });
                },
                backgroundColor: iSelected ? primaryContainer : null,
              ),
              const SizedBox(width: 5),
              ActionChip(
                label: const Text('II'),
                onPressed: () {
                  setState(() {
                    iiSelected = !iiSelected;
                  });
                },
                backgroundColor: iiSelected ? primaryContainer : null,
              ),
              const SizedBox(width: 5),
              ActionChip(
                label: const Text('III'),
                onPressed: () {
                  setState(() {
                    iiiSelected = !iiiSelected;
                  });
                },
                backgroundColor: iiiSelected ? primaryContainer : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
