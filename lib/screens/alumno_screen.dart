import 'dart:async';
import 'package:flutter/material.dart';
import 'map_screen_alumne.dart';

class AlumnoScreen extends StatefulWidget {
  final String name;

  AlumnoScreen({required this.name});

  @override
  _AlumnoScreenState createState() => _AlumnoScreenState();
}

class _AlumnoScreenState extends State<AlumnoScreen> {
  @override
  void initState() {
    super.initState();

    // Configurem un temporitzador per redirigir a la pantalla map_screen_alumne.dart
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapScreenAlumno()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interfície de l'Alumne"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color(
          0xFFF7F3DF), // Mateix color de fons que la pantalla del professor
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hola Alumne ${widget.name}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
