import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_api/mmo_list.dart';

class MMOGamesListPage extends StatefulWidget {
  @override
  _MMOGamesListPageState createState() => _MMOGamesListPageState();
}

class _MMOGamesListPageState extends State<MMOGamesListPage> {
  List<mmoGamesList>? games = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('https://www.mmobomb.com/api1/games?platform=pc'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        games = responseData.map((json) => mmoGamesList.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MMO Games List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MMO Games List",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: games?.length ?? 0,
                itemBuilder: (context, index) {
                  final game = games![index];
                  return ListTile(
                    leading: Image.network(
                      game.thumbnail ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      game.title ?? '',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(game.shortDescription ?? ''),
                    onTap: () {
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
