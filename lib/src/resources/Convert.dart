
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

class Convert {
  static double convertDouble(String valor) {
    String valueString = UtilBrasilFields.removerSimboloMoeda(valor);
    return UtilBrasilFields.converterMoedaParaDouble(valueString);
  }

  static String convertDoubleReal(double valor) {
    var f = NumberFormat('R\$ #,###,###.##', 'pt_BR');
    print(f.format(valor));
    return f.format(valor);
  }
}