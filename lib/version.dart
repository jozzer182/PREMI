import 'package:firebase_auth/firebase_auth.dart';

class Version {
  String data = "Versión 2.3 Se agrega campos para soporte de pago";
  String status(String page, String clase) {
    clase = clase.substring(clase.indexOf(":") + 1, clase.length);
    return "Conectado como: ${FirebaseAuth.instance.currentUser?.email ?? "Error"}, Fecha y hora: ${DateTime.now().toString().substring(0, 16)}, Página actual: $page($clase)";
  }

  String user = FirebaseAuth.instance.currentUser?.email ?? "Error";
}

//initialization
Version version = Version();
