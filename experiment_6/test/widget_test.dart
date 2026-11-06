import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_6/main.dart';

void main() {
  testWidgets('Implicit animation and PageTransition test', (WidgetTester tester) async {
    await tester.pumpWidget(const AnimationApp());

    // Verify initial render
    expect(find.text('Student Animation Laboratory'), findsOneWidget);
    expect(find.text('Normal\n130x130'), findsOneWidget);
    expect(find.text('Animate Box'), findsOneWidget);

    // Tap Animate Box
    await tester.tap(find.text('Animate Box'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Verify AnimatedContainer state change
    expect(find.text('Expanded\n200x200'), findsOneWidget);
    expect(find.text('Shrink Box'), findsOneWidget);

    // Ensure SlideTransition button is visible and tap it
    final buttonFinder = find.text('Open Page with SlideTransition');
    await tester.ensureVisible(buttonFinder);
    await tester.tap(buttonFinder);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('SlideTransition Successful'), findsOneWidget);

    // Tap Return to Home
    await tester.tap(find.text('Return to Home'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Student Animation Laboratory'), findsOneWidget);
  });
}
