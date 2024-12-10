import 'package:flutter/material.dart';

class MapScreenAlumno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de l'Alumne"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color(0xFFF7F3DF), // Color de fons
      body: Stack(
        children: [
          // Imatge dels pos-its (ajustable amb Positioned)
          Positioned(
            left: -300, // Distància des de la part esquerra
            top: 10, // Distància des de la part superior
            child: Image.asset(
              'assets/posits_alumnes.png',
              width: 1000, // Amplada general dels pos-its
              height: 1000, // Alçada general dels pos-its
            ),
          ),
          // Imatge del mapa (ajustable amb Positioned)
          Positioned(
            left: 150, // Distància des de la part esquerra
            top: -50, // Distància des de la part superior
            child: Image.asset(
              'assets/Mapa.png',
              width: 1150, // Amplada general del mapa
              height: 1150, // Alçada general del mapa
            ),
          ),
        ],
      ),
    );
  }
}
