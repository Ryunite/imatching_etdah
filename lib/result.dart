import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int playerPoint = 0;
  String playerName = "No User";

  @override
  void initState() {
    super.initState();
    loadScore();
  }

Future<void> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      playerName = prefs.getString('user_id') ?? "No user";
      playerPoint = prefs.getInt('user_point') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layar Hasil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$playerName'),
            Divider(height: 5, color: Colors.transparent),
            Text('Point anda $playerPoint',),
            Divider(height: 10, color: Colors.transparent),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacementNamed(context, "game");
                });
              },
              child: const Text('Ulangi permainan'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pushNamed(context, "highscore");
                });
              },
              child: const Text('Papan peringkat'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacementNamed(context, "main");
                });
              },
              child: const Text('Kembali ke halaman utama'),
            ),
          ],
        ),
      ),
    );
  }
}
