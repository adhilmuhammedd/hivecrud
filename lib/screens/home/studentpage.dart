import 'package:flutter/material.dart';
import 'package:hivelrn/db/data_modal.dart';

class Studentpage extends StatelessWidget {
  StudentModal student;
  Studentpage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: (Colors.blue), title: const Text('student')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(student.name)),
            
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(student.age),),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(student.week),),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(student.gender),),
          ),
        ],
      ),
    );
  }
}
