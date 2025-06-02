import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data_modal.dart';

ValueNotifier<List<StudentModal>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModal student) async {
  final box = await Hive.openBox<StudentModal>('student_db');
  int key = await box.add(student);
  student.id = key;
  await box.put(key, student); // Update object with key as id
  getAllStudents();
}

Future<void> getAllStudents() async {
  final box = await Hive.openBox<StudentModal>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(box.values.toList());
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int key) async {
  final box = await Hive.openBox<StudentModal>('student_db');
  await box.delete(key);
  getAllStudents();
}

Future<void> updateStudent(int key, StudentModal student) async {
  final box = await Hive.openBox<StudentModal>('student_db');
  await box.put(key, student);
  getAllStudents();
}
