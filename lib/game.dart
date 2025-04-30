import 'dart:async';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  // Level ke-..., Vertical, Horizontal, Timer
  List<int> levels = [1, 2, 2, 20];
  List<String> items = ['pikachu', 'pikachu', 'charizard', 'charizard'];

  // Buat logic game
  late List<bool> flipped;
  late List<int> flippedIndices;
  bool isAnimating = false;
  int points = 0;

  // Buat timer
  late Timer timer;
  late int hitung = levels[3];
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    startCountdownTimer();

    flipped = List.filled(items.length, false);
    flippedIndices = [];
  }

  @override
  void dispose() {
    timer.cancel();
    points = 0;
    hitung = 0;
    super.dispose();
  }

  void startCountdownTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (hitung == 0) {
          timer.cancel();
          isActive = false;

          Navigator.pushReplacementNamed(context, "result");
        } else {
          hitung--;
          isActive = true;
        }
      });
    });
  }

  void resetLevel(List<int> newLevel, List<String> newItems) {
    setState(() {
      levels = newLevel;
      items = newItems;
      items.shuffle();
      flipped = List.filled(items.length, false);
      flippedIndices = [];
      isAnimating = false;
      hitung = levels[3];
    });
  }

  void handleTap(int index) {
    if (flipped[index] || isAnimating) {
      return;
    }

    setState(() {
      flipped[index] = true;
      flippedIndices.add(index);
    });

    if (flippedIndices.length == 2) {
      setState(() {
        isAnimating = true;
      });

      if (items[flippedIndices[0]] != items[flippedIndices[1]]) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            flipped[flippedIndices[0]] = false;
            flipped[flippedIndices[1]] = false;
            flippedIndices.clear();
            isAnimating = false;
          });
        });
      } else {
        flippedIndices.clear();
        setState(() {
          points += 10;
          isAnimating = false;
        });
      }

      if (flipped.every((item) => item)) {
        if (levels[0] == 1) {
          resetLevel(
            [2, 2, 4, 40],
            [
              'pikachu',
              'pikachu',
              'charizard',
              'charizard',
              'gengar',
              'gengar',
              'eevee',
              'eevee',
            ],
          );
        } else if (levels[0] == 2) {
          resetLevel(
            [3, 3, 4, 60],
            [
              'pikachu',
              'pikachu',
              'charizard',
              'charizard',
              'gengar',
              'gengar',
              'eevee',
              'eevee',
              'snorlax',
              'snorlax',
              'garchomp',
              'garchomp',
            ],
          );
        } else if (levels[0] == 3) {
          Navigator.pushReplacementNamed(context, "result");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Layar Game')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Text('Level ${levels[0]}'),
              ),
              Text('Point: $points'),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text('Timer: $hitung'),
              ),
            ],
          ),
          Column(
            children: List.generate(
              levels[1],
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(levels[2], (col) {
                  int index = row * levels[2] + col;
                  return Card(
                    child: GestureDetector(
                      onTap: () => handleTap(index),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child:
                            flipped[index]
                                ? Container(
                                  key: ValueKey(true),
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          '../assets/img/${items[index]}.png',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const Divider(
                                        height: 5,
                                        color: Colors.transparent,
                                      ),
                                      Text(
                                        '${items[index][0].toUpperCase()}${items[index].substring(1)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                : Container(
                                  key: ValueKey(false),
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    '../assets/img/card_back.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              resetLevel(
                [1, 2, 2, 20],
                ['pikachu', 'pikachu', 'charizard', 'charizard'],
              );
            },
            child: const Text('Ganti Level 1'),
          ),
          TextButton(
            onPressed: () {
              resetLevel(
                [2, 2, 4, 40],
                [
                  'pikachu',
                  'pikachu',
                  'charizard',
                  'charizard',
                  'gengar',
                  'gengar',
                  'eevee',
                  'eevee',
                ],
              );
            },
            child: const Text('Ganti Level 2'),
          ),
          TextButton(
            onPressed: () {
              resetLevel(
                [3, 3, 4, 60],
                [
                  'pikachu',
                  'pikachu',
                  'charizard',
                  'charizard',
                  'gengar',
                  'gengar',
                  'eevee',
                  'eevee',
                  'snorlax',
                  'snorlax',
                  'garchomp',
                  'garchomp',
                ],
              );
            },
            child: const Text('Ganti Level 3'),
          ),
        ],
      ),
    );
  }
}
