// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/main_bloc.dart';
import '../../resources/file_uploader.dart';
import '../../resources/toCurrency.dart';
import '../model/apremio_enum.dart';

class FieldPre extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  int? flex;
  String initialValue;
  Campo campo;
  String label;
  Color color;
  bool edit;
  Iterable<String> opciones;
  bool isNumber;
  TipoCampo tipoCampo;
  String carpeta = 'entregado';
  String pdi = 'TEST';

  FieldPre({
    required this.flex,
    required this.initialValue,
    required this.campo,
    required this.label,
    required this.color,
    required this.edit,
    this.opciones = const [],
    this.isNumber = false,
    required this.tipoCampo,
    this.carpeta = 'entregado',
    this.pdi = 'TEST',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (tipoCampo == TipoCampo.textoLargo) {
      return LargeField(
        edit: edit,
        campo: campo,
        label: label,
        initialValue: initialValue,
      );
    }

    if (edit) {
      if (tipoCampo == TipoCampo.texto) {
        return Field(
          flex: flex,
          opciones: opciones,
          campo: campo,
          label: label,
          color: color,
          isNumber: isNumber,
          initialValue: initialValue,
        );
      }
      if (tipoCampo == TipoCampo.doble) {
        return FieldDoble(
          flex: flex,
          opciones: opciones,
          campo: campo,
          label: label,
          color: color,
          isNumber: isNumber,
          initialValue: initialValue,
        );
      }
      if (tipoCampo == TipoCampo.desplegable) {
        return FieldDesplegable(
          flex: flex,
          opciones: opciones,
          color: color,
          campo: campo,
          label: label,
          initialValue: initialValue.isEmpty ? null : initialValue,
        );
      }
      if (tipoCampo == TipoCampo.fecha) {
        return FieldDate(
          flex: flex,
          color: color,
          campo: campo,
          label: label,
          date: initialValue,
        );
      }
      if (tipoCampo == TipoCampo.file) {
        return FieldFile(
          flex: flex,
          color: color,
          campo: campo,
          label: label,
          file: initialValue,
          carpeta: carpeta,
          pdi: pdi,
        );
      }
    }
    if (tipoCampo == TipoCampo.file) {
      return OpenFile(
        flex: flex,
        color: color,
        campo: campo,
        label: label,
        file: initialValue,
        carpeta: carpeta,
        pdi: pdi,
      );
    }
    if (tipoCampo == TipoCampo.switcher) {
      return FieldSwitch(
        flex: flex,
        edit: edit,
        campo: campo,
        initialValue: initialValue,
        label: label,
      );
    }
    controller.text = initialValue;
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(),
    );
  }

  TextField _intField() {
    if (isNumber) controller.text = toCurrency(initialValue);
    return TextField(
      textAlign: isNumber ? TextAlign.end : TextAlign.start,
      controller: controller,
      onChanged: (value) {
        controller.text = initialValue;
        if (isNumber) controller.text = toCurrency(initialValue);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8.0),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class Field extends StatefulWidget {
  int? flex;
  Iterable<String> opciones;
  Color color;
  Campo campo;
  String label;
  bool isNumber;
  String? initialValue;
  Field({
    Key? key,
    required this.flex,
    required this.opciones,
    required this.campo,
    required this.label,
    required this.color,
    required this.isNumber,
    this.initialValue,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    if (widget.flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(),
      );
    }
    return Expanded(
      flex: widget.flex!,
      child: _intField(),
    );
  }

  Autocomplete<String> _intField() {
    return Autocomplete<String>(
      displayStringForOption: (option) {
        return option;
      },
      optionsBuilder: (textEditingValue) {
        var optionsX = widget.opciones
            .toSet()
            .where((e) =>
                e.toLowerCase().contains(textEditingValue.text.toLowerCase()))
            .toList();
        optionsX.sort((a, b) => b.compareTo(a));
        return optionsX;
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Material(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, i) {
              String option = options.toList()[i];
              return ListTile(
                title: Text(option, style: const TextStyle(fontSize: 14)),
                onTap: () {
                  print('called: $option');
                  onSelected(options.toList()[i]);
                  context.read<MainBloc>().add(
                        ApremioField(
                          campo: widget.campo,
                          valor: option,
                        ),
                      );
                },
              );
            },
          ),
        );
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        if (widget.initialValue != null) {
          if (widget.initialValue!.isEmpty || !widget.isNumber) {
            textEditingController.value = textEditingController.value.copyWith(
              text: widget.initialValue,
              // selection: TextSelection.collapsed(offset: initialValue!.length),
            );
          } else {
            String string = toCurrency(widget.initialValue);
            textEditingController.value = textEditingController.value.copyWith(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          }
        }

        return TextField(
          textAlign: widget.isNumber ? TextAlign.end : TextAlign.start,
          controller: textEditingController, // Required by autocomplete
          focusNode: focusNode, // Required by autocomplete
          inputFormatters:
              widget.isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
          onChanged: (value) {
            context.read<MainBloc>().add(
                  ApremioField(
                    campo: widget.campo,
                    valor: value,
                  ),
                );
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelText: widget.label,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.color,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.color,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FieldDoble extends StatefulWidget {
  int? flex;
  Iterable<String> opciones;
  Color color;
  Campo campo;
  String label;
  bool isNumber = true;
  String? initialValue;
  FieldDoble({
    Key? key,
    required this.flex,
    required this.opciones,
    required this.campo,
    required this.label,
    required this.color,
    this.isNumber = true,
    this.initialValue,
  }) : super(key: key);

  @override
  State<FieldDoble> createState() => _FieldDobleState();
}

class _FieldDobleState extends State<FieldDoble> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(),
      );
    }
    return Expanded(
      flex: widget.flex!,
      child: _intField(),
    );
  }

  Widget _intField() {
    return TextField(
      textAlign: widget.isNumber ? TextAlign.end : TextAlign.start,
      controller: textEditingController, // Required by autocomplete
      inputFormatters: widget.isNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
          : null,
      onChanged: (value) {
        context.read<MainBloc>().add(
              ApremioField(
                campo: widget.campo,
                valor: value,
              ),
            );
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: widget.label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
            width: 2,
          ),
        ),
      ),
    );
    
  }
}

class FieldFile extends StatelessWidget {
  TextEditingController fileUploadController = TextEditingController();
  int? flex;
  String file;
  String carpeta;
  String pdi;
  Campo campo;
  String label;
  Color color;

  FieldFile({
    required this.flex,
    required this.file,
    required this.carpeta,
    required this.pdi,
    required this.campo,
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    fileUploadController.text = file;
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(context),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(context),
    );
  }

  TextField _intField(BuildContext context) {
    return TextField(
      controller: fileUploadController,
      readOnly: true,
      onTap: () async {
        context.read<MainBloc>().add(
              Loading(isLoading: true),
            );
        final result = await FilePicker.platform.pickFiles();
        if (result != null) {
          var file = result.files.first;
          fileUploadController.text = await FileUploadToDrive.uploadAndGetUrl(
            file: file,
            carpeta: carpeta,
          );
          context.read<MainBloc>().add(
                ApremioField(
                  campo: campo,
                  valor: fileUploadController.text,
                ),
              );
          context.read<MainBloc>().add(
                Loading(isLoading: false),
              );
        }
        context.read<MainBloc>().add(
              Loading(isLoading: false),
            );
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}

class OpenFile extends StatelessWidget {
  final TextEditingController fileUploadController = TextEditingController();
  final int? flex;
  final String file;
  final String carpeta;
  final String pdi;
  final Campo campo;
  final String label;
  final Color color;

  OpenFile({
    required this.flex,
    required this.file,
    required this.carpeta,
    required this.pdi,
    required this.campo,
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    fileUploadController.text = file;
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(),
    );
  }

  InkWell _intField() {
    return InkWell(
      onTap: () async {
        await launchUrl(Uri.parse(file));
      },
      child: TextField(
        controller: fileUploadController,
        readOnly: true,
        onTap: () async {
          await launchUrl(Uri.parse(file));
        },
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

class FieldDate extends StatelessWidget {
  final TextEditingController dateController = TextEditingController();
  final int? flex;
  final String date;
  final Campo campo;
  final String label;
  final Color color;
  FieldDate({
    required this.flex,
    required this.date,
    required this.campo,
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    dateController.text = date;
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(context),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(context),
    );
  }

  TextField _intField(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: dateController,
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2030),
        );
        if (newDate != null) {
          context.read<MainBloc>().add(
                ApremioField(
                  campo: campo,
                  valor:
                      '${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}',
                ),
              );
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class FieldDesplegable extends StatelessWidget {
  final int? flex;
  final Iterable<String> opciones;
  final Color color;
  final Campo campo;
  final String label;
  String? initialValue;
  FieldDesplegable({
    required this.flex,
    required this.opciones,
    required this.color,
    required this.campo,
    required this.label,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) initialValue = initialValue!.toLowerCase();
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(context),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(context),
    );
  }

  DropdownButtonFormField<String> _intField(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      isExpanded: true,
      onChanged: (value) {
        context.read<MainBloc>().add(
              ApremioField(
                campo: campo,
                valor: value.toString(),
              ),
            );
      },
      items: opciones
          .toSet()
          .map((e) => DropdownMenuItem(
              value: e.toLowerCase(), child: Text(e.toLowerCase())))
          .toList(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}

class FieldSwitch extends StatelessWidget {
  final String label;
  final String initialValue;
  final Campo campo;
  final bool edit;
  final int? flex;
  const FieldSwitch({
    required this.flex,
    required this.edit,
    required this.campo,
    required this.initialValue,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool value = initialValue == "true" ? true : false;
    if (flex == null) {
      return SizedBox(
        height: 40,
        child: _intField(value, context),
      );
    }
    return Expanded(
      flex: flex!,
      child: _intField(value, context),
    );
  }

  Row _intField(bool value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: !edit
              ? null
              : (valor) {
                  // print(valor.toString());
                  context.read<MainBloc>().add(
                        ApremioField(
                          campo: campo,
                          valor: valor.toString(),
                        ),
                      );
                },
        ),
      ],
    );
  }
}

class LargeField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Campo campo;
  final bool edit;

  const LargeField({
    required this.edit,
    required this.campo,
    required this.initialValue,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: !edit,
      initialValue: initialValue,
      maxLines: null,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) {
        context.read<MainBloc>().add(
              ApremioField(
                campo: campo,
                valor: value,
              ),
            );
      },
    );
  }
}

enum TipoCampo {
  texto,
  doble,
  textoLargo,
  desplegable,
  fecha,
  file,
  switcher,
}
