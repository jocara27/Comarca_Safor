import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class MapScreenAlumno extends StatefulWidget {
  final String alumne; // Nom de l'alumne

  MapScreenAlumno({required this.alumne});

  @override
  _MapScreenAlumnoState createState() => _MapScreenAlumnoState();
}

class _MapScreenAlumnoState extends State<MapScreenAlumno> {
  late Map<String, dynamic> estatTemes;
  late Map<String, dynamic> estatAlumnes;
  String? imageToShow; // Imatge de detall del tema seleccionat
  String? bloqueigImatge; // Imatge de bloqueig/desbloqueig

  // Configuracions de posicionament i mida per a cada tema
  final Map<String, Map<String, dynamic>> bloqueigConfiguracio = {
    "Tema 1": {"left": 1350.0, "top": 130.0, "width": 780.0, "height": 780.0},
    "Tema 2": {"left": 1350.0, "top": 130.0, "width": 780.0, "height": 780.0},
    "Tema 3": {"left": 30.0, "top": 400.0, "width": 300.0, "height": 300.0},
    "Tema 4": {"left": 70.0, "top": 250.0, "width": 450.0, "height": 450.0},
    "Tema 5": {"left": 100.0, "top": 500.0, "width": 400.0, "height": 400.0},
    "Tema 6": {"left": 1500.0, "top": 300.0, "width": 400.0, "height": 400.0},
    "Tema 7": {"left": 80.0, "top": 220.0, "width": 340.0, "height": 340.0},
    "Tema 8": {"left": 120.0, "top": 270.0, "width": 400.0, "height": 400.0},
    "Tema 9": {"left": 1320.0, "top": 60.0, "width": 780.0, "height": 780.0},
    "Tema 10": {"left": 1350.0, "top": 130.0, "width": 780.0, "height": 780.0},
  };

  @override
  void initState() {
    super.initState();
    _loadEstatTemes();
    _loadEstatAlumnes();
  }

  Future<void> _loadEstatTemes() async {
    try {
      final file = File('assets/estat_temes.json');
      final String response = await file.readAsString();
      setState(() {
        estatTemes = json.decode(response);
      });
    } catch (e) {
      print('Error carregant estat_temes.json: $e');
      estatTemes = {};
    }
  }

  Future<void> _loadEstatAlumnes() async {
    try {
      final file = File('assets/estat_alumnes.json');
      final String response = await file.readAsString();
      setState(() {
        estatAlumnes = json.decode(response);
      });
    } catch (e) {
      print('Error carregant estat_alumnes.json: $e');
      estatAlumnes = {};
    }
  }

  void _showImage(String tema) {
    final String estat = estatAlumnes[tema]?[widget.alumne] ?? "No entregat";

    // Assignar la imatge segons l'estat
    setState(() {
      switch (estat) {
        case "Entregat a temps":
          imageToShow = "assets/Imatge_Entregat$tema.png";
          break;
        case "Entregat tard":
          imageToShow = "assets/Imatge_Entregat_Tard$tema.png";
          break;
        default:
          imageToShow = "assets/Imatge_No_Entregat$tema.png";
      }

      // Imatge de bloqueig o desbloqueig
      bloqueigImatge =
          (estat == "No entregat") ? "Bloquejat_$tema" : "Desbloquejat_$tema";
    });
  }

  void _hideImage() {
    setState(() {
      imageToShow = null; // Amagar la imatge principal
      bloqueigImatge = null; // Amagar la imatge de bloqueig/desbloqueig
    });
  }

  @override
  Widget build(BuildContext context) {
    if (estatTemes.isEmpty || estatAlumnes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Mapa de l'Alumne"),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Color(0xFFF7F3DF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    List<Widget> positionedCartells = [];

    // Exemple de cartells
    if (estatTemes["Tema 1"] == false) {
      positionedCartells.add(
        Positioned(
          left: 730.0,
          top: 440.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 1"),
            child: Image.asset(
              'assets/cartell1.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }
    if (estatTemes["Tema 2"] == false) {
      positionedCartells.add(
        Positioned(
          left: 600.0,
          top: 650.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 2"),
            child: Image.asset(
              'assets/cartell2.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 3
    if (estatTemes["Tema 3"] == false) {
      positionedCartells.add(
        Positioned(
          left: 765.0,
          top: 583.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 3"),
            child: Image.asset(
              'assets/cartell3.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 4
    if (estatTemes["Tema 4"] == false) {
      positionedCartells.add(
        Positioned(
          left: 740.0,
          top: 518.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 4"),
            child: Image.asset(
              'assets/cartell4.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 5
    if (estatTemes["Tema 5"] == false) {
      positionedCartells.add(
        Positioned(
          left: 890.0,
          top: 560.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 5"),
            child: Image.asset(
              'assets/cartell5.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }
    // Cartell 8
    if (estatTemes["Tema 8"] == false) {
      positionedCartells.add(
        Positioned(
          left: 600.0,
          top: 150.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 8"),
            child: Image.asset(
              'assets/cartell8.png',
              width: 120.0,
              height: 120.0,
            ),
          ),
        ),
      );
    }

    // Cartell 6
    if (estatTemes["Tema 6"] == false) {
      positionedCartells.add(
        Positioned(
          left: 815.0,
          top: 527.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 6"),
            child: Image.asset(
              'assets/cartell6.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 7
    if (estatTemes["Tema 7"] == false) {
      positionedCartells.add(
        Positioned(
          left: 820.0,
          top: 400.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 7"),
            child: Image.asset(
              'assets/cartell7.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 9
    if (estatTemes["Tema 9"] == false) {
      positionedCartells.add(
        Positioned(
          left: 850.0,
          top: 670.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 9"),
            child: Image.asset(
              'assets/cartell9.png',
              width: 120.0,
              height: 120.0,
            ),
          ),
        ),
      );
    }

    // Cartell 10
    if (estatTemes["Tema 10"] == false) {
      positionedCartells.add(
        Positioned(
          left: 610.0,
          top: 360.0,
          child: GestureDetector(
            onTap: () => _showImage("Tema 10"),
            child: Image.asset(
              'assets/cartell10.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de l'Alumne"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color(0xFFF7F3DF),
      body: Stack(
        children: [
          // Posits ajustables
          Positioned(
            left: -300,
            top: 10,
            child: Image.asset(
              'assets/posits_alumnes.png',
              width: 1000,
              height: 1000,
            ),
          ),
          // Imatge del mapa ajustable
          Positioned(
            left: 150,
            top: -50,
            child: Image.asset(
              'assets/Mapa.png',
              width: 1150,
              height: 1150,
            ),
          ),
          ...positionedCartells,
          // Mostrar la imatge si està seleccionada
          if (imageToShow != null)
            Positioned(
              right: 250,
              top: 100,
              child: GestureDetector(
                onTap: _hideImage,
                child: Image.asset(
                  imageToShow!,
                  width: 800,
                  height: 800,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          // Mostrar la imatge de bloqueig/desbloqueig
          if (bloqueigImatge != null)
            Positioned(
              left: bloqueigConfiguracio[bloqueigImatge!.split('_').last]![
                  "left"],
              top:
                  bloqueigConfiguracio[bloqueigImatge!.split('_').last]!["top"],
              child: GestureDetector(
                onTap: _hideImage,
                child: Image.asset(
                  "assets/$bloqueigImatge.png",
                  width: bloqueigConfiguracio[bloqueigImatge!.split('_').last]![
                      "width"],
                  height: bloqueigConfiguracio[
                      bloqueigImatge!.split('_').last]!["height"],
                  fit: BoxFit.contain,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
