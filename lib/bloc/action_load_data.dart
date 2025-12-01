import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:premi_1/desplegables/clasificacion_model.dart';
import 'package:premi_1/desplegables/nt_model.dart';
import 'package:premi_1/desplegables/subclasificacion_model.dart';

import '../Todos/todos_model.dart';
import '../desplegables/coordinador_model.dart';
import '../desplegables/empresa_model.dart';
import '../desplegables/medio_model.dart';
import '../desplegables/solicitante_model.dart';
import '../users/controller/users_action.dart';
import 'action_color.dart';
import 'action_load_ud.dart';
import 'main_bloc.dart';

onLoadData(
  Load event,
  emit,
  MainState Function() state,
) async {
  //blanqueo de valores
  state().initial();
  // nt = Nt();
  // clasificacion = Clasificacion();
  // solicitante = Solicitante();
  // empresa = Empresa();
  // medio = Medio();
  // registros = Registros();
  //carga de datos
  // add(Loading(isLoading: true));
  emit(state().copyWith(isLoading: true));
  FutureGroup futureGroup0 = FutureGroup();
  futureGroup0.add(onLoadPerfiles(event, emit, state));
  futureGroup0.add(onLoadUsers(event, emit, state));
  futureGroup0.close();
  FutureGroup futureGroup = FutureGroup();
  futureGroup.add(futureGroup0.future
      .whenComplete(() => onLoadUserData(event, emit, state)));
  futureGroup.add(themeLoader(event, emit, state));
  futureGroup.add(themeColorLoader(event, emit, state));
  futureGroup.add(onLoadNt(event, emit, state));
  futureGroup.add(onLoadClasificacion(event, emit, state));
  futureGroup.add(onLoadEmpresa(event, emit, state));
  futureGroup.add(onLoadMedio(event, emit, state));
  futureGroup.add(onLoadSolicitante(event, emit, state));
  futureGroup.add(onLoadRegistros(event, emit, state));
  futureGroup.add(onLoadCoordinador(event, emit, state));
  futureGroup.add(onLoadSubClasificacion(event, emit, state));
  futureGroup.close();
  try {
    await futureGroup.future;
    // print('datos cargados');
    // emit(state().copyWith());
  } catch (e) {
    // ignore: avoid_print
    print(e);
    emit(state().copyWith(
      message: 'error cargando datos => $e',
      errorCounter: state().errorCounter + 1,
      messageColor: Colors.red,
    ));
  }
  // print('fin de carga de datos' );
  // add(Loading(isLoading: false));
  emit(state().copyWith(isLoading: false));
}

// onLoadUserData(Load event, emit, MainState Function() state) {
// }

onLoadNt(event, emit, MainState Function() state) async {
  Nt nt = Nt();
  // print('onLoadNt');
  try {
    await nt.obtener();
    emit(state().copyWith(nt: nt));
    // print('nt: ${state().nt?.ntlist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 los niveles de tensión ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadClasificacion(event, emit, MainState Function() state) async {
  Clasificacion clasificacion = Clasificacion();
  // print('onLoadNt');
  try {
    await clasificacion.obtener();
    emit(state().copyWith(clasificacion: clasificacion));
    // print('clasificacion: ${state().clasificacion?.clasificacionlist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 las clasificaciones ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadSubClasificacion(event, emit, MainState Function() state) async {
  Subclasificacion subclasificacion = Subclasificacion();
  // print('onLoadNt');
  try {
    await subclasificacion.obtener();
    emit(state().copyWith(subclasificacion: subclasificacion));
    // print('clasificacion: ${state().clasificacion?.clasificacionlist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 las subclasificacion ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadEmpresa(event, emit, MainState Function() state) async {
  Empresa empresa = Empresa();
  // print('onLoadNt');
  try {
    await empresa.obtener();
    emit(state().copyWith(empresa: empresa));
    // print('empresa: ${state().empresa?.empresalist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de empresas ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadMedio(event, emit, MainState Function() state) async {
  Medio medio = Medio();
  // print('onLoadNt');
  try {
    await medio.obtener();
    emit(state().copyWith(medio: medio));
    // print('medio: ${state().medio?.mediolist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de medios ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadSolicitante(event, emit, MainState Function() state) async {
  Solicitante solicitante = Solicitante();
  // print('onLoadNt');
  try {
    await solicitante.obtener();
    emit(state().copyWith(solicitante: solicitante));
    // print('solicitante: ${state().solicitante?.solicitantelist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de solicitantes ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadRegistros(event, emit, MainState Function() state) async {
  Registros registros = Registros();
  // print('onLoadNt');
  try {
    await registros.obtener();
    emit(state().copyWith(registros: registros));
    // print('registros: ${state().registros?.registroslist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de registros ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

onLoadCoordinador(event, emit, MainState Function() state) async {
  Coordinador coordinador = Coordinador();
  // print('onLoadNt');
  try {
    await coordinador.obtener();
    emit(state().copyWith(coordinador: coordinador));
    // print('registros: ${state().registros?.registroslist??''}');
  } catch (e) {
    // print(e);
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de registros ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}
