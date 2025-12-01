import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Nt {
  List<NtSingle> ntlist = [];

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DESPLEGABLES', 'hoja': 'nt'},
      'fname': "getHoja"
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
      ntlist.add(NtSingle.fromMap(item));
    }
    return response.statusCode;
  }
}

class NtSingle {
  String niveldetension;
  NtSingle({
    required this.niveldetension,
  });

  NtSingle copyWith({
    String? niveldetension,
  }) {
    return NtSingle(
      niveldetension: niveldetension ?? this.niveldetension,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'niveldetension': niveldetension,
    };
  }

  factory NtSingle.fromMap(Map<String, dynamic> map) {
    return NtSingle(
      niveldetension: map['niveldetension'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NtSingle.fromJson(String source) =>
      NtSingle.fromMap(json.decode(source));

  @override
  String toString() => 'NtSingle(niveldetension: $niveldetension)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NtSingle && other.niveldetension == niveldetension;
  }

  @override
  int get hashCode => niveldetension.hashCode;
}
