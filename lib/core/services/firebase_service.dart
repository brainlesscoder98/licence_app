import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> fetchSignboards() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('signboards').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'name': doc['name'] as String,
          'description': doc['description'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching signboards: $e');
      return [];
    }
  }
}
