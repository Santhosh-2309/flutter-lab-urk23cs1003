# Experiment 6: Integrate Animations and Transition

**Course:** 24CS2016 Building Applications using Flutter  
**Student:** Santhosh V (URK23CS1003)  
**Date:** 21/09/26

## Aim
To implement implicit animations, explicit animation controllers, and custom page transitions in Flutter.

**Concepts:** AnimatedContainer (implicit), AnimationController + RotationTransition (explicit), TickerProviderStateMixin, PageRouteBuilder + SlideTransition

## Quick run (using the files in this repo)

Platform folders (`android/`, `ios/`, `web/` ...) are not stored in the repo; generate them once:

```bash
cd experiment_6
flutter create --project-name experiment_6 .   # generates platform folders, keeps existing lib/ and pubspec.yaml
flutter pub get
flutter analyze      # expected: No issues found!
flutter test         # expected: All tests passed!
flutter run -d chrome
```

## Step-by-step procedure (from scratch)

**Step 1 - Create the project**

```bash
flutter create --project-name experiment_6 experiment_6
cd experiment_6
```

**Step 2 - Implicit animation - `AnimatedContainer`**

```dart
AnimatedContainer(
  duration: const Duration(seconds: 1),
  curve: Curves.easeInOut,
  width: _isLarge ? 200 : 130,
  height: _isLarge ? 200 : 130,
  decoration: BoxDecoration(
    color: _isLarge ? Colors.deepPurple : Colors.deepPurple.shade200,
    borderRadius: BorderRadius.circular(_isLarge ? 28 : 12),
  ),
  child: Center(child: Text(_isLarge ? 'Expanded\n200x200' : 'Normal\n130x130')),
)
```

**Step 3 - State variable**

```dart
late bool _isLarge;
```

**Step 4 - Toggle on button press**

```dart
ElevatedButton.icon(
  onPressed: () => setState(() => _isLarge = !_isLarge),
  icon: const Icon(Icons.play_arrow),
  label: Text(_isLarge ? 'Shrink Box' : 'Animate Box'),
)
```

**Step 5 - Explicit animation**

```dart
_controller = AnimationController(
  duration: const Duration(seconds: 3),
  vsync: this,            // needs SingleTickerProviderStateMixin
)..repeat();
```
Then wrap an icon in `RotationTransition(turns: _rotationAnimation, ...)`. Remember `_controller.dispose()` in `dispose()`.

**Step 6 - Custom page transition**

```dart
Navigator.of(context).push(
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const TransitionDetailsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  ),
);
```

**Step 7 - Run**

```bash
flutter test
flutter run -d chrome
```

## Files

```text
experiment_6/
+-- lib/main.dart
+-- test/widget_test.dart
+-- pubspec.yaml
+-- output/   (screenshots)
```

## Complete code

### `lib/main.dart`
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationApp());
}

class AnimationApp extends StatelessWidget {
  const AnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 6 - Animations & Transition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AnimationHomePage(),
        '/expanded': (context) => const AnimationHomePage(initialExpanded: true),
        '/details': (context) => const TransitionDetailsPage(),
      },
    );
  }
}

class AnimationHomePage extends StatefulWidget {
  final bool initialExpanded;
  const AnimationHomePage({super.key, this.initialExpanded = false});

  @override
  State<AnimationHomePage> createState() => _AnimationHomePageState();
}

class _AnimationHomePageState extends State<AnimationHomePage>
    with SingleTickerProviderStateMixin {
  // Implicit animation state
  late bool _isLarge;

  // Explicit animation controller
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _isLarge = widget.initialExpanded;
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToTransitionPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const TransitionDetailsPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations & Transitions'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Student Animation Laboratory',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Santhosh V — URK23CS1003',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '1. Implicit Animation (AnimatedContainer)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        width: _isLarge ? 200 : 130,
                        height: _isLarge ? 200 : 130,
                        decoration: BoxDecoration(
                          color: _isLarge
                              ? Colors.deepPurple
                              : Colors.deepPurple.shade200,
                          borderRadius: BorderRadius.circular(_isLarge ? 28 : 12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _isLarge ? 'Expanded\n200x200' : 'Normal\n130x130',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _isLarge ? Colors.white : Colors.deepPurple.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: _isLarge ? 16 : 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLarge = !_isLarge;
                          });
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: Text(_isLarge ? 'Shrink Box' : 'Animate Box'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '2. Explicit Animation & Slide Transition',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            turns: _rotationAnimation,
                            child: const Icon(
                              Icons.refresh,
                              size: 36,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continuous Rotation via AnimationController',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          minimumSize: const Size(220, 42),
                        ),
                        onPressed: _navigateToTransitionPage,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Open Page with SlideTransition'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransitionDetailsPage extends StatelessWidget {
  const TransitionDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Transition Details'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.animation,
                    size: 64,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'SlideTransition Successful',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Demonstrating custom RouteTransitionsBuilder with SlideTransition.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Student: Santhosh V (URK23CS1003)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 44),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Return to Home'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### `test/widget_test.dart`
```dart
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
```

### `pubspec.yaml`
```yaml
name: experiment_6
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.13.2

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package
```

## Expected output

**Initial state: Normal 130x130**

![Initial state: Normal 130x130](output/1_implicit_normal.png)

**After clicking Animate Box: Expanded 200x200**

![After clicking Animate Box: Expanded 200x200](output/2_implicit_expanded.png)

**Page reached via SlideTransition**

![Page reached via SlideTransition](output/3_page_transition.png)

1. **Student Animation Laboratory** screen. Purple box `Normal 130x130`; a rotating icon (3 s per turn) in the second card.
2. Click **Animate Box** -> over **1 second** the box grows to `Expanded 200x200`, turns darker purple, and its corners get rounder. Button text becomes **Shrink Box**.
3. Click **Open Page with SlideTransition** -> the new page **slides in from the right**: `SlideTransition Successful`. **Return to Home** goes back.

## Result
A Flutter application with animations and page transitions was developed successfully. AnimatedContainer was used to smoothly interpolate size, color, and border radius on button interaction. Continuous rotation was implemented using an explicit AnimationController and RotationTransition. Custom route transitions were created using PageRouteBuilder and SlideTransition.
