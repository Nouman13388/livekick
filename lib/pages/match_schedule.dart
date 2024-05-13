// pages/match_schedule.dart

import 'package:flutter/material.dart';
import '../components/match_card.dart';
import '../models/match.dart';

class MatchSchedule extends StatefulWidget {
  const MatchSchedule({Key? key});

  @override
  _MatchScheduleState createState() => _MatchScheduleState();
}

class _MatchScheduleState extends State<MatchSchedule> {
  final List<Match> matches = [
    Match(name: 'Match 1', dateTime: DateTime.now().add(const Duration(days: 1))),
    Match(name: 'Match 2', dateTime: DateTime.now().add(const Duration(days: 2))),
    Match(name: 'Match 3', dateTime: DateTime.now().add(const Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Schedule'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMatches,
        child: ListView.builder(
          itemCount: matches.length,
          itemBuilder: (context, index) {
            return MatchCard(
              match: matches[index],
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshMatches() async {
    final newMatch = Match(name: 'New Match', dateTime: DateTime.now());
    setState(() {
      matches.add(newMatch);
    });
  }
}
