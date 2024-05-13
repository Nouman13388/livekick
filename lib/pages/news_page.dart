// pages/news_page.dart

import 'package:flutter/material.dart';
import '../components/match_card.dart';
import '../models/match.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MatchCard(
              match: Match(
                name: 'Man. City',
                dateTime: DateTime.now(),
              ),
            ),
            MatchCard(
              match: Match(
                name: 'Real Madrid',
                dateTime: DateTime.now().add(const Duration(days: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
