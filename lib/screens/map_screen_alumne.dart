import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class MapScreenAlumno extends StatefulWidget {
  final String alumne; // Nom de l'alumne

  MapScreenAlumno({required this.alumne});

  @override
  _MapScreenAlumnoState createState() => _MapScreenAlumnoState();
}

class _MapScreenAlumnoState extends State<MapScreenAlumno> {
  late ConfettiController _confettiController; // Controlador de confeti
  late Map<String, dynamic> estatTemes;
  late Map<String, dynamic> estatAlumnes;
  String? imageToShow; // Imatge de detall del tema seleccionat
  String? bloqueigImatge; // Imatge de bloqueig/desbloqueig

  // Configuracions de posicionament i mida per a cada tema
  final Map<String, Map<String, dynamic>> bloqueigConfiguracio = {
    "Tema 1": {"left": 1270.0, "top": 70.0, "width": 920.0, "height": 920.0},
    "Tema 2": {"left": 1300.0, "top": 100.0, "width": 780.0, "height": 780.0},
    "Tema 3": {"left": 1320.0, "top": 60.0, "width": 780.0, "height": 780.0},
    "Tema 4": {"left": 1320.0, "top": 60.0, "width": 780.0, "height": 780.0},
    "Tema 5": {"left": 1250.0, "top": 40.0, "width": 920.0, "height": 920.0},
    "Tema 6": {"left": 1200.0, "top": 70.0, "width": 970.0, "height": 970.0},
    "Tema 7": {"left": 1230.0, "top": 70.0, "width": 920.0, "height": 920.0},
    "Tema 8": {"left": 1320.0, "top": 70.0, "width": 780.0, "height": 780.0},
    "Tema 9": {"left": 1230.0, "top": 40.0, "width": 920.0, "height": 920.0},
    "Tema 10": {"left": 1320.0, "top": 60.0, "width": 780.0, "height": 780.0},
  };
  // Configuració global de posicionament i mida per a la moneda
  final Map<String, dynamic> monedaConfiguracioGlobal = {
    "left": 950.0, // Posició horitzontal
    "top": -10.0, // Posició vertical
    "width": 1000.0, // Amplada
    "height": 1000.0 // Alçada
  };

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 3));
    _loadEstatTemes();
    _loadEstatAlumnes();
  }

  @override
  void dispose() {
    _confettiController
        .dispose(); // Allibera el controlador quan es destrueix el widget
    super.dispose();
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
          // Reprodueix confeti si està entregat a temps i desbloquejat
          if (estat == "Entregat a temps" &&
              bloqueigImatge == "Desbloquejat_$tema") {
            _confettiController.play();
            imageToShow = "assets/Moneda $tema.png"; // Mostra la moneda
          }
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
    if (imageToShow != null &&
        bloqueigImatge != null &&
        imageToShow!.contains("Imatge_Entregat") &&
        bloqueigImatge!.contains("Desbloquejat")) {
      // Obtenir el número del tema des del nom de la imatge
      final tema = imageToShow!.replaceAll(RegExp(r'[^0-9]'), '');

      if (estatAlumnes["Tema $tema"]?[widget.alumne] == "Entregat a temps") {
        // Si l'estat és "Entregat a temps" i "Desbloquejat", mostrar moneda
        setState(() {
          imageToShow = "assets/Moneda $tema.png"; // Imatge de la moneda
          bloqueigImatge = null; // Amagar la imatge de bloqueig
        });
        return; // Evitar amagar immediatament la moneda
      }
    }

    // Amagar les imatges principals si no es mostren condicions especials
    setState(() {
      imageToShow = null;
      bloqueigImatge = null;
    });
  }

  void _onMonedaTap() {
    _confettiController.play(); // Reprodueix el confeti
    // Amaga la moneda després de mostrar el confeti
    setState(() {
      imageToShow = null;
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
          // Mostrar la imatge si està seleccionada i és una moneda
          if (imageToShow != null && imageToShow!.contains("Moneda"))
            Positioned(
              left: monedaConfiguracioGlobal["left"],
              top: monedaConfiguracioGlobal["top"],
              child: GestureDetector(
                onTap: _onMonedaTap,
                child: Image.asset(
                  imageToShow!,
                  width: monedaConfiguracioGlobal["width"],
                  height: monedaConfiguracioGlobal["height"],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          // Mostrar altres imatges si no és una moneda
          if (imageToShow != null && !imageToShow!.contains("Moneda"))
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
          // Afegir el widget de confeti
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive, // Explosiu!
              shouldLoop: false,
              colors: [Colors.red, Colors.blue, Colors.green, Colors.yellow],
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
