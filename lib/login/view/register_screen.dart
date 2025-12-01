


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/main_bloc.dart';
import '../model/auth_services.dart';
import '../model/login_model.dart';

// import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telController = TextEditingController();
  String? selectedItemPerfil = 'funcional';

  AuthService authService = AuthService();
  bool loading = false;
  String? errorMail;
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Enel'),
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: columnData(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> columnData() {
    return [
      const Text(
        'Favor indique su correo corporativo "@enel.com" y una contraseña para acceder al aplicativo, no se sincronizará con la contraseña de red.',
        maxLines: 5,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30.0),
      TextField(
        controller: nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'Nombre - Apellido',
          border: OutlineInputBorder(),
          errorMaxLines: 2,
        ),
      ),
      const SizedBox(height: 30.0),
      TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: telController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone),
          labelText: 'Telefono',
          border: OutlineInputBorder(),
          errorMaxLines: 2,
        ),
      ),
      const SizedBox(height: 30.0),
      TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          labelText: 'Correo',
          border: const OutlineInputBorder(),
          errorText: authService.errorCall ?? errorMail,
          errorMaxLines: 2,
        ),
      ),
      // const SizedBox(height: 30.0),
      // DropdownButtonFormField(
      //   decoration: const InputDecoration(
      //     prefixIcon: Icon(Icons.lock_person),
      //     labelText: 'Perfil',
      //     border: OutlineInputBorder(),
      //     errorMaxLines: 2,
      //   ),
      //   items: const [
      //     DropdownMenuItem(
      //       value: 'funcional',
      //       child: Text('Funcional'),
      //     ),
      //     DropdownMenuItem(
      //       value: 'contract',
      //       child: Text('Contract Management'),
      //     ),
      //   ],
      //   value: selectedItemPerfil,
      //   onChanged: (String? value) {
      //     setState(() {
      //       selectedItemPerfil = value;
      //     });
      //   },
      // ),
      const SizedBox(height: 30.0),
      TextField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        controller: passwordController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: 'Contraseña',
          border: OutlineInputBorder(),
        ),
      ),
      const SizedBox(height: 30.0),
      Builder(
        builder: (context) {
          if (loading) {
            return const CircularProgressIndicator();
          } else {
            return ElevatedButton(
              child: const Text('Registrarse'),
              onPressed: () async {
                login.registrarse(
                  context: context,
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: nameController,
                  telController: telController,
                  selectedItemPerfil: selectedItemPerfil,
                );
              },
            );
          }
        },
      ),
    ];
  }
}
