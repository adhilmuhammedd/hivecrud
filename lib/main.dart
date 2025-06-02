import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivelrn/db/data_modal.dart'; // Update with your correct import
import 'package:hivelrn/screens/home/homescreen.dart'; // Your app's starting screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(StudentModalAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Addall(), // Your home widget
      debugShowCheckedModeBanner: false,
    );
  }
}
