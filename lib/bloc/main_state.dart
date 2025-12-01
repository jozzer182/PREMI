part of 'main_bloc.dart';

class MainState {
  int dialogCounter;
  String dialogMessage;
  String message;
  int messageCounter;
  int errorCounter;
  Color messageColor;
  bool isLoading;
  bool isDark = false;
  Color? themeColor;
  Nt? nt;
  Solicitante? solicitante;
  Clasificacion? clasificacion;
  Empresa? empresa;
  Medio? medio;
  Registros? registros;
  Coordinador? coordinador;
  User? user;
  Users? users;
  Perfiles? perfiles;
  Subclasificacion? subclasificacion;
  Apremio? apremio;

  MainState({
    this.dialogCounter = 0,
    this.dialogMessage = '',
    this.message = '',
    this.messageCounter = 0,
    this.errorCounter = 0,
    this.messageColor = Colors.red,
    this.isLoading = false,
    this.isDark = false,
    this.themeColor,
    this.nt,
    this.solicitante,
    this.clasificacion,
    this.empresa,
    this.medio,
    this.registros,
    this.coordinador,
    this.user,
    this.users,
    this.perfiles,
    this.subclasificacion,
    this.apremio,
  });

  initial() {
    dialogCounter = 0;
    dialogMessage = '';
    message = '';
    messageCounter = 0;
    errorCounter = 0;
    messageColor = Colors.red;
    isLoading = false;
    isDark = false;
    themeColor = null;
    nt = null;
    solicitante = null;
    clasificacion = null;
    empresa = null;
    medio = null;
    registros = null;
    coordinador = null;
    user = null;
    users = null;
    perfiles = null;
    subclasificacion = null;
    apremio = null;
  }

  MainState copyWith({
    int? dialogCounter,
    String? dialogMessage,
    String? message,
    int? messageCounter,
    int? errorCounter,
    Color? messageColor,
    bool? isLoading,
    bool? isDark,
    Color? themeColor,
    Nt? nt,
    Solicitante? solicitante,
    Clasificacion? clasificacion,
    Empresa? empresa,
    Medio? medio,
    Registros? registros,
    Coordinador? coordinador,
    User? user,
    Users? users,
    Perfiles? perfiles,
    Subclasificacion? subclasificacion,
    Apremio? apremio,
  }) {
    return MainState(
      dialogCounter: dialogCounter ?? this.dialogCounter,
      dialogMessage: dialogMessage ?? this.dialogMessage,
      message: message ?? this.message,
      messageCounter: messageCounter ?? this.messageCounter,
      errorCounter: errorCounter ?? this.errorCounter,
      messageColor: messageColor ?? this.messageColor,
      isLoading: isLoading ?? this.isLoading,
      isDark: isDark ?? this.isDark,
      themeColor: themeColor ?? this.themeColor,
      nt: nt ?? this.nt,
      solicitante: solicitante ?? this.solicitante,
      clasificacion: clasificacion ?? this.clasificacion,
      empresa: empresa ?? this.empresa,
      medio: medio ?? this.medio,
      registros: registros ?? this.registros,
      coordinador: coordinador ?? this.coordinador,
      user: user ?? this.user,
      users: users ?? this.users,
      perfiles: perfiles ?? this.perfiles,
      subclasificacion: subclasificacion ?? this.subclasificacion,
      apremio: apremio ?? this.apremio,
    );
  }
}
