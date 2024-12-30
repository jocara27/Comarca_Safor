import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'professor_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _selectedTrimestre = "";
  List<String> _temes = [];
  final Map<String, List<String>> _temesPerTrimestre = {
    "Primer Trimestre": ["Tema 1", "Tema 2", "Tema 3", "Tema 4"],
    "Segon Trimestre": ["Tema 5", "Tema 6", "Tema 7", "Tema 8"],
    "Tercer Trimestre": ["Tema 9", "Tema 10"],
  };

  // Estat dels temes (bloquejat/desbloquejat)
  Map<String, bool> _temaBloquejat = {};

  // Estat dels alumnes per tema
  Map<String, Map<String, String>> _estatAlumnes = {};
  final String _jsonPathTemes = 'assets/estat_temes.json';
  final String _jsonPathAlumnes = 'assets/estat_alumnes.json';
  final String _jsonPathUsers = 'assets/users.json';

  // Llista d'alumnes des del fitxer users.json
  List<String> _alumnesReals = [];

  @override
  void initState() {
    super.initState();
    _loadEstat();
  }

  // Carrega l'estat dels temes, alumnes i usuaris des del fitxer JSON
  Future<void> _loadEstat() async {
    try {
      // Carrega la llista d'alumnes des del JSON
      final fileUsers = File(_jsonPathUsers);
      if (await fileUsers.exists()) {
        final contentUsers = await fileUsers.readAsString();
        final data = json.decode(contentUsers) as Map<String, dynamic>;
        setState(() {
          _alumnesReals = (data['users'] as List<dynamic>)
              .where((user) => user['role'] == 'alumno')
              .map((user) => user['name'] as String)
              .toList();
        });
      }

      // Estat dels temes
      final fileTemes = File(_jsonPathTemes);
      if (await fileTemes.exists()) {
        final contentTemes = await fileTemes.readAsString();
        setState(() {
          _temaBloquejat = Map<String, bool>.from(json.decode(contentTemes));
        });
      } else {
        _temaBloquejat = {
          for (var tema in _temesPerTrimestre.values.expand((x) => x))
            tema: false
        };
        await _saveEstatTemes();
      }

      // Estat dels alumnes
      final fileAlumnes = File(_jsonPathAlumnes);
      if (await fileAlumnes.exists()) {
        final contentAlumnes = await fileAlumnes.readAsString();
        setState(() {
          _estatAlumnes = Map<String, Map<String, String>>.from(
            json.decode(contentAlumnes).map(
                  (k, v) => MapEntry(k, Map<String, String>.from(v)),
                ),
          );
        });
      } else {
        _temesPerTrimestre.values.expand((x) => x).forEach((tema) {
          _estatAlumnes[tema] = {
            for (var alumne in _alumnesReals) alumne: 'No entregat'
          };
        });
        await _saveEstatAlumnes();
      }
    } catch (e) {
      print("Error carregant l'estat: $e");
    }
  }

  // Desa l'estat dels temes al fitxer JSON
  Future<void> _saveEstatTemes() async {
    try {
      final file = File(_jsonPathTemes);
      await file.writeAsString(json.encode(_temaBloquejat));
    } catch (e) {
      print("Error guardant l'estat dels temes: $e");
    }
  }

  // Desa l'estat dels alumnes al fitxer JSON
  Future<void> _saveEstatAlumnes() async {
    try {
      final file = File(_jsonPathAlumnes);
      await file.writeAsString(json.encode(_estatAlumnes));
    } catch (e) {
      print("Error guardant l'estat dels alumnes: $e");
    }
  }

  // Bloqueja o desbloqueja un tema
  void _toggleTema(String tema) async {
    setState(() {
      _temaBloquejat[tema] = !_temaBloquejat[tema]!;
    });
    await _saveEstatTemes();
  }

  // Mètode per mostrar els temes d'un trimestre seleccionat
  void _showTemes(String trimestre) {
    setState(() {
      _selectedTrimestre = trimestre;
      _temes = _temesPerTrimestre[trimestre]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa Interactiu"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color(0xFFF7F3DF),
      body: Stack(
        children: [
          // Imatge del mapa
          Center(
            child: Image.asset(
              'assets/mapa_pobles.png',
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Possit 1 (Primer Trimestre)
          Positioned(
            left: 180,
            top: 80,
            child: GestureDetector(
              onTap: () => _showTemes("Primer Trimestre"),
              child: Image.asset(
                'assets/primer_trimestre.png',
                width: 230,
                height: 230,
              ),
            ),
          ),
          // Possit 2 (Segon Trimestre)
          Positioned(
            left: 180,
            top: 360,
            child: GestureDetector(
              onTap: () => _showTemes("Segon Trimestre"),
              child: Image.asset(
                'assets/segon_trimestre.png',
                width: 230,
                height: 230,
              ),
            ),
          ),
          // Possit 3 (Tercer Trimestre)
          Positioned(
            left: 180,
            top: 650,
            child: GestureDetector(
              onTap: () => _showTemes("Tercer Trimestre"),
              child: Image.asset(
                'assets/tercer_trimestre.png',
                width: 230,
                height: 230,
              ),
            ),
          ),
          // Menú lateral (dreta)
          if (_selectedTrimestre.isNotEmpty)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 250,
                color: Colors.green[100],
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedTrimestre,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    ..._temes.map((tema) {
                      return ListTile(
                        title: Text(
                          tema,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[900],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            _temaBloquejat[tema]!
                                ? Icons.lock
                                : Icons.lock_open,
                            color: _temaBloquejat[tema]!
                                ? Colors.red
                                : Colors.green,
                          ),
                          onPressed: () => _toggleTema(tema),
                        ),
                        onTap: () {
                          _showAlumnes(context, tema);
                        },
                      );
                    }).toList(),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTrimestre = "";
                          _temes = [];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text("Tancar"),
                    ),
                  ],
                ),
              ),
            ),
          // Botó per tornar
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text('Tornar'),
            ),
          ),
          // Botó per anar als alumnes
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfessorScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text('Alumnes'),
            ),
          ),
        ],
      ),
    );
  }

  // Canvia l'estat d'un alumne
  void _canviarEstat(String tema, String alumne, String estat) async {
    setState(() {
      _estatAlumnes[tema]![alumne] = estat;
    });
    await _saveEstatAlumnes();
  }

  void _showAlumnes(BuildContext context, String tema) {
    if (_estatAlumnes[tema] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No hi ha alumnes per a aquest tema.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Alumnes de $tema"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _estatAlumnes[tema]!.entries.map((entry) {
              String alumne = entry.key;
              String estat = entry.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(alumne),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            _canviarEstat(tema, alumne, "Entregat a temps"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: estat == "Entregat a temps"
                              ? Colors.green
                              : Colors.grey[300],
                        ),
                        child: Text("A temps"),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () =>
                            _canviarEstat(tema, alumne, "Entregat tard"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: estat == "Entregat tard"
                              ? Colors.blue
                              : Colors.grey[300],
                        ),
                        child: Text("Tard"),
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () =>
                            _canviarEstat(tema, alumne, "No entregat"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: estat == "No entregat"
                              ? Colors.red
                              : Colors.grey[300],
                        ),
                        child: Text("No entregat"),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Tancar'),
          ),
        ],
      ),
    );
  }
}
