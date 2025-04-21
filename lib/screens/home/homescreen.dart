import 'package:flutter/material.dart';
import 'package:hivelrn/db/functions/db_functions.dart';
import 'package:hivelrn/screens/home/add.dart';
import 'package:hivelrn/screens/home/list.dart';

class Addall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.blue),
        title: Center(child: Text('add student')),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AddStudentWidget(),
            Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
    );
  }
}
