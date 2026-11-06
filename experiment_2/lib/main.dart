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
      title: 'Responsive UI Lab',

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

      home: const ResponsiveHomePage(),
    );
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Student Dashboard'),
        centerTitle: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // ------------------------------------------
          // MOBILE LAYOUT
          // ------------------------------------------
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          }

          // ------------------------------------------
          // DESKTOP / TABLET LAYOUT
          // ------------------------------------------
          return _buildDesktopLayout();
        },
      ),
    );
  }

  // ==================================================
  // MOBILE LAYOUT
  // ==================================================

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          // Header
          _buildHeader(),

          const SizedBox(height: 20),

          // Student Card
          Card(
            elevation: 4,

            child: ListTile(
              leading: const Icon(Icons.person, size: 40),

              title: const Text(
                'Student',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('Student Profile and Information'),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),

          const SizedBox(height: 12),

          // Courses Card
          Card(
            elevation: 4,

            child: ListTile(
              leading: const Icon(Icons.book, size: 40),

              title: const Text(
                'Courses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('View Registered Courses'),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),

          const SizedBox(height: 12),

          // Attendance Card
          Card(
            elevation: 4,

            child: ListTile(
              leading: const Icon(Icons.check_circle, size: 40),

              title: const Text(
                'Attendance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('View Attendance Details'),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),

          const SizedBox(height: 12),

          // Results Card
          Card(
            elevation: 4,

            child: ListTile(
              leading: const Icon(Icons.assessment, size: 40),

              title: const Text(
                'Results',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('View Academic Results'),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  // ==================================================
  // DESKTOP / TABLET LAYOUT
  // ==================================================

  Widget _buildDesktopLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),

      child: Column(
        children: [
          // Header
          _buildHeader(),

          const SizedBox(height: 30),

          // First Row
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.person,
                  title: 'Students',
                  subtitle: 'Student Profile and Information',
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.book,
                  title: 'Courses',
                  subtitle: 'View Registered Courses',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Second Row
          Row(
            children: [
              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.check_circle,
                  title: 'Attendance',
                  subtitle: 'View Attendance Details',
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildDashboardCard(
                  icon: Icons.assessment,
                  title: 'Results',
                  subtitle: 'View Academic Results',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================================================
  // HEADER
  // ==================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),

      child: const Column(
        children: [
          Icon(Icons.school, size: 60),

          SizedBox(height: 10),

          Text(
            'Student Dashboard',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),

          Text(
            'Building Applications using Flutter',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==================================================
  // DASHBOARD CARD
  // ==================================================

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 5,

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Icon(icon, size: 60),

            const SizedBox(height: 15),

            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(subtitle, textAlign: TextAlign.center),

            const SizedBox(height: 15),

            ElevatedButton(onPressed: () {}, child: const Text('View')),
          ],
        ),
      ),
    );
  }
}
