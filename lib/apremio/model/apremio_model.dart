// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:premi_1/Todos/todos_model.dart';
import 'package:premi_1/resources/url_premi.dart';
import 'package:premi_1/user/model/user_model.dart';

import 'apremio_enum.dart';

class Apremio {
  String id;
  String empresa;
  String contrato;
  String solicitante;
  String nt;
  String coordinadorpmc;
  String clasificacion;
  String i;
  String ii;
  String iii;
  String cantidadincumplimientos;
  String valor;
  String medio;
  String inspeccion;
  String numinspeccion;
  String titulo;
  String proyecto;
  String descripcion;
  String observaciongeneral;
  String usuario;
  String fechareg;
  String solestado;
  String solfecha;
  String solradicado;
  String soldestinatario;
  String solobservacion;
  String soladjunto;
  String solusuario;
  String solfechareg;
  String resestado;
  String resfecha;
  String resradicado;
  String resobservacion;
  String resadjunto;
  String resusuario;
  String resfechareg;
  String repestado;
  String repfecha;
  String repradicado;
  String repobservacion;
  String repadjunto;
  String repusuario;
  String repfechareg;
  String facestado;
  String facfecha;
  String facfactura;
  String facvalor;
  String facobservacion;
  String facadjunto;
  String facusuario;
  String facfechareg;
  String soportepago;
  String soportepagoadjunto;
  String estado;
  String estadousuario;
  String estadofecha;
  String subclasificacion;
  Apremio({
    required this.id,
    required this.empresa,
    required this.contrato,
    required this.solicitante,
    required this.nt,
    required this.coordinadorpmc,
    required this.clasificacion,
    required this.i,
    required this.ii,
    required this.iii,
    required this.cantidadincumplimientos,
    required this.valor,
    required this.medio,
    required this.inspeccion,
    required this.numinspeccion,
    required this.titulo,
    required this.proyecto,
    required this.descripcion,
    required this.observaciongeneral,
    required this.usuario,
    required this.fechareg,
    required this.solestado,
    required this.solfecha,
    required this.solradicado,
    required this.soldestinatario,
    required this.solobservacion,
    required this.soladjunto,
    required this.solusuario,
    required this.solfechareg,
    required this.resestado,
    required this.resfecha,
    required this.resradicado,
    required this.resobservacion,
    required this.resadjunto,
    required this.resusuario,
    required this.resfechareg,
    required this.repestado,
    required this.repfecha,
    required this.repradicado,
    required this.repobservacion,
    required this.repadjunto,
    required this.repusuario,
    required this.repfechareg,
    required this.facestado,
    required this.facfecha,
    required this.facfactura,
    required this.facvalor,
    required this.facobservacion,
    required this.facadjunto,
    required this.facusuario,
    required this.facfechareg,
    required this.soportepago,
    required this.soportepagoadjunto,
    required this.estado,
    required this.estadousuario,
    required this.estadofecha,
    required this.subclasificacion,
  });

  get empresaColor {
    if (empresa.isEmpty) return Colors.red;
    return Colors.grey;
  }

  Future<String?> addToDb({
    required User user,
  }) async {
    estadousuario = user.correo;
    estadofecha = DateTime.now().toString().substring(0, 10);
    Map dataSend = {
      "info": {
        "libro": "DB",
        "hoja": "reg",
        "data": [toMap()],
      },
      "fname": "add",
    };
    // print(jsonEncode(dataSend));
    Response response = await post(
      urlPremi,
      body: jsonEncode(dataSend),
    );
    var respuesta = jsonDecode(response.body) ?? 'error en el envio';
    return respuesta;
  }

  Future<String?> updateToDb({
    required User user,
  }) async {
    estadousuario = user.correo;
    estadofecha = DateTime.now().toString().substring(0, 10);
    Map dataSend = {
      "info": {
        "libro": "DB",
        "hoja": "reg",
        "data": [toMap()],
      },
      "fname": "update",
    };
    // print(jsonEncode(dataSend));
    Response response = await post(
      urlPremi,
      body: jsonEncode(dataSend),
    );
    var respuesta = jsonDecode(response.body) ?? 'error en el envio';
    return respuesta;
  }

  List? get validar {
    var faltantes = [];
    // Color color = Colors.red;
    if (empresa.isEmpty) faltantes.add('Empresa');
    if (contrato.isEmpty) faltantes.add('Contrato');
    if (solicitante.isEmpty) faltantes.add('Solicitante');
    if (coordinadorpmc.isEmpty) faltantes.add('Coordinador SCS');
    if (clasificacion.isEmpty) faltantes.add('Clasificacion');
    if (subclasificacion.isEmpty) faltantes.add('Subclasificacion');
    if (valor.isEmpty) faltantes.add('Valor Total');
    if (descripcion.isEmpty) faltantes.add('Descripcion');
    if (solradicado.isEmpty) faltantes.add('Solicitado - Radicado');
    if (solfecha.isEmpty) faltantes.add('Solicitado - Fecha');
    if (soldestinatario.isEmpty) faltantes.add('Solicitado - Destinatario');
    if (resradicado.isEmpty && resfecha.isNotEmpty) faltantes.add('Respuesta - Radicado');
    if (resfecha.isEmpty && resradicado.isNotEmpty) faltantes.add('Respuesta - Fecha');
    if (repradicado.isEmpty && repfecha.isNotEmpty) faltantes.add('Replica - Radicado');
    if (repfecha.isEmpty && repradicado.isNotEmpty) faltantes.add('Replica - Fecha');
    if (facfactura.isEmpty && (facfecha.isNotEmpty || facvalor.isNotEmpty)) faltantes.add('Facturado - Factura');
    if (facfecha.isEmpty && (facfactura.isNotEmpty || facvalor.isNotEmpty)) faltantes.add('Facturado - Fecha');
    if (facvalor.isEmpty && (facfactura.isNotEmpty || facfecha.isNotEmpty)) faltantes.add('Facturado - Valor');
    // if (soportepagoadjunto.isNotEmpty && soportepago.isEmpty) faltantes.add('Soporte de Pago');
    // if (soportepago.isNotEmpty && soportepagoadjunto.isEmpty) faltantes.add('Soporte de Pago - Adjunto');
    //agregar mas cmapos a comprobar
    if (faltantes.isNotEmpty) {
      faltantes.insert(0,
          'Por favor revise los siguientes campos para poder realizar el guardado:');
      return faltantes;
    } else {
      return null;
    }
  }

  void asignar({
    required Campo campo,
    required String valor,
  }) {
    if (campo == Campo.id) {
      id = valor;
    }
    if (campo == Campo.empresa) {
      empresa = valor;
    }
    if (campo == Campo.contrato) {
      contrato = valor;
    }
    if (campo == Campo.solicitante) {
      solicitante = valor;
    }
    if (campo == Campo.nt) {
      nt = valor;
    }
    if (campo == Campo.coordinadorpmc) {
      coordinadorpmc = valor;
    }
    if (campo == Campo.clasificacion) {
      clasificacion = valor;
    }
    if (campo == Campo.i) {
      i = valor;
    }
    if (campo == Campo.ii) {
      ii = valor;
    }
    if (campo == Campo.iii) {
      iii = valor;
    }
    if (campo == Campo.cantidadincumplimientos) {
      cantidadincumplimientos = valor;
    }
    if (campo == Campo.valor) {
      this.valor = valor;
    }
    if (campo == Campo.medio) {
      medio = valor;
    }
    if (campo == Campo.inspeccion) {
      inspeccion = valor;
    }
    if (campo == Campo.numinspeccion) {
      numinspeccion = valor;
    }
    if (campo == Campo.titulo) {
      titulo = valor;
    }
    if (campo == Campo.proyecto) {
      proyecto = valor;
    }
    if (campo == Campo.descripcion) {
      descripcion = valor;
    }
    if (campo == Campo.observaciongeneral) {
      observaciongeneral = valor;
    }
    if (campo == Campo.usuario) {
      usuario = valor;
    }
    if (campo == Campo.fechareg) {
      fechareg = valor;
    }
    if (campo == Campo.solestado) {
      solestado = valor;
    }
    if (campo == Campo.solfecha) {
      solfecha = valor;
    }
    if (campo == Campo.solradicado) {
      solradicado = valor;
    }
    if (campo == Campo.soldestinatario) {
      soldestinatario = valor;
    }
    if (campo == Campo.solobservacion) {
      solobservacion = valor;
    }
    if (campo == Campo.soladjunto) {
      soladjunto = valor;
    }
    if (campo == Campo.solusuario) {
      solusuario = valor;
    }
    if (campo == Campo.solfechareg) {
      solfechareg = valor;
    }
    if (campo == Campo.resestado) {
      resestado = valor;
    }
    if (campo == Campo.resfecha) {
      resfecha = valor;
    }
    if (campo == Campo.resradicado) {
      resradicado = valor;
    }
    if (campo == Campo.resobservacion) {
      resobservacion = valor;
    }
    if (campo == Campo.resadjunto) {
      resadjunto = valor;
    }
    if (campo == Campo.resusuario) {
      resusuario = valor;
    }
    if (campo == Campo.resfechareg) {
      resfechareg = valor;
    }
    if (campo == Campo.repestado) {
      repestado = valor;
    }
    if (campo == Campo.repfecha) {
      repfecha = valor;
    }
    if (campo == Campo.repradicado) {
      repradicado = valor;
    }
    if (campo == Campo.repobservacion) {
      repobservacion = valor;
    }
    if (campo == Campo.repadjunto) {
      repadjunto = valor;
    }
    if (campo == Campo.repusuario) {
      repusuario = valor;
    }
    if (campo == Campo.repfechareg) {
      repfechareg = valor;
    }
    if (campo == Campo.facestado) {
      facestado = valor;
    }
    if (campo == Campo.facfecha) {
      facfecha = valor;
    }
    if (campo == Campo.facfactura) {
      facfactura = valor;
    }
    if (campo == Campo.facvalor) {
      facvalor = valor;
    }
    if (campo == Campo.facobservacion) {
      facobservacion = valor;
    }
    if (campo == Campo.facadjunto) {
      facadjunto = valor;
    }
    if (campo == Campo.facusuario) {
      facusuario = valor;
    }
    if (campo == Campo.facfechareg) {
      facfechareg = valor;
    }
    if (campo == Campo.soportepago) {
      soportepago = valor;
    }
    if (campo == Campo.soportepagoadjunto) {
      soportepagoadjunto = valor;
    }
    if (campo == Campo.estado) {
      estado = valor;
    }
    if (campo == Campo.estadousuario) {
      estadousuario = valor;
    }
    if (campo == Campo.estadofecha) {
      estadofecha = valor;
    }
    if (campo == Campo.subclasificacion) {
      subclasificacion = valor;
    }
  }

  Apremio copyWith({
    String? id,
    String? empresa,
    String? contrato,
    String? solicitante,
    String? nt,
    String? coordinadorpmc,
    String? clasificacion,
    String? i,
    String? ii,
    String? iii,
    String? cantidadincumplimientos,
    String? valor,
    String? medio,
    String? inspeccion,
    String? numinspeccion,
    String? titulo,
    String? proyecto,
    String? descripcion,
    String? observaciongeneral,
    String? usuario,
    String? fechareg,
    String? solestado,
    String? solfecha,
    String? solradicado,
    String? soldestinatario,
    String? solobservacion,
    String? soladjunto,
    String? solusuario,
    String? solfechareg,
    String? resestado,
    String? resfecha,
    String? resradicado,
    String? resobservacion,
    String? resadjunto,
    String? resusuario,
    String? resfechareg,
    String? repestado,
    String? repfecha,
    String? repradicado,
    String? repobservacion,
    String? repadjunto,
    String? repusuario,
    String? repfechareg,
    String? facestado,
    String? facfecha,
    String? facfactura,
    String? facvalor,
    String? facobservacion,
    String? facadjunto,
    String? facusuario,
    String? facfechareg,
    String? soportepago,
    String? soportepagoadjunto,
    String? estado,
    String? estadousuario,
    String? estadofecha,
    String? subclasificacion,
  }) {
    return Apremio(
      id: id ?? this.id,
      empresa: empresa ?? this.empresa,
      contrato: contrato ?? this.contrato,
      solicitante: solicitante ?? this.solicitante,
      nt: nt ?? this.nt,
      coordinadorpmc: coordinadorpmc ?? this.coordinadorpmc,
      clasificacion: clasificacion ?? this.clasificacion,
      i: i ?? this.i,
      ii: ii ?? this.ii,
      iii: iii ?? this.iii,
      cantidadincumplimientos:
          cantidadincumplimientos ?? this.cantidadincumplimientos,
      valor: valor ?? this.valor,
      medio: medio ?? this.medio,
      inspeccion: inspeccion ?? this.inspeccion,
      numinspeccion: numinspeccion ?? this.numinspeccion,
      titulo: titulo ?? this.titulo,
      proyecto: proyecto ?? this.proyecto,
      descripcion: descripcion ?? this.descripcion,
      observaciongeneral: observaciongeneral ?? this.observaciongeneral,
      usuario: usuario ?? this.usuario,
      fechareg: fechareg ?? this.fechareg,
      solestado: solestado ?? this.solestado,
      solfecha: solfecha ?? this.solfecha,
      solradicado: solradicado ?? this.solradicado,
      soldestinatario: soldestinatario ?? this.soldestinatario,
      solobservacion: solobservacion ?? this.solobservacion,
      soladjunto: soladjunto ?? this.soladjunto,
      solusuario: solusuario ?? this.solusuario,
      solfechareg: solfechareg ?? this.solfechareg,
      resestado: resestado ?? this.resestado,
      resfecha: resfecha ?? this.resfecha,
      resradicado: resradicado ?? this.resradicado,
      resobservacion: resobservacion ?? this.resobservacion,
      resadjunto: resadjunto ?? this.resadjunto,
      resusuario: resusuario ?? this.resusuario,
      resfechareg: resfechareg ?? this.resfechareg,
      repestado: repestado ?? this.repestado,
      repfecha: repfecha ?? this.repfecha,
      repradicado: repradicado ?? this.repradicado,
      repobservacion: repobservacion ?? this.repobservacion,
      repadjunto: repadjunto ?? this.repadjunto,
      repusuario: repusuario ?? this.repusuario,
      repfechareg: repfechareg ?? this.repfechareg,
      facestado: facestado ?? this.facestado,
      facfecha: facfecha ?? this.facfecha,
      facfactura: facfactura ?? this.facfactura,
      facvalor: facvalor ?? this.facvalor,
      facobservacion: facobservacion ?? this.facobservacion,
      facadjunto: facadjunto ?? this.facadjunto,
      facusuario: facusuario ?? this.facusuario,
      facfechareg: facfechareg ?? this.facfechareg,
      soportepago: soportepago ?? this.soportepago,
      soportepagoadjunto: soportepagoadjunto ?? this.soportepagoadjunto,
      estado: estado ?? this.estado,
      estadousuario: estadousuario ?? this.estadousuario,
      estadofecha: estadofecha ?? this.estadofecha,
      subclasificacion: subclasificacion ?? this.subclasificacion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'empresa': empresa,
      'contrato': contrato,
      'solicitante': solicitante,
      'nt': nt,
      'coordinadorpmc': coordinadorpmc,
      'clasificacion': clasificacion,
      'i': i,
      'ii': ii,
      'iii': iii,
      'cantidadincumplimientos': cantidadincumplimientos,
      'valor': valor,
      'medio': medio,
      'inspeccion': inspeccion,
      'numinspeccion': numinspeccion,
      'titulo': titulo,
      'proyecto': proyecto,
      'descripcion': descripcion,
      'observaciongeneral': observaciongeneral,
      'usuario': usuario,
      'fechareg': fechareg,
      'solestado': solestado,
      'solfecha': solfecha,
      'solradicado': solradicado,
      'soldestinatario': soldestinatario,
      'solobservacion': solobservacion,
      'soladjunto': soladjunto,
      'solusuario': solusuario,
      'solfechareg': solfechareg,
      'resestado': resestado,
      'resfecha': resfecha,
      'resradicado': resradicado,
      'resobservacion': resobservacion,
      'resadjunto': resadjunto,
      'resusuario': resusuario,
      'resfechareg': resfechareg,
      'repestado': repestado,
      'repfecha': repfecha,
      'repradicado': repradicado,
      'repobservacion': repobservacion,
      'repadjunto': repadjunto,
      'repusuario': repusuario,
      'repfechareg': repfechareg,
      'facestado': facestado,
      'facfecha': facfecha,
      'facfactura': facfactura,
      'facvalor': facvalor,
      'facobservacion': facobservacion,
      'facadjunto': facadjunto,
      'facusuario': facusuario,
      'facfechareg': facfechareg,
      'soportepago': soportepago,
      'soportepagoadjunto': soportepagoadjunto,
      'estado': estado,
      'estadousuario': estadousuario,
      'estadofecha': estadofecha,
      'subclasificacion': subclasificacion,
    };
  }

  factory Apremio.fromMap(Map<String, dynamic> map) {
    return Apremio(
      id: map['id'].toString(),
      empresa: map['empresa'].toString(),
      contrato: map['contrato'].toString(),
      solicitante: map['solicitante'].toString(),
      nt: map['nt'].toString(),
      coordinadorpmc: map['coordinadorpmc'].toString(),
      clasificacion: map['clasificacion'].toString(),
      i: map['i'].toString(),
      ii: map['ii'].toString(),
      iii: map['iii'].toString(),
      cantidadincumplimientos: map['cantidadincumplimientos'].toString(),
      valor: map['valor'].toString(),
      medio: map['medio'].toString(),
      inspeccion: map['inspeccion'].toString(),
      numinspeccion: map['numinspeccion'].toString(),
      titulo: map['titulo'].toString(),
      proyecto: map['proyecto'].toString(),
      descripcion: map['descripcion'].toString(),
      observaciongeneral: map['observaciongeneral'].toString(),
      usuario: map['usuario'].toString(),
      fechareg: map['fechareg'].toString().isNotEmpty
          ? map['fechareg'].toString().substring(0, 10)
          : '',
      solestado: map['solestado'].toString(),
      solfecha: map['solfecha'].toString().isNotEmpty
          ? map['solfecha'].toString().substring(0, 10)
          : '',
      solradicado: map['solradicado'].toString(),
      soldestinatario: map['soldestinatario'].toString(),
      solobservacion: map['solobservacion'].toString(),
      soladjunto: map['soladjunto'].toString(),
      solusuario: map['solusuario'].toString(),
      solfechareg: map['solfechareg'].toString().isNotEmpty
          ? map['solfechareg'].toString().substring(0, 10)
          : '',
      resestado: map['resestado'].toString(),
      resfecha: map['resfecha'].toString().isNotEmpty
          ? map['resfecha'].toString().substring(0, 10)
          : '',
      resradicado: map['resradicado'].toString(),
      resobservacion: map['resobservacion'].toString(),
      resadjunto: map['resadjunto'].toString(),
      resusuario: map['resusuario'].toString(),
      resfechareg: map['resfechareg'].toString().isNotEmpty
          ? map['resfechareg'].toString().substring(0, 10)
          : '',
      repestado: map['repestado'].toString(),
      repfecha: map['repfecha'].toString().isNotEmpty
          ? map['repfecha'].toString().substring(0, 10)
          : '',
      repradicado: map['repradicado'].toString(),
      repobservacion: map['repobservacion'].toString(),
      repadjunto: map['repadjunto'].toString(),
      repusuario: map['repusuario'].toString(),
      repfechareg: map['repfechareg'].toString().isNotEmpty
          ? map['repfechareg'].toString().substring(0, 10)
          : '',
      facestado: map['facestado'].toString(),
      facfecha: map['facfecha'].toString().isNotEmpty
          ? map['facfecha'].toString().substring(0, 10)
          : '',
      facfactura: map['facfactura'].toString(),
      facvalor: map['facvalor'].toString().replaceAll(',', ''),
      facobservacion: map['facobservacion'].toString(),
      facadjunto: map['facadjunto'].toString(),
      facusuario: map['facusuario'].toString(),
      facfechareg: map['facfechareg'].toString().isNotEmpty
          ? map['facfechareg'].toString().substring(0, 10)
          : '',
      soportepago: map['soportepago'].toString(),
      soportepagoadjunto: map['soportepagoadjunto'].toString(),
      estado: map['estado'].toString(),
      estadousuario: map['estadousuario'].toString(),
      estadofecha: map['estadofecha'].toString().isNotEmpty
          ? map['estadofecha'].toString().substring(0, 10)
          : '',
      subclasificacion: map['subclasificacion'].toString(),
    );
  }
  factory Apremio.fromInit() {
    return Apremio(
      id: '',
      empresa: '',
      contrato: '',
      solicitante: '',
      nt: '',
      coordinadorpmc: '',
      clasificacion: '',
      i: '',
      ii: '',
      iii: '',
      cantidadincumplimientos: '',
      valor: '',
      medio: '',
      inspeccion: '',
      numinspeccion: '',
      titulo: '',
      proyecto: '',
      descripcion: '',
      observaciongeneral: '',
      usuario: '',
      fechareg: '',
      solestado: '',
      solfecha: '',
      solradicado: '',
      soldestinatario: '',
      solobservacion: '',
      soladjunto: '',
      solusuario: '',
      solfechareg: '',
      resestado: '',
      resfecha: '',
      resradicado: '',
      resobservacion: '',
      resadjunto: '',
      resusuario: '',
      resfechareg: '',
      repestado: '',
      repfecha: '',
      repradicado: '',
      repobservacion: '',
      repadjunto: '',
      repusuario: '',
      repfechareg: '',
      facestado: '',
      facfecha: '',
      facfactura: '',
      facvalor: '',
      facobservacion: '',
      facadjunto: '',
      facusuario: '',
      facfechareg: DateTime.now().toString().substring(0, 10),
      soportepago: '',
      soportepagoadjunto: '',
      estado: '',
      estadousuario: '',
      estadofecha: '',
      subclasificacion: '',
    );
  }

  factory Apremio.fromRegistrosSingle(RegistrosSingle registrosSingle) {
    return Apremio(
      id: registrosSingle.id,
      empresa: registrosSingle.empresa,
      contrato: registrosSingle.contrato,
      solicitante: registrosSingle.solicitante,
      nt: registrosSingle.nt,
      coordinadorpmc: registrosSingle.coordinadorpmc,
      clasificacion: registrosSingle.clasificacion,
      i: registrosSingle.i,
      ii: registrosSingle.ii,
      iii: registrosSingle.iii,
      cantidadincumplimientos: registrosSingle.cantidadincumplimientos,
      valor: registrosSingle.valor,
      medio: registrosSingle.medio,
      inspeccion: registrosSingle.inspeccion,
      numinspeccion: registrosSingle.numinspeccion,
      titulo: registrosSingle.titulo,
      proyecto: registrosSingle.proyecto,
      descripcion: registrosSingle.descripcion,
      observaciongeneral: registrosSingle.observaciongeneral,
      usuario: registrosSingle.usuario,
      fechareg: registrosSingle.fechareg,
      solestado: registrosSingle.solestado,
      solfecha: registrosSingle.solfecha,
      solradicado: registrosSingle.solradicado,
      soldestinatario: registrosSingle.soldestinatario,
      solobservacion: registrosSingle.solobservacion,
      soladjunto: registrosSingle.soladjunto,
      solusuario: registrosSingle.solusuario,
      solfechareg: registrosSingle.solfechareg,
      resestado: registrosSingle.resestado,
      resfecha: registrosSingle.resfecha,
      resradicado: registrosSingle.resradicado,
      resobservacion: registrosSingle.resobservacion,
      resadjunto: registrosSingle.resadjunto,
      resusuario: registrosSingle.resusuario,
      resfechareg: registrosSingle.resfechareg,
      repestado: registrosSingle.repestado,
      repfecha: registrosSingle.repfecha,
      repradicado: registrosSingle.repradicado,
      repobservacion: registrosSingle.repobservacion,
      repadjunto: registrosSingle.repadjunto,
      repusuario: registrosSingle.repusuario,
      repfechareg: registrosSingle.repfechareg,
      facestado: registrosSingle.facestado,
      facfecha: registrosSingle.facfecha,
      facfactura: registrosSingle.facfactura,
      facvalor: registrosSingle.facvalor,
      facobservacion: registrosSingle.facobservacion,
      facadjunto: registrosSingle.facadjunto,
      facusuario: registrosSingle.facusuario,
      facfechareg: registrosSingle.facfechareg,
      soportepago: registrosSingle.soportepago,
      soportepagoadjunto: registrosSingle.soportepagoadjunto,
      estado: registrosSingle.estado,
      estadousuario: registrosSingle.estadousuario,
      estadofecha: registrosSingle.estadofecha,
      subclasificacion: registrosSingle.subclasificacion,
    );
  }

  String toJson() => json.encode(toMap());

  factory Apremio.fromJson(String source) =>
      Apremio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Apremio(id: $id, empresa: $empresa, contrato: $contrato, solicitante: $solicitante, nt: $nt, coordinadorpmc: $coordinadorpmc, clasificacion: $clasificacion, i: $i, ii: $ii, iii: $iii, cantidadincumplimientos: $cantidadincumplimientos, valor: $valor, medio: $medio, inspeccion: $inspeccion, numinspeccion: $numinspeccion, titulo: $titulo, proyecto: $proyecto, descripcion: $descripcion, observaciongeneral: $observaciongeneral, usuario: $usuario, fechareg: $fechareg, solestado: $solestado, solfecha: $solfecha, solradicado: $solradicado, soldestinatario: $soldestinatario, solobservacion: $solobservacion, soladjunto: $soladjunto, solusuario: $solusuario, solfechareg: $solfechareg, resestado: $resestado, resfecha: $resfecha, resradicado: $resradicado, resobservacion: $resobservacion, resadjunto: $resadjunto, resusuario: $resusuario, resfechareg: $resfechareg, repestado: $repestado, repfecha: $repfecha, repradicado: $repradicado, repobservacion: $repobservacion, repadjunto: $repadjunto, repusuario: $repusuario, repfechareg: $repfechareg, facestado: $facestado, facfecha: $facfecha, facfactura: $facfactura, facvalor: $facvalor, facobservacion: $facobservacion, facadjunto: $facadjunto, facusuario: $facusuario, facfechareg: $facfechareg, soportepago: $soportepago, soportepagoadjunto: $soportepagoadjunto, estado: $estado, estadousuario: $estadousuario, estadofecha: $estadofecha, subclasificacion: $subclasificacion)';
  }

  @override
  bool operator ==(covariant Apremio other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.empresa == empresa &&
        other.contrato == contrato &&
        other.solicitante == solicitante &&
        other.nt == nt &&
        other.coordinadorpmc == coordinadorpmc &&
        other.clasificacion == clasificacion &&
        other.i == i &&
        other.ii == ii &&
        other.iii == iii &&
        other.cantidadincumplimientos == cantidadincumplimientos &&
        other.valor == valor &&
        other.medio == medio &&
        other.inspeccion == inspeccion &&
        other.numinspeccion == numinspeccion &&
        other.titulo == titulo &&
        other.proyecto == proyecto &&
        other.descripcion == descripcion &&
        other.observaciongeneral == observaciongeneral &&
        other.usuario == usuario &&
        other.fechareg == fechareg &&
        other.solestado == solestado &&
        other.solfecha == solfecha &&
        other.solradicado == solradicado &&
        other.soldestinatario == soldestinatario &&
        other.solobservacion == solobservacion &&
        other.soladjunto == soladjunto &&
        other.solusuario == solusuario &&
        other.solfechareg == solfechareg &&
        other.resestado == resestado &&
        other.resfecha == resfecha &&
        other.resradicado == resradicado &&
        other.resobservacion == resobservacion &&
        other.resadjunto == resadjunto &&
        other.resusuario == resusuario &&
        other.resfechareg == resfechareg &&
        other.repestado == repestado &&
        other.repfecha == repfecha &&
        other.repradicado == repradicado &&
        other.repobservacion == repobservacion &&
        other.repadjunto == repadjunto &&
        other.repusuario == repusuario &&
        other.repfechareg == repfechareg &&
        other.facestado == facestado &&
        other.facfecha == facfecha &&
        other.facfactura == facfactura &&
        other.facvalor == facvalor &&
        other.facobservacion == facobservacion &&
        other.facadjunto == facadjunto &&
        other.facusuario == facusuario &&
        other.facfechareg == facfechareg &&
        other.soportepago == soportepago &&
        other.soportepagoadjunto == soportepagoadjunto &&
        other.estado == estado &&
        other.estadousuario == estadousuario &&
        other.estadofecha == estadofecha &&
        other.subclasificacion == subclasificacion;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        empresa.hashCode ^
        contrato.hashCode ^
        solicitante.hashCode ^
        nt.hashCode ^
        coordinadorpmc.hashCode ^
        clasificacion.hashCode ^
        i.hashCode ^
        ii.hashCode ^
        iii.hashCode ^
        cantidadincumplimientos.hashCode ^
        valor.hashCode ^
        medio.hashCode ^
        inspeccion.hashCode ^
        numinspeccion.hashCode ^
        titulo.hashCode ^
        proyecto.hashCode ^
        descripcion.hashCode ^
        observaciongeneral.hashCode ^
        usuario.hashCode ^
        fechareg.hashCode ^
        solestado.hashCode ^
        solfecha.hashCode ^
        solradicado.hashCode ^
        soldestinatario.hashCode ^
        solobservacion.hashCode ^
        soladjunto.hashCode ^
        solusuario.hashCode ^
        solfechareg.hashCode ^
        resestado.hashCode ^
        resfecha.hashCode ^
        resradicado.hashCode ^
        resobservacion.hashCode ^
        resadjunto.hashCode ^
        resusuario.hashCode ^
        resfechareg.hashCode ^
        repestado.hashCode ^
        repfecha.hashCode ^
        repradicado.hashCode ^
        repobservacion.hashCode ^
        repadjunto.hashCode ^
        repusuario.hashCode ^
        repfechareg.hashCode ^
        facestado.hashCode ^
        facfecha.hashCode ^
        facfactura.hashCode ^
        facvalor.hashCode ^
        facobservacion.hashCode ^
        facadjunto.hashCode ^
        facusuario.hashCode ^
        facfechareg.hashCode ^
        soportepago.hashCode ^
        soportepagoadjunto.hashCode ^
        estado.hashCode ^
        estadousuario.hashCode ^
        estadofecha.hashCode ^
        subclasificacion.hashCode;
  }
}
