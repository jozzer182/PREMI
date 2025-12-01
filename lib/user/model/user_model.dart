// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class User {
  String id;
  String correo;
  String nombre;
  String telefono;
  String perfil;
  List<String> permisos = [];
  User({
    required this.id,
    required this.correo,
    required this.nombre,
    required this.telefono,
    required this.perfil,
  });

  User copyWith({
    String? id,
    String? correo,
    String? nombre,
    String? telefono,
    String? empresa,
    String? pdi,
    String? perfil,
  }) {
    return User(
      id: id ?? this.id,
      correo: correo ?? this.correo,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      perfil: perfil ?? this.perfil,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'correo': correo,
      'nombre': nombre,
      'telefono': telefono,
      'perfil': perfil,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      correo: map['correo'].toString(),
      nombre: map['nombre'].toString(),
      telefono: map['telefono'].toString(),
      perfil: map['perfil'].toString(),
    );
  }

  factory User.fromInit() {
    return User(
      id: '',
      correo: '',
      nombre: '',
      telefono: '',
      perfil: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, correo: $correo, nombre: $nombre, telefono: $telefono, perfil: $perfil, permisos: $permisos)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.correo == correo &&
        other.nombre == nombre &&
        other.telefono == telefono &&
        other.perfil == perfil;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        correo.hashCode ^
        nombre.hashCode ^
        telefono.hashCode ^
        perfil.hashCode;
  }
}
