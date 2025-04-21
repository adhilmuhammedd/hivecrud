import 'package:hive/hive.dart';
part 'data_modal.g.dart';

@HiveType(typeId: 1)
class StudentModal {

@HiveField(0)
 int? id;

@HiveField(1)  
 String name;

@HiveField(2)
 String age;

@HiveField(3)
 String week;

@HiveField(4)
 String gender;


  StudentModal({required this.name, required this.age,this.id, required this.week, required this.gender});

  static updateStudent(int index, student) {}
}