// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/env_config.dart';
import 'auth_services.dart';

class Login {
  void iniciarSesion({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password:
            passwordController.text.isEmpty
                ? 'notAPassword'
                : passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          context.read<MainBloc>().add(
            NewMessage(
              message:
                  'El correo electrónico, tiene un formato incorrecto, le puede faltar el @ o el .com',
              color: Colors.red,
              typeMessage: TypeMessage.error,
            ),
          );
          break;
        case 'user-not-found':
          context.read<MainBloc>().add(
            NewMessage(
              message: 'Correo no registrado, por favor registrese',
              color: Colors.orange,
              typeMessage: TypeMessage.error,
            ),
          );
          break;
        case 'wrong-password':
          context.read<MainBloc>().add(
            NewMessage(
              message:
                  'La contraseña ingresada es incorrecta, por favor intente nuevamente o de clic en olvidé mi contraseña',
              color: Colors.red,
              typeMessage: TypeMessage.error,
            ),
          );
          break;
        default:
          print(e);
          context.read<MainBloc>().add(
            NewMessage(
              message: e.message ?? 'x',
              color: Colors.red,
              typeMessage: TypeMessage.error,
            ),
          );
      }
    } catch (e) {
      print(e);
      context.read<MainBloc>().add(
        NewMessage(
          message: e.toString(),
          color: Colors.red,
          typeMessage: TypeMessage.error,
        ),
      );
    }
    if (!(FirebaseAuth.instance.currentUser?.emailVerified ?? false)) {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Correo no verificado, revise su bandeja de entrada y verifique su correo.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      BlocProvider.of<MainBloc>(context).add(Load());
    }
  }

  void olvideContrasena({
    required BuildContext context,
    required TextEditingController emailController,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      context.read<MainBloc>().add(
        NewMessage(
          message:
              'Se ha enviado un correo electrónico para reestablecer su contraseña.',
          color: Colors.green,
          typeMessage: TypeMessage.message,
        ),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          context.read<MainBloc>().add(
            NewMessage(
              message:
                  'El correo electrónico no se encuentra registrado, de clic en iniciar sesión.',
              color: Colors.orange,
              typeMessage: TypeMessage.error,
            ),
          );
          break;
        case 'invalid-email':
          context.read<MainBloc>().add(
            NewMessage(
              message:
                  'El correo electrónico, tiene un formato incorrecto, le puede faltar el @ o el .com',
              color: Colors.red,
              typeMessage: TypeMessage.error,
            ),
          );
          break;
        default:
          context.read<MainBloc>().add(
            NewMessage(
              message: e.toString(),
              color: Colors.red,
              typeMessage: TypeMessage.error,
            ),
          );
      }
    }
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      await FirebaseAuth.instance.signOut();
    } catch (es) {
      print(es);
    }
  }

  registrarse({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
    required TextEditingController telController,
    required String? selectedItemPerfil,
    // required Function setState,
  }) async {
    // ignore: unused_local_variable
    String? errorMail;
    // setState(() {
    //   loading = true;
    // });
    BlocProvider.of<MainBloc>(context).add(Loading(isLoading: true));
    bool noEsValido =
        !(emailController.text.contains('@enel') ||
            emailController.text.contains('@ocaglobal.com'));
    if (emailController.text == "" ||
        passwordController.text == "" ||
        nameController.text == "" ||
        telController.text == "") {
      errorMail = 'Se requieren los datos completos';
      // Get.snackbar('Atención', 'Se requieren los datos completos');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor revise los campos, se requieren todos diligenciados',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (noEsValido) {
      errorMail =
          'Este registro es válido solo para usuarios con correo @enel.com';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Este registro es válido solo para usuarios con correo @enel.com',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      User? result = await authService.register(
        email: emailController.text,
        password: passwordController.text,
        nombre: nameController.text,
        telefono: telController.text,
        empresa: 'Enel',
        perfil: selectedItemPerfil ?? '',
        context: context,
      );
      if (result != null) {
        // print('Succes for email ${result.email}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Se registro correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        await result.updateDisplayName(nameController.text);
        await FirebaseAuth.instance.currentUser!
            .sendEmailVerification()
            .onError(
              // ignore: void_checks
              (error, stackTrace) {
                return ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('error'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            )
            .whenComplete(
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Se ha enviado el correo correctamente, por favor revise en su bandeja de SPAM',
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            );
        var dataSend = {
          'info': {
            "libro": "USUARIOS",
            "hoja": "hoja",
            'map': {
              'nombre': nameController.text,
              'correo': emailController.text,
              'perfil': 'funcional',
              'telefono': telController.text,
            },
          },
          'fname': 'addMap',
        };
        final response = await post(
          EnvConfig.apiLoginUri,
          body: jsonEncode(dataSend),
        );
        // print('response ${response.body}');
        // ignore: prefer_typing_uninitialized_variables
        var dataAsListMap;
        if (response.statusCode == 302) {
          var response2 = await get(
            Uri.parse(response.headers["location"] ?? ''),
          );
          dataAsListMap = jsonDecode(response2.body);
        } else {
          dataAsListMap = jsonDecode(response.body);
        }
        print(dataAsListMap);

        Navigator.pop(context);
      }
    }
    BlocProvider.of<MainBloc>(context).add(Loading(isLoading: false));
  }
}

Login login = Login();
