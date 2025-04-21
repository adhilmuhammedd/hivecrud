import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivelrn/db/data_modal.dart';
import 'package:hivelrn/screens/home/homescreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(StudentModalAdapter().typeId))
  {
    Hive.registerAdapter(StudentModalAdapter());
  }
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
  home: Addall(),
  ));
}

extension on HiveInterface {
  initFlutter() {}
}