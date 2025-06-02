import 'package:flutter/material.dart';
import 'package:hivelrn/db/functions/db_functions.dart';
import 'package:hivelrn/screens/home/add.dart';
import 'package:hivelrn/screens/home/list.dart';

class Addall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.blue),
        title: const Center(child: Text('Add Student')),
      ),
      body: SafeArea(
          child: Column(
            children: [
              const AddStudentWidget(),
              Expanded(child: ListStudentWidget()),
            ],
          ),
        ),
    );
  }
}