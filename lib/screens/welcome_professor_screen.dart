import 'package:flutter/material.dart';
import 'map_screen.dart';

class WelcomeProfessorScreen extends StatefulWidget {
  final String name;

  WelcomeProfessorScreen({required this.name});

  @override
  _WelcomeProfessorScreenState createState() => _WelcomeProfessorScreenState();
}

class _WelcomeProfessorScreenState extends State<WelcomeProfessorScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Text(
          'Hola Professora ${widget.name}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      ),
    );
  }
}
