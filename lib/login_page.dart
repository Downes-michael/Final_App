import 'package:final_project/ItemListPage.dart';
import 'package:final_project/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String correctUsername = 'admin';
  final String correctPassword = 'Password1';

  void _login() async {
    await _storage.write(key: 'username', value: correctUsername);
    await _storage.write(key: 'password', value: correctPassword);

    String? storedUsername = await _storage.read(key: 'username');
    String? storedPassword = await _storage.read(key: 'password');

    if (storedUsername == _usernameController.text &&
        storedPassword == _passwordController.text) {
      // Login Success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login success'),
        ),
      );
      Navigator.pushReplacement(
        context,
        //go to item list page
        MaterialPageRoute(builder: (context) => ItemListPage()),
      );
    } else {
      // Incorrect credentials
      if (correctUsername != _usernameController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username does not exist'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect password'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downes Login'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                child: Text(
                  'Version: 1.0.0',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                  child: Text('About'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
