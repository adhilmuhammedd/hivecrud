import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hivelrn/db/functions/db_functions.dart';
import 'package:hivelrn/screens/home/studentpage.dart';
import 'add.dart';
import '../../db/data_modal.dart';

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
                width: 80,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                       AddStudentWidget().editDetails(context, data, index);
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
