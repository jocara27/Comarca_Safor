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
      body: Center(
        child: Image.asset(
          'assets/Mapa.png', // Ruta de la imatge dins de la carpeta assets
          fit: BoxFit.cover, // Ajusta la imatge dins de l'espai disponible
        ),
      ),
    );
  }
}
