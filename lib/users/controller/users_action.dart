import '../../bloc/main_bloc.dart';
import '../model/perfiles_model.dart';
import '../model/users_model.dart';

Future onLoadUsers(event, emit, MainState Function() state) async {
  Users users = Users();
  try {
    // print('onLoadLm');
    await users.obtener();
    emit(state().copyWith(users: users));
    // print('users: ${state().users?.usersList}');
  } catch (e) {
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 la tabla de Usuarios ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}

Future onLoadPerfiles(event, emit, MainState Function() supraState) async {
  Perfiles perfiles = Perfiles();
  try {
    await perfiles.obtener();
    emit(supraState().copyWith(perfiles: perfiles));
    // print('perfiles: ${supraState().perfiles?.perfilesList.length ?? ''}');
  } catch (e) {
    // print(e);
    emit(supraState().copyWith(
      errorCounter: supraState().errorCounter + 1,
      message:
          '🤕Error llamando📞 la lista de perfiles ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${supraState().errorCounter + 1}',
    ));
  }
}