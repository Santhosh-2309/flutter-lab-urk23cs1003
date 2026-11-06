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
      title: 'Widget Layout Lab',

      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),

      home: const StudentDashboard(),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Dashboard'), centerTitle: true),

      body: Column(
        children: [
          // ------------------------------------------------
          // CONTAINER
          // ------------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),

            child: const Column(
              children: [
                Icon(Icons.account_circle, size: 70),

                SizedBox(height: 10),

                Text(
                  'Student Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 5),

                Text(
                  'Computer Science and Engineering',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // ------------------------------------------------
          // ROW
          // ------------------------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Column(children: [Icon(Icons.home), Text('Home')]),

              Column(children: [Icon(Icons.person), Text('Profile')]),

              Column(children: [Icon(Icons.settings), Text('Settings')]),
            ],
          ),

          const SizedBox(height: 10),

          // ------------------------------------------------
          // EXPANDED
          // ------------------------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),

              children: [
                // CARD 1
                Card(
                  elevation: 4,

                  child: ListTile(
                    leading: const Icon(Icons.book, size: 35),

                    title: const Text(
                      'Flutter',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: const Text('Mobile Application Development'),

                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),

                // CARD 2
                Card(
                  elevation: 4,

                  child: ListTile(
                    leading: const Icon(Icons.cloud, size: 35),

                    title: const Text(
                      'Cloud Computing',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: const Text('Cloud Infrastructure and Services'),

                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),

                // CARD 3
                Card(
                  elevation: 4,

                  child: ListTile(
                    leading: const Icon(Icons.code, size: 35),

                    title: const Text(
                      'Programming',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: const Text('Programming Fundamentals'),

                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),

                // CARD 4
                Card(
                  elevation: 4,

                  child: ListTile(
                    leading: const Icon(Icons.computer, size: 35),

                    title: const Text(
                      'Artificial Intelligence',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: const Text('AI and Machine Learning'),

                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ------------------------------------------------
      // BOTTOM NAVIGATION
      // ------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
