import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experiment_2/main.dart';

void main() {
  testWidgets('Layout switches between mobile and desktop', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.view.devicePixelRatio = 1.0;

    // Mobile: width < 600 -> Column of ListTiles
    tester.view.physicalSize = const Size(400, 900);
    await tester.pumpWidget(const MyApp());
    expect(find.text('Responsive Student Dashboard'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));
    expect(find.text('View'), findsNothing);

    // Desktop: width >= 600 -> 2x2 cards with View buttons
    tester.view.physicalSize = const Size(1400, 1000);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNothing);
    expect(find.text('View'), findsNWidgets(4));
  });
}
