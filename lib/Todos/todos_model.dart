// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../resources/env_config.dart';

class Registros {
  List<RegistrosSingle> registrosList = [];
  List<RegistrosSingle> registrosListSearch = [];
  List<RegistrosSingle> solicitadosList = [];
  List<RegistrosSingle> solicitadosListSearch = [];
  List<RegistrosSingle> respuestaList = [];
  List<RegistrosSingle> respuestaListSearch = [];
  List<RegistrosSingle> replicaList = [];
  List<RegistrosSingle> replicaListSearch = [];
  List<RegistrosSingle> facturaList = [];
  List<RegistrosSingle> facturaListSearch = [];
  int totalRegistros = 0;
  int totalSolicitados = 0;
  int totalRespuesta = 0;
  int totalReplica = 0;
  int totalFactura = 0;
  int totalRegistrosVencidos = 0;
  int totalSolicitadosVencidos = 0;
  int totalRespuestaVencidos = 0;
  int totalReplicaVencidos = 0;
  int totalFacturaVencidos = 0;

  int viewRegistros = 10;
  int viewSolicitados = 10;
  int viewRespuestas = 10;
  int viewReplicas = 10;
  int viewFacturas = 10;

  buscarRegistros(String busqueda) {
    registrosListSearch = [...registrosList];
    registrosListSearch = registrosList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  buscarSolicitados(String busqueda) {
    solicitadosListSearch = [...solicitadosList];
    solicitadosListSearch = solicitadosList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  buscarRespuestas(String busqueda) {
    respuestaListSearch = [...respuestaList];
    respuestaListSearch = respuestaList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  buscarReplicas(String busqueda) {
    replicaListSearch = [...replicaList];
    replicaListSearch = replicaList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  buscarFacturas(String busqueda) {
    facturaListSearch = [...facturaList];
    facturaListSearch = facturaList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }

  Future obtener() async {
    var dataSend = {
      'info': {'libro': 'DB', 'hoja': 'reg'},
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
      registrosList.add(RegistrosSingle.fromMap(item));
    }
    registrosListSearch = [...registrosList];
    registrosList.sort((a, b) => b.id.compareTo(a.id));
    totalRegistros = registrosList.length;
    totalRegistrosVencidos = registrosList
        .where((e) => e.estado.contains('vencido'))
        .toList()
        .length;
    //solicitados
    solicitadosList =
        registrosList.where((e) => e.estado.contains('solicitado')).toList();
    solicitadosListSearch = [...solicitadosList];
    totalSolicitados = solicitadosList.length;
    totalSolicitadosVencidos = solicitadosList
        .where((e) => e.estado.contains('vencido'))
        .toList()
        .length;
    //respuesta
    respuestaList =
        registrosList.where((e) => e.estado.contains('respuesta')).toList();
    respuestaListSearch = [...respuestaList];
    totalRespuesta = respuestaList.length;
    totalRespuestaVencidos = respuestaList
        .where((e) => e.estado.contains('vencido'))
        .toList()
        .length;
    //replica
    replicaList =
        registrosList.where((e) => e.estado.contains('replica')).toList();
    replicaListSearch = [...replicaList];
    totalReplica = replicaList.length;
    totalReplicaVencidos =
        replicaList.where((e) => e.estado.contains('vencido')).toList().length;
    //factura
    facturaList =
        registrosList.where((e) => e.estado.contains('factura')).toList();
    facturaListSearch = [...facturaList];
    totalFactura = facturaList.length;
    totalFacturaVencidos =
        facturaList.where((e) => e.estado.contains('no')).toList().length;
    totalFactura -= totalFacturaVencidos;
    return response.statusCode;
  }

  buscar(String busqueda) {
    registrosListSearch = [...registrosList];
    registrosListSearch = registrosList
        .where((element) => element.toList().any((item) =>
            item.toString().toLowerCase().contains(busqueda.toLowerCase())))
        .toList();
  }
}

class RegistrosSingle {
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
  RegistrosSingle({
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

  toList() {
    return [
      id,
      empresa,
      contrato,
      solicitante,
      nt,
      coordinadorpmc,
      clasificacion,
      i,
      ii,
      iii,
      cantidadincumplimientos,
      valor,
      medio,
      inspeccion,
      numinspeccion,
      titulo,
      proyecto,
      descripcion,
      observaciongeneral,
      usuario,
      fechareg,
      solestado,
      solfecha,
      solradicado,
      soldestinatario,
      solobservacion,
      soladjunto,
      solusuario,
      solfechareg,
      resestado,
      resfecha,
      resradicado,
      resobservacion,
      resadjunto,
      resusuario,
      resfechareg,
      repestado,
      repfecha,
      repradicado,
      repobservacion,
      repadjunto,
      repusuario,
      repfechareg,
      facestado,
      facfecha,
      facfactura,
      facvalor,
      facobservacion,
      facadjunto,
      facusuario,
      facfechareg,
      soportepago,
      soportepagoadjunto,
      estado,
      estadousuario,
      estadofecha,
      subclasificacion,
    ];
  }

  RegistrosSingle copyWith({
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
    return RegistrosSingle(
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

  factory RegistrosSingle.fromMap(Map<String, dynamic> map) {
    return RegistrosSingle(
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
      fechareg: map['fechareg'].toString(),
      solestado: map['solestado'].toString(),
      solfecha: map['solfecha'].toString().length > 10
          ? map['solfecha'].toString().substring(0, 10)
          : map['solfecha'].toString(),
      solradicado: map['solradicado'].toString(),
      soldestinatario: map['soldestinatario'].toString(),
      solobservacion: map['solobservacion'].toString(),
      soladjunto: map['soladjunto'].toString(),
      solusuario: map['solusuario'].toString(),
      solfechareg: map['solfechareg'].toString().length > 10
          ? map['solfechareg'].toString().substring(0, 10)
          : map['solfechareg'].toString(),
      resestado: map['resestado'].toString(),
      resfecha: map['resfecha'].toString().length > 10
          ? map['resfecha'].toString().substring(0, 10)
          : map['resfecha'].toString(),
      resradicado: map['resradicado'].toString(),
      resobservacion: map['resobservacion'].toString(),
      resadjunto: map['resadjunto'].toString(),
      resusuario: map['resusuario'].toString(),
      resfechareg: map['resfechareg'].toString().length > 10
          ? map['resfechareg'].toString().substring(0, 10)
          : map['resfechareg'].toString(),
      repestado: map['repestado'].toString(),
      repfecha: map['repfecha'].toString().length > 10
          ? map['repfecha'].toString().substring(0, 10)
          : map['repfecha'].toString(),
      repradicado: map['repradicado'].toString(),
      repobservacion: map['repobservacion'].toString(),
      repadjunto: map['repadjunto'].toString(),
      repusuario: map['repusuario'].toString(),
      repfechareg: map['repfechareg'].toString().length > 10
          ? map['repfechareg'].toString().substring(0, 10)
          : map['repfechareg'].toString(),
      facestado: map['facestado'].toString(),
      facfecha: map['facfecha'].toString().length > 10
          ? map['facfecha'].toString().substring(0, 10)
          : map['facfecha'].toString(),
      facfactura: map['facfactura'].toString(),
      facvalor: map['facvalor'].toString().replaceAll(',', ''),
      facobservacion: map['facobservacion'].toString(),
      facadjunto: map['facadjunto'].toString(),
      facusuario: map['facusuario'].toString(),
      facfechareg: map['facfechareg'].toString().length > 10
          ? map['facfechareg'].toString().substring(0, 10)
          : map['facfechareg'].toString(),
      soportepago: map['soportepago']?.toString() ?? '',
      soportepagoadjunto: map['soportepagoadjunto']?.toString() ?? '',
      estado: map['estado'].toString(),
      estadousuario: map['estadousuario'].toString(),
      estadofecha: map['estadofecha'].toString().length > 10
          ? map['estadofecha'].toString().substring(0, 10)
          : map['estadofecha'].toString(),
      subclasificacion: map['subclasificacion'].toString(),
    );
  }

  factory RegistrosSingle.fromZero() {
    return RegistrosSingle(
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
      facfechareg: '',
      soportepago: '',
      soportepagoadjunto: '',
      estado: '',
      estadousuario: '',
      estadofecha: '',
      subclasificacion: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrosSingle.fromJson(String source) =>
      RegistrosSingle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegistrosSingle(id: $id, empresa: $empresa, contrato: $contrato, solicitante: $solicitante, nt: $nt, coordinadorpmc: $coordinadorpmc, clasificacion: $clasificacion, i: $i, ii: $ii, iii: $iii, cantidadincumplimientos: $cantidadincumplimientos, valor: $valor, medio: $medio, inspeccion: $inspeccion, numinspeccion: $numinspeccion, titulo: $titulo, proyecto: $proyecto, descripcion: $descripcion, observaciongeneral: $observaciongeneral, usuario: $usuario, fechareg: $fechareg, solestado: $solestado, solfecha: $solfecha, solradicado: $solradicado, soldestinatario: $soldestinatario, solobservacion: $solobservacion, soladjunto: $soladjunto, solusuario: $solusuario, solfechareg: $solfechareg, resestado: $resestado, resfecha: $resfecha, resradicado: $resradicado, resobservacion: $resobservacion, resadjunto: $resadjunto, resusuario: $resusuario, resfechareg: $resfechareg, repestado: $repestado, repfecha: $repfecha, repradicado: $repradicado, repobservacion: $repobservacion, repadjunto: $repadjunto, repusuario: $repusuario, repfechareg: $repfechareg, facestado: $facestado, facfecha: $facfecha, facfactura: $facfactura, facvalor: $facvalor, facobservacion: $facobservacion, facadjunto: $facadjunto, facusuario: $facusuario, facfechareg: $facfechareg, soportepago: $soportepago, soportepagoadjunto: $soportepagoadjunto, estado: $estado, estadousuario: $estadousuario, estadofecha: $estadofecha, subclasificacion: $subclasificacion)';
  }

  @override
  bool operator ==(covariant RegistrosSingle other) {
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
        other.estadofecha == estadofecha;
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
        estadofecha.hashCode;
  }
}
