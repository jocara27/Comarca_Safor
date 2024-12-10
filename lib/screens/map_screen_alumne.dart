import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class MapScreenAlumno extends StatefulWidget {
  @override
  _MapScreenAlumnoState createState() => _MapScreenAlumnoState();
}

class _MapScreenAlumnoState extends State<MapScreenAlumno> {
  late Map<String, dynamic> estatTemes;
  String? selectedCartellText; // Text del cartell seleccionat

  @override
  void initState() {
    super.initState();
    _loadEstatTemes();
  }

  Future<void> _loadEstatTemes() async {
    try {
      final file = File('assets/estat_temes.json'); // Ruta del fitxer
      final String response = await file.readAsString();
      setState(() {
        estatTemes = json.decode(response);
      });
    } catch (e) {
      print('Error carregant estat_temes.json: $e');
      estatTemes = {}; // Si hi ha error, inicialitzem com un map buit
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si els temes no estan carregats encara, mostra un carregador
    if (estatTemes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Mapa de l'Alumne"),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Color(0xFFF7F3DF),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Crear llista de Positioned per a cartells
    List<Widget> positionedCartells = [];

    // Cartell 1
    if (estatTemes["Tema 1"] == false) {
      positionedCartells.add(
        Positioned(
          left: 730.0,
          top: 440.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 1";
              });
            },
            child: Image.asset(
              'assets/cartell1.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 2
    if (estatTemes["Tema 2"] == false) {
      positionedCartells.add(
        Positioned(
          left: 600.0,
          top: 650.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 2";
              });
            },
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
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 3";
              });
            },
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
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 4";
              });
            },
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
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 5";
              });
            },
            child: Image.asset(
              'assets/cartell5.png',
              width: 75.0,
              height: 75.0,
            ),
          ),
        ),
      );
    }

    // Cartell 6
    if (estatTemes["Tema 6"] == false) {
      positionedCartells.add(
        Positioned(
          left: 600.0,
          top: 150.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 6";
              });
            },
            child: Image.asset(
              'assets/cartell6.png',
              width: 120.0,
              height: 120.0,
            ),
          ),
        ),
      );
    }

    // Cartell 7
    if (estatTemes["Tema 7"] == false) {
      positionedCartells.add(
        Positioned(
          left: 815.0,
          top: 523.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 7";
              });
            },
            child: Image.asset(
              'assets/cartell7.png',
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
          left: 820.0,
          top: 400.0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 8";
              });
            },
            child: Image.asset(
              'assets/cartell8.png',
              width: 85.0,
              height: 85.0,
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
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 9";
              });
            },
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
            onTap: () {
              setState(() {
                selectedCartellText = "Hola soc cartell 10";
              });
            },
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
      backgroundColor: Color(0xFFF7F3DF), // Color de fons
      body: Stack(
        children: [
          // Posits ajustables
          Positioned(
            left: -300, // Distància des de la part esquerra
            top: 10, // Distància des de la part superior
            child: Image.asset(
              'assets/posits_alumnes.png',
              width: 1000, // Amplada general dels pos-its
              height: 1000, // Alçada general dels pos-its
            ),
          ),
          // Imatge del mapa ajustable
          Positioned(
            left: 150, // Distància des de la part esquerra
            top: -50, // Distància des de la part superior
            child: Image.asset(
              'assets/Mapa.png',
              width: 1150, // Amplada general del mapa
              height: 1150, // Alçada general del mapa
            ),
          ),
          // Afegir els cartells ajustables
          ...positionedCartells,
          // Mostrar el text del cartell seleccionat
          if (selectedCartellText != null)
            Positioned(
              right: 20, // Posició a la dreta
              top: 100, // Posició a la part superior
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  selectedCartellText!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
