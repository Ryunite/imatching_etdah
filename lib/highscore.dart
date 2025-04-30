import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HighScore extends StatefulWidget {
  const HighScore({super.key});

  @override
  State<HighScore> createState() => _HighScoreState();
}

class _HighScoreState extends State<HighScore> with TickerProviderStateMixin {
  late AnimationController pulse;
  late Animation<double> glow;

  @override
  void initState() {
    super.initState();
    pulse = AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..repeat(reverse: true);

    glow = Tween<double>(
      begin: 5.0,
      end: 20.0,
    ).animate(CurvedAnimation(parent: pulse, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    pulse.dispose();
    super.dispose();
  }

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
              final isTop3 = index < 3;

              if (isTop3) {
                // Determine glow color
                Color glowColor;
                switch (index) {
                  case 0:
                    glowColor = Colors.amber; // Gold
                    break;
                  case 1:
                    glowColor = Colors.grey; // Silver
                    break;
                  case 2:
                    glowColor = Colors.brown; // Bronze
                    break;
                  default:
                    glowColor = Colors.transparent;
                }

                return AnimatedBuilder(
                  animation: glow,
                  builder: (context, child) {
                    return Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: glowColor.withOpacity(0.8),
                                blurRadius: glow.value,
                                spreadRadius: glow.value / 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                '${index + 1}. ${parts[0]}   ${parts[1]}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: glowColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                // Ordinary card for 4th place and below
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            '${index + 1}. ${parts[0]}   ${parts[1]}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
