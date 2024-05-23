import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.sports_soccer, color: Colors.blue),
            title: Text(
              match.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Date: ${match.dateTime.toString()}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Description or additional match details can go here.',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('LIVE MATCH'),
                onPressed: () {
                  // Implement the view details functionality here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
