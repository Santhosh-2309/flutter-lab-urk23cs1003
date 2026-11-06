import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experiment_1/main.dart';

void main() {
  testWidgets('Student dashboard renders widgets and layouts', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Student Dashboard'), findsOneWidget);
    expect(find.text('Student Profile'), findsOneWidget);
    expect(find.text('Computer Science and Engineering'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Cloud Computing'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(4));
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
