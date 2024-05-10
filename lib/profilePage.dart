import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        // alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: _getUserData(), // Mengambil data pengguna dari SharedPreferences
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              // Menampilkan data pengguna pada halaman Detail
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Email: ${snapshot.data!['email']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Password: ${snapshot.data!['password']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Date of Birth: ${snapshot.data!['dob']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dob = prefs.getString('dob') ?? '';
    String email = prefs.getString('email') ?? '';
    String password = prefs.getString('password') ?? '';

    return {
      'dob': dob,
      'email': email,
      'password': password,
    };
  }
}
