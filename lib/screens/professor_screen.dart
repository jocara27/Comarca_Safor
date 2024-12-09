import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class ProfessorScreen extends StatefulWidget {
  @override
  _ProfessorScreenState createState() => _ProfessorScreenState();
}

class _ProfessorScreenState extends State<ProfessorScreen> {
  late Map<String, dynamic> _users;
  late List<dynamic> _students;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final file = File('assets/users.json');
      final String response = await file.readAsString();
      setState(() {
        _users = json.decode(response);
        _students =
            _users['users'].where((user) => user['role'] == 'alumno').toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error carregant el fitxer d\'usuaris')),
      );
    }
  }

  Future<void> _saveUsers() async {
    try {
      final file = File('assets/users.json');
      await file.writeAsString(json.encode(_users));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: No s\'ha pogut guardar el fitxer')),
      );
    }
  }

  void _deleteStudent(int index) {
    setState(() {
      _users['users'].remove(_students[index]);
      _students.removeAt(index);
    });
    _saveUsers();
  }

  void _addStudent(String name) {
    setState(() {
      final newStudent = {"role": "alumno", "name": name, "password": "4567"};
      _users['users'].add(newStudent);
      _students.add(newStudent);
    });
    _saveUsers();
  }

  void _showAddStudentDialog() {
    final TextEditingController _newStudentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Afegir Alumne'),
        content: TextField(
          controller: _newStudentController,
          decoration: InputDecoration(hintText: 'Nom de l\'alumne'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel·lar'),
          ),
          TextButton(
            onPressed: () {
              if (_newStudentController.text.isNotEmpty) {
                _addStudent(_newStudentController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Afegir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestió d'Alumnes"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Color(0xFFF7F3DF), // Color de fons canviat
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_students[index]['name']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteStudent(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showAddStudentDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text('Afegir Alumne'),
            ),
          ],
        ),
      ),
    );
  }
}
