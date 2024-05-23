import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class StreamingSettings extends ChangeNotifier {
  bool isHD = true;
  bool isSubtitlesEnabled = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamingSettings() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('settings').doc('streaming').get();
      if (doc.exists) {
        isHD = doc['isHD'] ?? true;
        isSubtitlesEnabled = doc['isSubtitlesEnabled'] ?? true;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading settings: $e');
    }
  }

  Future<void> saveSettings() async {
    try {
      await _firestore.collection('settings').doc('streaming').set({
        'isHD': isHD,
        'isSubtitlesEnabled': isSubtitlesEnabled,
      });
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  void setHD(bool value) {
    isHD = value;
    notifyListeners();
    saveSettings();
  }

  void setSubtitlesEnabled(bool value) {
    isSubtitlesEnabled = value;
    notifyListeners();
    saveSettings();
  }
}
