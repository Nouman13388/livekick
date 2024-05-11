import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match Results'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMatch(
              'Man. City',
              '1',
              'Arsenal',
              'Quarter Finals - Leg 2',
              'PK',
              'sky sports IHAD',
            ),
            _buildMatch(
              'Real Madrid',
              '1',
              'Bayern Munich (Arsenal)',
              'Quarter Finals - Leg 2',
              'News',
              'BBC',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatch(
    String homeTeam,
    String score,
    String awayTeam,
    String matchStatus,
    String newsSource,
    String matchDetail,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homeTeam,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                score,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                awayTeam,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                matchStatus,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                '$matchDetail $newsSource',
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
          // You can add more details here like a Column with a small flag for the team, etc.
        ],
      ),
    );
  }
}
