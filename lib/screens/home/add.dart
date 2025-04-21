import 'package:flutter/material.dart';
import 'package:hivelrn/db/data_modal.dart';
import 'package:hivelrn/db/functions/db_functions.dart';

class AddStudentWidget extends StatelessWidget {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weekController = TextEditingController();
  final _genderController = TextEditingController();

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
              hintText: 'name',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'age',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _weekController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'week',
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _genderController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'gender',
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              onAddStudentButtonCliked();
              print('added to box');
            },
            icon: const Icon(Icons.add),
            label: const Text('add student'),
          ),
        ],
      ),
    );
  }

  Future<void> onAddStudentButtonCliked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _week = _weekController.text.trim();
    final _gender = _genderController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _week.isEmpty || _gender.isEmpty) {
      return;
    }

    final _student = StudentModal(
      name: _name,
      age: _age,
      week: _week,
      gender: _gender,
    );

    addStudent(_student);

    _nameController.clear();
    _ageController.clear();
    _weekController.clear();
    _genderController.clear();
  }

  Future<void> editDetails(BuildContext context, StudentModal student, int index) async {
    _nameController.text = student.name;
    _ageController.text = student.age;
    _weekController.text = student.week;
    _genderController.text = student.gender;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Student"),
          content: SizedBox(
            height: 250,
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'name'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(hintText: 'age'),
                ),
                TextField(
                  controller: _weekController,
                  decoration: const InputDecoration(hintText: 'week'),
                ),
                TextField(
                  controller: _genderController,
                  decoration: const InputDecoration(hintText: 'gender'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _nameController.clear();
                _ageController.clear();
                _weekController.clear();
                _genderController.clear();
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                student.name = _nameController.text;
                student.age = _ageController.text;
                student.week = _weekController.text;
                student.gender = _genderController.text;

                await updateStudent(index, student);

                _nameController.clear();
                _ageController.clear();
                _weekController.clear();
                _genderController.clear();

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
