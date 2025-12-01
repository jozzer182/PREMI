// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Medio {
  List<MedioSingle> medioList = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'medio'},
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
      medioList.add(MedioSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class MedioSingle {
  String tipo;
  MedioSingle({
    required this.tipo,
  });

  MedioSingle copyWith({
    String? tipo,
  }) {
    return MedioSingle(
      tipo: tipo ?? this.tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tipo': tipo,
    };
  }

  factory MedioSingle.fromMap(Map<String, dynamic> map) {
    return MedioSingle(
      tipo: map['tipo'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MedioSingle.fromJson(String source) =>
      MedioSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MedioSingle(tipo: $tipo)';

  @override
  bool operator ==(covariant MedioSingle other) {
    if (identical(this, other)) return true;

    return other.tipo == tipo;
  }

  @override
  int get hashCode => tipo.hashCode;
}
