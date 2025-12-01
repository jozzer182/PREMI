// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_print


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/apremio/model/apremio_enum.dart';
import 'package:premi_1/apremio/model/apremio_model.dart';
import 'package:premi_1/desplegables/clasificacion_model.dart';
import 'package:premi_1/desplegables/coordinador_model.dart';
import 'package:premi_1/desplegables/empresa_model.dart';
import 'package:premi_1/desplegables/medio_model.dart';
import 'package:premi_1/desplegables/nt_model.dart';
import 'package:premi_1/desplegables/solicitante_model.dart';
import 'package:premi_1/desplegables/subclasificacion_model.dart';

import '../apremio/controller/apremio_action.dart';
import '../user/model/user_model.dart';
import '../users/model/perfiles_model.dart';
import '../users/model/users_model.dart';
import 'action_color.dart';
import 'action_load_data.dart';
part 'main_event.dart';
part 'main_state.dart';
part '../apremio/controller/apremio_events.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  Nt nt = Nt();
  Clasificacion clasificacion = Clasificacion();
  Solicitante solicitante = Solicitante();
  Empresa empresa = Empresa();
  Medio medio = Medio();
  Registros registros = Registros();
  Coordinador coordinador = Coordinador();
  MainBloc() : super(MainState()) {
    on<Load>((ev, em) => onLoadData(ev, em, supraState));
    on<NewMessage>(onNewMessage);
    on<Loading>(onLoading);
    on<ThemeChange>((ev, em) => onThemeChange(ev, em, supraState));
    on<ThemeColorChange>((ev, em) => onThemeColorChange(ev, em, supraState));
    on<ListLoadMore>(onListLoadMore);
    on<Busqueda>(onBusqueda);
    on<ApremioField>((ev, em) => onApremioField(ev, em, supraState));
    on<SetApremio>((ev, em) => onSetApremio(ev, em, supraState));
    on<AddToDbApremio>((ev, em) => onAddToDbApremio(ev, em, supraState,add));
    on<UpdateToDbApremio>((ev, em) => onUpdateToDbApremio(ev, em, supraState, add));
  }
  MainState supraState() => state;



  //Load all data from APIs


  //Ui status on BLOC

  onNewMessage(event, emit) {
    emit(state.copyWith(
      message: event.message,
      messageCounter:
          event.typeMessage == TypeMessage.error ? 0 : state.messageCounter + 1,
      errorCounter:
          event.typeMessage == TypeMessage.error ? state.errorCounter + 1 : 0,
      messageColor: event.color,
    ));
  }

  onLoading(Loading event, emit) {
    emit(state.copyWith(
      isLoading: event.isLoading,
    ));
  }

  // onThemeChange(event, emit) {
  //   emit(state.copyWith(
  //     isDark: !state.isDark,
  //   ));
  // }

  // onThemeColorChange(event, emit) {
  //   print(event.color);
  //   emit(state.copyWith(
  //     themeColor: event.color,
  //   ));
  // }

  //------------------Especific Events ------------------

  onListLoadMore(event, emit) {
    emit(state.copyWith());
    //  print('state.plataforma!.view ${state.plataforma!.view}');
    switch (event.table) {
      case 'registros':
        state.registros!.viewRegistros = state.registros!.viewRegistros + 10;
        break;
      case 'solicitados':
        state.registros!.viewSolicitados =
            state.registros!.viewSolicitados + 10;
        break;
      case 'respuestas':
        state.registros!.viewRespuestas = state.registros!.viewRespuestas + 10;
        break;
      case 'replicas':
        state.registros!.viewReplicas = state.registros!.viewReplicas + 10;
        break;
      case 'facturas':
        state.registros!.viewFacturas = state.registros!.viewFacturas + 10;
        break;
      default:
    }
    emit(state.copyWith());
    // print('state.plataforma!.view ${state.plataforma!.view}');
  }

  onBusqueda(Busqueda event, emit){
    switch (event.table) {
      case "Registros":
        state.registros!.buscarRegistros(event.value);
        break;
      case "Solicitados":
        state.registros!.buscarSolicitados(event.value);
        break;
      case "Respuestas":
        state.registros!.buscarRespuestas(event.value);
        break;
      case "Replicas":
        state.registros!.buscarReplicas(event.value);
        break;
      case "Facturas":
        state.registros!.buscarFacturas(event.value);
        break;
      default:
    }
    emit(state.copyWith());
  }

}

//---------------------------busqueda---------------------------------


