import 'package:intl/intl.dart';

toCurrency(String? string){
  if(string == null || string.isEmpty) return '';
  return NumberFormat.decimalPattern('en').format(double.parse(string));
}

toCurrencyEU(String? string){
  if(string == null || string.isEmpty) return '';
  return '\$ ${NumberFormat.decimalPattern('en_EU').format(int.parse(string))} €';
}

toCurrencyCOP(String? string){
  if(string == null || string.isEmpty) return '';
  return '\$ ${NumberFormat.decimalPattern('es').format(int.parse(string))} COP';
}

toCurrency$(String? string){
  if(string == null || string.isEmpty) return '';
  return '\$ ${NumberFormat.decimalPattern('es').format(int.parse(string))}';
}