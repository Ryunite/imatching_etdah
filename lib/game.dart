import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<int> levels = [1, 2, 2];
  List<String> items = ['pikachu', 'pikachu', 'charizard', 'charizard'];

  late List<bool> flipped;

  @override
  void initState() {
    super.initState();
    flipped = List.filled(items.length, false);
  }

  void resetLevel(List<int> newLevel, List<String> newItems) {
    setState(() {
      levels = newLevel;
      items = newItems;
      items.shuffle();
      flipped = List.filled(items.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layar Game')),
      body: Column(
        children: [
          Text('Level ${levels[0]}'),
          Column(
            children: List.generate(
              levels[1],
              (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(levels[2], (col) {
                  int index = row * levels[2] + col;
                  return Card(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          flipped[index] = !flipped[index];
                        });
                      },
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
                [1, 2, 2],
                ['pikachu', 'pikachu', 'charizard', 'charizard'],
              );
            },
            child: const Text('Ganti Level 1'),
          ),
          TextButton(
            onPressed: () {
              resetLevel(
                [2, 2, 4],
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
                [3, 3, 4],
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
