part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class Load extends MainEvent {}

enum TypeMessage { error, message }

class NewMessage extends MainEvent {
  final String message;
  final Color color;
  final TypeMessage typeMessage;
  NewMessage({
    required this.message,
    required this.color,
    required this.typeMessage,
  });
}

class Loading extends MainEvent {
  final bool isLoading;
  Loading({
    required this.isLoading,
  });
}

class ThemeChange extends MainEvent {
  ThemeChange();
}

class ThemeColorChange extends MainEvent {
  final Color color;
  ThemeColorChange({
    required this.color,
  });
}

class ListLoadMore extends MainEvent {
  final String table;

  ListLoadMore({
    required this.table,
  });
}

class Busqueda extends MainEvent {
  final String value;
  final String table;
  Busqueda({
    required this.value,
    required this.table,
  });
}