// match_schedule_page.dart

import 'package:flutter/material.dart';
import '../models/match.dart';

class MatchSchedule extends StatefulWidget {
  const MatchSchedule({super.key});

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
            return ListTile(
              title: Text(matches[index].name),
              subtitle: Text(matches[index].dateTime.toString()),
              onTap: () {
                // Navigate to detailed view of the selected match
                // Implement navigation logic here
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _refreshMatches() async {
    // Implement logic to fetch updated matches from Firebase
    // Update the 'matches' list with new data
    setState(() {
      // Update 'matches' with new data
    });
  }
}