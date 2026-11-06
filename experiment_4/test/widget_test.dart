import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experiment_4/main.dart';

void main() {
  testWidgets('Media gallery shows image assets', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Media Gallery'), findsOneWidget);
    expect(find.text('Flutter Image'), findsOneWidget);
    expect(find.text('Image Gallery'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });
}
