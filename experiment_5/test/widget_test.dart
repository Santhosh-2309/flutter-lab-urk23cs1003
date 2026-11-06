import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_5/main.dart';

void main() {
  testWidgets('Navigation flow between Home, Profile, and Details screens', (WidgetTester tester) async {
    await tester.pumpWidget(const NavigationApp());

    // Verify Home Screen is displayed
    expect(find.text('Student Navigation Portal'), findsOneWidget);
    expect(find.text('Welcome, Santhosh V (URK23CS1003)'), findsOneWidget);

    // Tap 'Go to Profile (Push)'
    await tester.tap(find.text('Go to Profile (Push)'));
    await tester.pumpAndSettle();

    // Verify Profile Screen
    expect(find.text('Student Profile'), findsOneWidget);
    expect(find.text('Register No: URK23CS1003'), findsOneWidget);

    // Tap 'View Academic Details'
    await tester.tap(find.text('View Academic Details'));
    await tester.pumpAndSettle();

    // Verify Details Screen
    expect(find.text('Academic Details'), findsOneWidget);
    expect(find.text('24CS2016 Building Applications using Flutter'), findsOneWidget);

    // Pop back to Profile
    await tester.tap(find.text('Back to Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Student Profile'), findsOneWidget);

    // Pop back to Home
    await tester.tap(find.text('Back to Home Screen'));
    await tester.pumpAndSettle();

    expect(find.text('Student Navigation Portal'), findsOneWidget);

    // Tap named route
    await tester.tap(find.text('Go to Profile (Named)'));
    await tester.pumpAndSettle();

    expect(find.text('Student Profile'), findsOneWidget);
  });
}
