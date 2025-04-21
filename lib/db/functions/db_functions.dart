import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivelrn/db/data_modal.dart';

ValueNotifier<List<StudentModal>>studentListNotifier =ValueNotifier([]);

Future<void> addStudent(StudentModal value) async{
  final studentDB = await Hive.openBox<StudentModal>('student_db');
  final _id = await studentDB.add(value);
  value.id = _id;
  
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudent()async{
  final studentDB = await Hive.openBox<StudentModal>('student_db');
  studentListNotifier.value.clear();

  studentListNotifier.value.addAll(studentDB.values);
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
 final studentDB = await Hive.openBox<StudentModal>('student_db');
 await studentDB.delete(id);
 getAllStudent();
}

Future<void> updateStudent(int index, StudentModal value) async {
  final studentDB = await Hive.openBox<StudentModal>('student_db');
  await studentDB.putAt(index, value);
  getAllStudent(); 
}
