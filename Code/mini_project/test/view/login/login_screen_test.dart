import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_project/view/login/widget/header_component.dart';
import 'package:mini_project/view/login/widget/move_signup.dart';

void main() {
  group('Login Screen', () {
    testWidgets('Header Component', (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeaderComponent(),
          ),
        ),
      );
      expect(find.text('SELAMAT DATANG'), findsOneWidget);
      expect(find.text('Silahkan masuk terlebih dahulu!'), findsOneWidget);
    });

    testWidgets('Move Signup', (widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SignUp(),
          ),
        ),
      );

      expect(find.text('Belum punya Akun?'), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });
}
