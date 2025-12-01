import 'package:firebase_auth/firebase_auth.dart' hide User;

import '../../bloc/main_bloc.dart';
import '../../users/model/perfiles_model.dart';
import '../model/user_model.dart';

onCreateUser(event, emit, MainState Function() state) async {
  try {
    User user = state().users!.usersList.firstWhere(
        (e) => e.correo == FirebaseAuth.instance.currentUser!.email,
        orElse: User.fromInit);
    List<PerfilesSingle> perfiles = state().perfiles!.perfilesList;
    user.permisos = perfiles
        .where((e) => e.perfil.toLowerCase() == user.perfil.toLowerCase())
        .map((e) => e.permiso.toLowerCase())
        .toList();
    // print('user: $user');
    emit(state().copyWith(user: user));
    // print('user from state: ${state().user}');
    await Future.delayed(const Duration(milliseconds: 50));
  } catch (e) {
    emit(state().copyWith(
      errorCounter: state().errorCounter + 1,
      message:
          '🤕Error llamando📞 los datos usuario ⚠️$e => ${e.runtimeType}, intente recargar la página🔄, total errores: ${state().errorCounter + 1}',
    ));
  }
}