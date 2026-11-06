import 'dart:convert';
import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(const StateApp());
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiment 7 - State Management & Serialization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StudentStatePage(),
        '/serialized': (context) => const StudentStatePage(initialWithData: true),
      },
    );
  }
}

class StudentStatePage extends StatefulWidget {
  final bool initialWithData;
  const StudentStatePage({super.key, this.initialWithData = false});

  @override
  State<StudentStatePage> createState() => _StudentStatePageState();
}

class _StudentStatePageState extends State<StudentStatePage> {
  final List<Student> _students = [];
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  String _jsonOutput = 'No JSON serialization performed yet.';
  String _deserializedInfo = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialWithData) {
      _loadDefaultSampleData();
    }
  }

  void _loadDefaultSampleData() {
    final s1 = Student(id: 1, name: 'Santhosh V', course: '24CS2016 Flutter Lab');
    final s2 = Student(id: 2, name: 'Adithya R', course: 'Operating Systems');
    final s3 = Student(id: 3, name: 'Praveen K', course: 'Database Systems');
    _students.addAll([s1, s2, s3]);
    _serializeLastStudent();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _addStudent() {
    final name = _nameController.text.trim();
    final course = _courseController.text.trim();
    if (name.isEmpty || course.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter student name and course!')),
      );
      return;
    }

    setState(() {
      final newStudent = Student(
        id: _students.length + 1,
        name: name,
        course: course,
      );
      _students.add(newStudent);
      _nameController.clear();
      _courseController.clear();
      _serializeLastStudent();
    });
  }

  void _serializeLastStudent() {
    if (_students.isEmpty) return;
    final last = _students.last;
    final Map<String, dynamic> data = last.toJson();
    final jsonStr = jsonEncode(data);

    // Demonstrate deserialization back to object
    final Student deserialized = Student.fromJson(jsonDecode(jsonStr));

    setState(() {
      _jsonOutput = jsonStr;
      _deserializedInfo =
          'fromJson(): Student(id: ${deserialized.id}, name: "${deserialized.name}", course: "${deserialized.course}")';
    });
  }

  void _removeStudent(int index) {
    setState(() {
      _students.removeAt(index);
      if (_students.isNotEmpty) {
        _serializeLastStudent();
      } else {
        _jsonOutput = 'List is empty.';
        _deserializedInfo = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management & JSON Serialization'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Column(
                children: [
                  Text(
                    'Student Record Management',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Santhosh V — URK23CS1003',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add New Student (State Mutation)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Student Name',
                        hintText: 'e.g. Santhosh V',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _courseController,
                      decoration: const InputDecoration(
                        labelText: 'Enrolled Course',
                        hintText: 'e.g. 24CS2016 Flutter Lab',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _addStudent,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Student'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              _loadDefaultSampleData();
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Load Demo Data'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.data_object, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'JSON Serialization (toJson & fromJson)',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.teal.shade200),
                      ),
                      child: SelectableText(
                        _jsonOutput,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (_deserializedInfo.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        _deserializedInfo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Enrolled Students List (${_students.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _students.isEmpty
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(
                        child: Text(
                          'No students added yet. Add a student above or load demo data.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            child: Text('${student.id}'),
                          ),
                          title: Text(
                            student.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Course: ${student.course}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _removeStudent(index),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
