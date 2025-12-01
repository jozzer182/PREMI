import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../user/controller/user_action.dart';
import 'main_bloc.dart';

Future onLoadUserData(Load event, emit, MainState Function() state) async {
  emit(state().copyWith(isLoading: true));
  // print(FirebaseAuth.instance.currentUser?.email);

  if (FirebaseAuth.instance.currentUser?.email != null &&
      state().users != null) {
    await onCreateUser(event, emit, state);
    if (state().user != null) {
      FutureGroup futureGroup = FutureGroup();
      // futureGroup.add(onLoadMm60(event, emit, state));
      // futureGroup.add(onLoadMb52(event, emit, state));
      // futureGroup.add(onLoadMb51(event, emit, state));
      // futureGroup.add(onLoadRegistros(event, emit, state));
      // futureGroup.add(onLoadIngresos(event, emit, state));
      // futureGroup.add(onLoadLcl(event, emit, state));
      // futureGroup.add(onLoadPap(event, emit, state));
      futureGroup.close();
      try {
        // await futureGroup.future
        //     .whenComplete(() => onCalculateData(event, emit, state));
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
  }
  // print('state().users.usersList: ${state().users!.usersList}');
  emit(state().copyWith(isLoading: false));
}
