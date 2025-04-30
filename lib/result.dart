import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layar Hasil")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Point anda ...'),
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
