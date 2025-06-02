import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hivelrn/db/data_modal.dart';
import 'package:hivelrn/db/functions/db_functions.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key}); // Fixed: Using super.key pattern

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weekController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

@override
  void initState() {
    super.initState();

    _nameController.addListener(() {
      _validateLettersOnly(_nameController, 'Please enter letters');
    });

    _genderController.addListener(() {
      _validateLettersOnly(_genderController, 'Please enter letters');
    });

    _ageController.addListener(() {
      _validateNumbersOnly(_ageController, 'Please enter numbers');
    });

    _weekController.addListener(() {
      _validateNumbersOnly(_weekController, 'Please enter numbers');
    });
  }

  void _validateLettersOnly(TextEditingController controller, String message) {
    final text = controller.text;
    if (text.isNotEmpty && !RegExp(r'^[a-zA-Z\s]*$').hasMatch(text)) {
      controller.text = text.substring(0, text.length - 1);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      _showSnackBar(message);
    }
  }

  void _validateNumbersOnly(TextEditingController controller, String message) {
    final text = controller.text;
    if (text.isNotEmpty && !RegExp(r'^[0-9]*$').hasMatch(text)) {
      controller.text = text.substring(0, text.length - 1);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      _showSnackBar(message);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weekController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Age',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _weekController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Week',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _genderController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Gender',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _handleAddStudent,
            icon: const Icon(Icons.add),
            label: const Text('Add Student'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAddStudent() async {
    if (!mounted) return; // Safety check for widget state

    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final week = _weekController.text.trim();
    final gender = _genderController.text.trim();

    if (name.isEmpty || age.isEmpty || week.isEmpty || gender.isEmpty) {
      _showSnackBar('Please fill all fields');
      return;
    }

    final student = StudentModal(
      name: name,
      age: age,
      week: week,
      gender: gender,
    );

    try {
      await addStudent(student);
      _showSnackBar('Student added successfully');
      _clearFields();
    } catch (e) {
      _showSnackBar('Error adding student: ${e.toString()}');
    }
  }
  void _clearFields() {
    _nameController.clear();
    _ageController.clear();
    _weekController.clear();
    _genderController.clear();
  }
}
