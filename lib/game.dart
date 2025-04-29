import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  //Level, horizontal, vertical
  List<int> levels = [1, 2, 2];
  List<String> items = ['pikachu', 'pikachu', 'charizard', 'charizard'];

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
                    child: Container(
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
                          Divider(height: 5, color: Colors.transparent),
                          Text(
                            '${items[index][0].toUpperCase()}${items[index].substring(1)}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                levels = [1, 2, 2];
                items = ['pikachu', 'pikachu', 'charizard', 'charizard'];

                items.shuffle();
              });
            },
            child: const Text('Ganti Level 1'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                levels = [2, 2, 4];
                items = [
                  'pikachu',
                  'pikachu',
                  'charizard',
                  'charizard',
                  'gengar',
                  'gengar',
                  'eevee',
                  'eevee',
                ];

                items.shuffle();
              });
            },
            child: const Text('Ganti Level 2'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                levels = [3, 3, 4];
                items = [
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
                ];

                items.shuffle();
              });
            },
            child: const Text('Ganti Level 3'),
          ),
        ],
      ),
    );
  }
}
