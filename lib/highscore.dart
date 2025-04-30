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
    List<String> highScores = prefs.getStringList('high_scores') ?? [];
    // setState(() {
    //   _topUser = prefs.getString('top_user') ?? "No user";
    //   _topPoint = prefs.getInt('top_point') ?? 0;

    // });
  }

  Future<List<String>> getHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('high_scores') ?? [];
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("High Score")),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Top User: $_topUser", style: TextStyle(fontSize: 24)),
  //           SizedBox(height: 10),
  //           Text("Top Score: $_topPoint", style: TextStyle(fontSize: 24)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layar High Scores")),
      body: FutureBuilder<List<String>>(
        future: getHighScores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada highscore yang tersedia."));
          }

          final scores = snapshot.data!;
          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final parts = scores[index].split(':');
              return ListTile(title: Text(parts[0]), trailing: Text(parts[1]));
            },
          );
        },
      ),
    );
  }
}
