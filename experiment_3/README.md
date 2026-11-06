# Experiment 3: Add Interactivity to App - Input and Forms

**Course:** 24CS2016 Building Applications using Flutter  
**Student:** Santhosh V (URK23CS1003)  
**Date:** 07/09/26

## Aim
To create an interactive Flutter form with input fields and validation.

**Concepts:** Form, GlobalKey<FormState>, TextFormField, validator, obscureText, keyboardType, ElevatedButton, SnackBar

## Quick run (using the files in this repo)

Platform folders (`android/`, `ios/`, `web/` ...) are not stored in the repo; generate them once:

```bash
cd experiment_3
flutter create --project-name experiment_3 .   # generates platform folders, keeps existing lib/ and pubspec.yaml
flutter pub get
flutter analyze      # expected: No issues found!
flutter test         # expected: All tests passed!
flutter run -d chrome
```

## Step-by-step procedure (from scratch)

**Step 1 - Create the project**

```bash
flutter create --project-name experiment_3 experiment_3
cd experiment_3
code .
```

**Step 2 - Open `lib/main.dart`**

Make `StudentRegistrationPage` a **StatefulWidget**.

**Step 3 - Create the form key**

```dart
final _formKey = GlobalKey<FormState>();
```

**Step 4 - Wrap the fields in `Form(key: _formKey, ...)`**

Fields go inside a `Column` inside `SingleChildScrollView`.

**Step 5 - Student Name field with validator**

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Enter student name';
  }
  return null;
}
```

**Step 6 - Email field**

`keyboardType: TextInputType.emailAddress`

**Step 7 - Password field**

`obscureText: true`

**Step 8 - Submit button**

```dart
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );
    }
  },
  child: const Text('Submit'),
)
```

**Step 9 - Run and test**

1. Click **Submit** with an empty name -> red error `Enter student name`.
2. Fill name / email / password -> click **Submit** -> SnackBar at the bottom.

## Files

```text
experiment_3/
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration Form',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const StudentRegistrationPage(),
    );
  }
}

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({super.key});

  @override
  State<StudentRegistrationPage> createState() =>
      _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.school, size: 80),

              const SizedBox(height: 15),

              const Text(
                'Student Registration Form',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // -----------------------------------
              // STUDENT NAME
              // -----------------------------------
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter student name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // -----------------------------------
              // EMAIL
              // -----------------------------------
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),

                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // -----------------------------------
              // PASSWORD
              // -----------------------------------
              TextFormField(
                obscureText: true,

                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),

              const SizedBox(height: 30),

              // -----------------------------------
              // SUBMIT BUTTON
              // -----------------------------------
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully'),
                      ),
                    );
                  }
                },

                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### `test/widget_test.dart`
```dart
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
```

### `pubspec.yaml`
```yaml
name: experiment_3
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

**Filled form + SnackBar `Form submitted successfully`**

![Filled form + SnackBar `Form submitted successfully`](output/1_form_submitted.png)

- Screen titled **Student Registration** with a school icon and `Student Registration Form` heading.
- Three outlined fields: **Student Name** (person icon), **Email** (mail icon), **Password** (lock icon, dots hidden).
- Submit with the name empty -> red text **`Enter student name`** under the field.
- Submit with a name filled -> SnackBar at the bottom: **`Form submitted successfully`**.

## Result
An interactive student registration form was developed successfully. The form accepts student name, email, and password input from the user. Validation displays a message when the required student name is not entered. The Submit button validates the form and displays a success message using SnackBar.
