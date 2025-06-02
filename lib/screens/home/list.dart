import 'package:flutter/material.dart';
import 'package:hivelrn/db/functions/db_functions.dart';
import 'package:hivelrn/screens/home/studentpage.dart';
import '../../db/data_modal.dart';
import 'package:flutter/services.dart';

class ListStudentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModal> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Studentpage(
                      student: studentList[index],
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text(data.name),
              subtitle: Text(data.age),
              trailing: SizedBox(
                width: 110,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showEditStudentDialog(context, data, index);
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        if (data.id != null) {
                          deleteStudent(data.id!);
                        } else {
                          print('Student id is null.');
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}

/// Edit dialog function
Future<void> showEditStudentDialog(
    BuildContext context, StudentModal student, int index) async {
  final nameController = TextEditingController(text: student.name);
  final ageController = TextEditingController(text: student.age);
  final weekController = TextEditingController(text: student.week);
  final genderController = TextEditingController(text: student.gender);

  void showValidationMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void validateLettersOnly(TextEditingController controller, String message) {
    final text = controller.text;
    if (text.isNotEmpty && !RegExp(r'^[a-zA-Z\s]*$').hasMatch(text)) {
      controller.text = text.substring(0, text.length - 1);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      showValidationMessage(message);
    }
  }

  void validateNumbersOnly(TextEditingController controller, String message) {
    final text = controller.text;
    if (text.isNotEmpty && !RegExp(r'^[0-9]*$').hasMatch(text)) {
      controller.text = text.substring(0, text.length - 1);
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
      showValidationMessage(message);
    }
  }

  // Add listeners
  nameController.addListener(() {
    validateLettersOnly(nameController, 'Please enter letters');
  });
  genderController.addListener(() {
    validateLettersOnly(genderController, 'Please enter letters');
  });
  ageController.addListener(() {
    validateNumbersOnly(ageController, 'Please enter numbers');
  });
  weekController.addListener(() {
    validateNumbersOnly(weekController, 'Please enter numbers');
  });

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
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(hintText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: weekController,
                decoration: const InputDecoration(hintText: 'Week'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: genderController,
                decoration: const InputDecoration(hintText: 'Gender'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty ||
                  ageController.text.trim().isEmpty ||
                  weekController.text.trim().isEmpty ||
                  genderController.text.trim().isEmpty) {
                showValidationMessage('Please fill all the fields');
                return;
              }

              student.name = nameController.text.trim();
              student.age = ageController.text.trim();
              student.week = weekController.text.trim();
              student.gender = genderController.text.trim();

              await updateStudent(student.id!, student);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
