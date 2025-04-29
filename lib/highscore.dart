import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatefulWidget {
  const HighScore({super.key});

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  String _topUser = "No user";
  int _topPoint = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _topUser = prefs.getString('top_user') ?? "No user";
      _topPoint = prefs.getInt('top_point') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Score")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Top User: $_topUser", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text("Top Score: $_topPoint", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
