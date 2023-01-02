import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum ViewState {
  none,
  loading,
}

class ColorCustom {
  final greenPrimary = const Color.fromARGB(255, 115, 250, 121);
  final bluePrimary = const Color.fromARGB(255, 0, 225, 177);
}

class TransitionScreen<T> extends PageRouteBuilder {
  Widget screen;
  double beginLeft;
  double beginRight;
  Curve curvesAction;
  T? arguments;
  TransitionScreen({
    required this.beginLeft,
    required this.beginRight,
    required this.curvesAction,
    required this.screen,
    this.arguments,
  }) : super(
          settings: RouteSettings(
            arguments: arguments,
          ),
          pageBuilder: (
            _,
            __,
            ___,
          ) =>
              screen,
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(beginLeft, beginRight),
                end: const Offset(0.0, 0.0),
              ).animate(
                  CurvedAnimation(parent: animation, curve: curvesAction)),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    double value = double.parse(newValue.text);
    final money = NumberFormat("###,###,###", "id");

    String newText = money.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

 String replaceFormatCurrency(String textController) {
    final String resultReplaceCurrency;
    resultReplaceCurrency = textController.replaceAll('.', '');
    return resultReplaceCurrency;
  }


String parseNumberCurrencyWithOutRp(num number){
  final String result;
  result = NumberFormat.currency(symbol: '',decimalDigits: 0).format(number);
  return result;
}


String parseNumberCurrencyWithRp(num number){
  final String result;
  result = NumberFormat.currency(symbol: 'Rp.',decimalDigits: 0).format(number).replaceAll(',', '.');
  return result;
}

