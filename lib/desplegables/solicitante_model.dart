// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Solicitante {
  List<SolicitanteSingle> solicitanteList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'solicitante'},
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
      solicitanteList.add(SolicitanteSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class SolicitanteSingle {
  String correo;
  SolicitanteSingle({
    required this.correo,
  });

  SolicitanteSingle copyWith({
    String? correo,
  }) {
    return SolicitanteSingle(
      correo: correo ?? this.correo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'correo': correo,
    };
  }

  factory SolicitanteSingle.fromMap(Map<String, dynamic> map) {
    return SolicitanteSingle(
      correo: map['solicitante'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SolicitanteSingle.fromJson(String source) =>
      SolicitanteSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SolicitanteSingle(correo: $correo)';

  @override
  bool operator ==(covariant SolicitanteSingle other) {
    if (identical(this, other)) return true;

    return other.correo == correo;
  }

  @override
  int get hashCode => correo.hashCode;
}
