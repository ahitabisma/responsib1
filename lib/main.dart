import 'package:flutter/material.dart';
import 'package:responsi1b/ui/assignment_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLoading();
  }

  void isLoading() {
    setState(() {
      page = const AssignmentPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment Page',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
