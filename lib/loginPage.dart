import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/registerPage.dart';
import 'package:tugas_api/homePage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
  }

  void checkIfAlreadyLogin() async {
    SharedPreferences logindata = await SharedPreferences.getInstance();
    bool newuser = (logindata.getBool('login') ?? true);
    print(logindata.getBool("login"));
    print("New user: $newuser");
    print(logindata.getString('email'));

    if (!newuser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? registeredEmail = prefs.getString('email');
    String? registeredPassword = prefs.getString('password');

    if (_emailController.text == registeredEmail && _passwordController.text == registeredPassword) {
      // Data cocok, izinkan pengguna untuk masuk
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Data tidak cocok, tampilkan pesan kesalahan atau lakukan tindakan lainnya
      print('Invalid email or password!');
    }

    // Simulate loading state
    setState(() {
      _isLoading = true;
    });

    // Simulate delay for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Clear text fields
    _emailController.clear();
    _passwordController.clear();

    // Simulate finish loading state
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Don\'t have an account? Click here!'),
            ),
          ],
        ),
      ),
    );
  }
}
