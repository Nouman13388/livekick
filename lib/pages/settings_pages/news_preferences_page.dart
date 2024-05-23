import 'package:flutter/material.dart';

class NewsPreferencesPage extends StatelessWidget {
  const NewsPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Preferences'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News Preferences Page',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your functionality here
              },
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
