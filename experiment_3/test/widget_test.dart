import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experiment_3/main.dart';

void main() {
  testWidgets('Form validates name and shows SnackBar', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    expect(find.text('Student Registration Form'), findsOneWidget);

    // Empty name -> validation error
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Enter student name'), findsOneWidget);
    expect(find.text('Form submitted successfully'), findsNothing);

    // Valid name -> success SnackBar
    await tester.enterText(find.byType(TextFormField).first, 'Santhosh');
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Enter student name'), findsNothing);
    expect(find.text('Form submitted successfully'), findsOneWidget);
  });
}
