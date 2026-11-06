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
      title: 'Flutter Media Gallery',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MediaHomePage(),
    );
  }
}

class MediaHomePage extends StatelessWidget {
  const MediaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Media Gallery'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Flutter Image',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Single image from assets
            Image.asset('assets/images/flutter.jpeg', height: 200),
            const SizedBox(height: 30),

            const Text(
              'Image Gallery',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Image gallery: 2 columns
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Image.asset('assets/images/flutter.jpeg'),
                Image.asset('assets/images/flutter.jpeg'),
                Image.asset('assets/images/flutter.jpeg'),
                Image.asset('assets/images/flutter.jpeg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
