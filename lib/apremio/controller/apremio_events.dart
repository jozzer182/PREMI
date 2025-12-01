part of  '../../bloc/main_bloc.dart';

class SetApremio extends MainEvent {
  final Apremio apremio;
  SetApremio({
    required this.apremio,
  });
}

class ApremioField extends MainEvent {
  final Campo campo;
  final String valor;

  ApremioField({
    required this.campo,
    required this.valor,
  });
}

class AddToDbApremio extends MainEvent {
  final BuildContext context;
  AddToDbApremio({
    required this.context,
  });
}
class UpdateToDbApremio extends MainEvent {
  final BuildContext context;
  UpdateToDbApremio({
    required this.context,
  });
}

