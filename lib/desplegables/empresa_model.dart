// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Empresa {
  List<EmpresaSingle> empresaList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'empresa'},
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
      empresaList.add(EmpresaSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class EmpresaSingle {
  String tipo;
  String contrato;
  EmpresaSingle({
    required this.tipo,
    required this.contrato,
  });

  EmpresaSingle copyWith({
    String? tipo,
    String? contrato,
  }) {
    return EmpresaSingle(
      tipo: tipo ?? this.tipo,
      contrato: contrato ?? this.contrato,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
      'contrato': contrato,
    };
  }

  factory EmpresaSingle.fromMap(Map<String, dynamic> map) {
    return EmpresaSingle(
      tipo: map['empresa'].toString(),
      contrato: map['contrato'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EmpresaSingle.fromJson(String source) => EmpresaSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EmpresaSingle(tipo: $tipo, contrato: $contrato)';

  @override
  bool operator ==(covariant EmpresaSingle other) {
    if (identical(this, other)) return true;
  
    return 
      other.tipo == tipo &&
      other.contrato == contrato;
  }

  @override
  int get hashCode => tipo.hashCode ^ contrato.hashCode;
}
