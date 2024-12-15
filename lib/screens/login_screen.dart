import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'welcome_professor_screen.dart';
import 'alumno_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Map<String, dynamic> _users;

  Future<void> _loadUsers() async {
    final String response = await File('assets/users.json').readAsString();
    setState(() {
      _users = json.decode(response);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _login() async {
    await _loadUsers();
    String name = _nameController.text.trim();
    String password = _passwordController.text.trim();

    final user = _users['users'].firstWhere(
      (user) => user['name'] == name && user['password'] == password,
      orElse: () => null,
    );

    if (user != null) {
      if (user['role'] == 'profesor') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeProfessorScreen(name: name),
          ),
        );
      } else if (user['role'] == 'alumno') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlumnoScreen(name: name),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nom d\'usuari o contrasenya incorrectes')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Logo_APP.jpg',
              width: 550,
              height: 550,
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Iniciar Sessió',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contrasenya',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Iniciar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
