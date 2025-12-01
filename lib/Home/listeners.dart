import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_bloc.dart';

class Listeners extends StatelessWidget {
  final Widget child;
  const Listeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listenWhen: (previous, current) =>
          previous.errorCounter != current.errorCounter,
      listener: (context, state) {
        // ignore: avoid_print
        print(state.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 8),
            backgroundColor: state.messageColor,
            content: Text(state.message),
          ),
        );
      },
      child: BlocListener<MainBloc, MainState>(
        listenWhen: (previous, current) =>
            previous.dialogCounter != current.dialogCounter,
        listener: (context, state) {
          // ignore: avoid_print
          print(state.dialogMessage);
          if (state.dialogMessage.isNotEmpty) {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text('Atención'),
                  content: Text(state.dialogMessage),
                  actions: [
                    ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }),
            );
          }
        },
        child: child,
      ),
    );
  }
}