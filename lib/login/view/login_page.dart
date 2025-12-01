// ignore_for_file: avoid_print, use_build_context_synchronously

// import 'package:chango/Log/view/register_other_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/transicion_pagina.dart';
import '../../version.dart';
import '../model/login_model.dart';
import 'register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool wasCliked = false;

  @override
  void initState() {
    emailController.text = FirebaseAuth.instance.currentUser?.email ?? '';
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Color primary = Theme.of(context).colorScheme.primary;
    Color tertiary = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: AppBar(
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
            Text(version.data, style: Theme.of(context).textTheme.labelSmall),
            Text(
              version.status('Home', '$runtimeType'),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ],

      body: BlocListener<MainBloc, MainState>(
        listenWhen:
            (previous, current) =>
                previous.errorCounter != current.errorCounter,
        listener: (context, state) {
          print(state.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 8),
              backgroundColor: state.messageColor,
              content: Text(state.message),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //IMAGEN PREMI
              Image.asset('images/rules.png', width: 150),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "",
                      style: TextStyle(
                        color: tertiary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: "PREMI+",
                      style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bienvenido',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Por favor, inicia sesión para continuar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'o registrate si aún no tienes una cuenta, en el botón de abajo',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              // SizedBox(height: 8),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth > 400 ? 400 : screenWidth,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth > 400 ? 400 : screenWidth,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth > 400 ? 400 : screenWidth,
                child: GridView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 5,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  children: [
                    StreamBuilder<User?>(
                      stream: FirebaseAuth.instance.userChanges(),
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed:
                              emailController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty
                                  ? () => login.iniciarSesion(
                                    context: context,
                                    emailController: emailController,
                                    passwordController: passwordController,
                                  )
                                  : null,
                          child: const Text('Iniciar sesión'),
                        );
                      },
                    ),
                    // SizedBox(width: 8),

                    // SizedBox(width: 8),
                    ElevatedButton(
                      onPressed:
                          emailController.text.isNotEmpty &&
                                  emailController.text.contains('@')
                              // &&
                              // emailController.text.contains('@enel.com')
                              ? () => login.olvideContrasena(
                                context: context,
                                emailController: emailController,
                              )
                              : null,
                      child: const Text(
                        'Olvidé mi contraseña',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 40,
                width: 200,
                child: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: () async {
                        // await showDialog(
                        //   context: context,
                        //   builder: (context) => AlertDialog(
                        //     title: const Text('Registro'),
                        //     content: Column(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         ElevatedButton(
                        //           onPressed: () {
                        //             Navigator.push(context,
                        //                 createRoute(RegisterOthers()));
                        //           },
                        //           child: const Text('Empresa Colaboradora'),
                        //         ),
                        //         const SizedBox(height: 8),
                        //         ElevatedButton(
                        //           onPressed: () {
                        Navigator.push(
                          context,
                          createRoute(const RegisterScreen()),
                        );
                        //           },
                        //           child: const Text('Personal ENEL'),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                      child: const Text('Registrarse'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
