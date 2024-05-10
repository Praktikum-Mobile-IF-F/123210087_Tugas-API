import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/loginPage.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _DoBController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
            TextFormField(
              controller: _DoBController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
            ),

            SizedBox(height: 20.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                if (!_DoBController.text.isEmpty &&
                    !_emailController.text.isEmpty &&
                    !_passwordController.text.isEmpty) {
                  // Simpan data pengguna ke SharedPreferences
                  SharedPreferences logindata =
                  await SharedPreferences.getInstance();
                  logindata.setString(
                      'email', _emailController.text);
                  logindata.setString(
                      'password', _passwordController.text);
                  logindata.setString(
                      'dob', _DoBController.text);

                  // Simulate loading state
                  setState(() {
                    _isLoading = true;
                  });

                  // Simulate delay for 2 seconds
                  await Future.delayed(Duration(seconds: 2));

                  // Setelah proses registrasi selesai, kembali ke halaman sebelumnya
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  const snackBar = SnackBar(
                    content: Text('Account Created'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  print('Email, Password, Date of Birth is empty!');
                  const snackBar = SnackBar(
                    content:
                    Text('Email, Password, Date of Birth is empty!'),
                    duration: Duration(seconds: 1),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                setState(() {
                  _isLoading = true;
                });

                // Simulate delay for 2 seconds
                await Future.delayed(Duration(seconds: 2));

                // Simulate finish loading state
                setState(() {
                  _isLoading = false;
                });
              },
              child: Text('Register'),
            ),

            //Jika sudah memiliki akun
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Already have an account? Click here!'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _DoBController.text) {
      setState(() {
        _DoBController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}
