// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Coordinador {
  List<CoordinadorSingle> coordinadorList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'coordinadores'},
      'fname': 'getHoja'
    };

    final response = await http.post(
      EnvConfig.apiPremiUri,
      body: jsonEncode(dataSend),
    );
    // print('response ${response.body}');
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 =
          await http.get(Uri.parse(response.headers["location"] ?? ''));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    for (var item in dataAsListMap) {
      coordinadorList.add(CoordinadorSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class CoordinadorSingle {
  String correo;
  CoordinadorSingle({
    required this.correo,
  });

  CoordinadorSingle copyWith({
    String? correo,
  }) {
    return CoordinadorSingle(
      correo: correo ?? this.correo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'correo': correo,
    };
  }

  factory CoordinadorSingle.fromMap(Map<String, dynamic> map) {
    return CoordinadorSingle(
      correo: map['coordinador'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoordinadorSingle.fromJson(String source) =>
      CoordinadorSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SolicitanteSingle(correo: $correo)';

  @override
  bool operator ==(covariant CoordinadorSingle other) {
    if (identical(this, other)) return true;

    return other.correo == correo;
  }

  @override
  int get hashCode => correo.hashCode;
}
