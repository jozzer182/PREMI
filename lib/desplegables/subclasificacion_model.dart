// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart';
import '../resources/env_config.dart';



class Subclasificacion{
  List<SubclasificacionSingle> subclasificacionList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'subclasificacion'},
      'fname': 'getHoja'
    };

    final response = await post(
      EnvConfig.apiPremiUri,
      body: jsonEncode(dataSend),
    );
    // print('response ${response.body}');
    var dataAsListMap;
    if (response.statusCode == 302) {
      var response2 =
          await get(Uri.parse(response.headers["location"] ?? ''));
      dataAsListMap = jsonDecode(response2.body);
    } else {
      dataAsListMap = jsonDecode(response.body);
    }
    for (var item in dataAsListMap) {
      subclasificacionList.add(SubclasificacionSingle.fromMap(item));
    }
    return response.statusCode;
  }

}

class SubclasificacionSingle {
  String tipo;
  SubclasificacionSingle({
    required this.tipo,
  });

  SubclasificacionSingle copyWith({
    String? tipo,
  }) {
    return SubclasificacionSingle(
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
    };
  }

  factory SubclasificacionSingle.fromMap(Map<String, dynamic> map) {
    return SubclasificacionSingle(
      tipo: map['tipo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubclasificacionSingle.fromJson(String source) => SubclasificacionSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubclasificacionSingle(tipo: $tipo)';

  @override
  bool operator ==(covariant SubclasificacionSingle other) {
    if (identical(this, other)) return true;
  
    return 
      other.tipo == tipo;
  }

  @override
  int get hashCode => tipo.hashCode;
}
