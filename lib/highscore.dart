import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatefulWidget {
  const HighScore({super.key});

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> {
  Future<List<String>> getHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('high_scores') ?? [];
  }

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
              return ListTile(
                title: Row(
                  children: [
                    Text('${index + 1}. '),
                    Expanded(flex: 2, child: Text(parts[0])),
                    Spacer(),
                    Text(parts[1]),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
