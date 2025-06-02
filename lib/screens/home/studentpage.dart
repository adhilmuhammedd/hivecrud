import 'package:flutter/material.dart';
import '../../db/data_modal.dart';
import '../home/list.dart'; // For showEditStudentDialog

class Studentpage extends StatefulWidget {
  final StudentModal student;

  const Studentpage({super.key, required this.student});

  @override
  State<Studentpage> createState() => _StudentpageState();
}

class _StudentpageState extends State<Studentpage> {
  late StudentModal student;

  @override
  void initState() {
    super.initState();
    student = widget.student;
  }

  void refreshData() {
    setState(() {
      // Updates the state with current student info
      // You could re-fetch from Hive if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.blue),
        title: const Center(child: const Text('Student Details')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildInfoCard("Name", student.name),
            buildInfoCard("Age", student.age),
            buildInfoCard("Week", student.week),
            buildInfoCard("Gender", student.gender),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Do you want to edit details?",
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      await showEditStudentDialog(context, student, 0);
                      setState(() {}); // Refresh UI with updated data
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$title: $value",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
