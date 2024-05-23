import 'package:flutter/material.dart';

class StreamingSettingsPage extends StatelessWidget {
  const StreamingSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streaming Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Streaming Settings Page',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your functionality here
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
