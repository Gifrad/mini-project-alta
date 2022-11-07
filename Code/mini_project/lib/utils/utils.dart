import 'package:flutter/material.dart';

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
              ).animate(CurvedAnimation(parent: animation, curve: curvesAction)),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}
