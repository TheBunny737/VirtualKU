import 'package:flutter/material.dart';
import 'package:google_map_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Add your login logic here
    if (username == 'admin' && password == '123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void continueAsGuest(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color to green
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to black
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => continueAsGuest(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color to green
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to black
              ),
              child: const Text('Continue as Guest'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
