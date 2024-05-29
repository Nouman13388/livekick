import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MatchController {
  final CollectionReference _matchesCollection = FirebaseFirestore.instance.collection('MatchURL');

  Future<Map<String, dynamic>?> getMatchDetails(String matchId) async {
    try {
      DocumentSnapshot documentSnapshot = await _matchesCollection.doc(matchId).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>?;
      } else {
        if (kDebugMode) {
          print('Match with ID $matchId does not exist.');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching match details: $e');
      }
      return null;
    }
  }
}
