// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Clasificacion {
  List<ClasificacionSingle> clasificacionList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'clasificacion'},
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
      clasificacionList.add(ClasificacionSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class ClasificacionSingle {
  String tipo;
  ClasificacionSingle({
    required this.tipo,
  });

  ClasificacionSingle copyWith({
    String? tipo,
  }) {
    return ClasificacionSingle(
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
    };
  }

  factory ClasificacionSingle.fromMap(Map<String, dynamic> map) {
    return ClasificacionSingle(
      tipo: map['tipo'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClasificacionSingle.fromJson(String source) =>
      ClasificacionSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClasificacionSingle(tipo: $tipo)';

  @override
  bool operator ==(covariant ClasificacionSingle other) {
    if (identical(this, other)) return true;

    return other.tipo == tipo;
  }

  @override
  int get hashCode => tipo.hashCode;
}
