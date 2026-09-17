import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:abdallah_ali_rehab_portfolio/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const PortfolioApp(initialThemeMode: ThemeMode.dark),
    );
    await tester.pumpAndSettle();

    // Verify that the hero name and current role are present.
    expect(find.text('Abdallah Ali Rehab'), findsWidgets);
    expect(find.text('Senior Mobile Engineer · Flutter'), findsOneWidget);
  });
}
