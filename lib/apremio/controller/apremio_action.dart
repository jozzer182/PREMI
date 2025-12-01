
import 'package:flutter/widgets.dart';

import '../../bloc/main_bloc.dart';


onSetApremio(
  SetApremio event,
  emit,
  MainState Function() state,
) {
  state().apremio = event.apremio;
  emit(state().copyWith());
}

onApremioField(
  ApremioField event,
  emit,
  MainState Function() state,
) {
  state().apremio?.asignar(
        campo: event.campo,
        valor: event.valor,
      );
  emit(state().copyWith());
}

Future onAddToDbApremio(
  AddToDbApremio event,
  emit,
  MainState Function() state,
  add,
) async {
  emit(state().copyWith(isLoading: true));

  if (state().apremio?.validar != null) {
    emit(state().copyWith(
      dialogCounter: state().dialogCounter + 1,
      dialogMessage: state().apremio?.validar?.join('\n'),
    ));
  } else {
    // ignore: unused_local_variable
    String? respuesta;
    try {
      respuesta = await state().apremio?.addToDb(user: state().user!);
      Navigator.pop(event.context);
      add(Load());
    } catch (e) {
      emit(state().copyWith(
        errorCounter: state().errorCounter + 1,
        message:
            '🤕Error enviando los datos del Apremio: ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
      ));
    }
    emit(state().copyWith(
      dialogCounter: state().dialogCounter + 1,
      dialogMessage: respuesta ?? 'Error en el envío',
    ));
  }

  emit(state().copyWith(isLoading: false));

}


Future onUpdateToDbApremio(
  UpdateToDbApremio event,
  emit,
  MainState Function() state,
  add,
) async {
  emit(state().copyWith(isLoading: true));

  if (state().apremio?.validar != null) {
    emit(state().copyWith(
      dialogCounter: state().dialogCounter + 1,
      dialogMessage: state().apremio?.validar?.join('\n'),
    ));
  } else {
    // ignore: unused_local_variable
    String? respuesta;
    try {
      respuesta = await state().apremio?.updateToDb(user: state().user!);
      Navigator.pop(event.context);
      add(Load());
    } catch (e) {
      emit(state().copyWith(
        errorCounter: state().errorCounter + 1,
        message:
            '🤕Error enviando los datos del Apremio: ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
      ));
    }
    emit(state().copyWith(
      dialogCounter: state().dialogCounter + 1,
      dialogMessage: respuesta ?? 'Error en el envío',
    ));
  }

  emit(state().copyWith(isLoading: false));

}



