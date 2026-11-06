import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_7/main.dart';

void main() {
  testWidgets('State management and JSON serialization test', (WidgetTester tester) async {
    await tester.pumpWidget(const StateApp());

    // Verify initial render
    expect(find.text('Student Record Management'), findsOneWidget);
    expect(find.text('Santhosh V — URK23CS1003'), findsOneWidget);
    expect(find.text('No students added yet. Add a student above or load demo data.'), findsOneWidget);

    // Enter student details
    await tester.enterText(find.byType(TextField).at(0), 'Santhosh V');
    await tester.enterText(find.byType(TextField).at(1), '24CS2016 Flutter Lab');

    // Tap Add Student
    await tester.tap(find.text('Add Student'));
    await tester.pumpAndSettle();

    // Verify student added to list
    expect(find.text('Santhosh V'), findsOneWidget);
    expect(find.text('Course: 24CS2016 Flutter Lab'), findsOneWidget);

    // Verify JSON serialization output
    expect(find.text('{"id":1,"name":"Santhosh V","course":"24CS2016 Flutter Lab"}'), findsOneWidget);
    expect(find.text('fromJson(): Student(id: 1, name: "Santhosh V", course: "24CS2016 Flutter Lab")'), findsOneWidget);
  });
}
