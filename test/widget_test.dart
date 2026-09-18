import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:abdallah_ali_rehab_portfolio/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const PortfolioApp(initialThemeMode: ThemeMode.dark),
    );
    // Not pumpAndSettle(): the hero has a deliberately perpetual ambient
    // animation (the orbiting background ring), so "settled" never happens.
    // A couple of bounded pumps is enough for entrance fades to resolve.
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    // Verify that the hero name and current role are present.
    expect(find.text('Abdallah Ali Rehab'), findsWidgets);
    expect(find.text('Senior Mobile Engineer · Flutter'), findsOneWidget);
  });
}
