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
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching signboards: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchHandSigns() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('handsigns').get();
      print("Apicalls ::: handsigns");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'description': doc['description'] as String,
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching handSigns: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchRoadSigns() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('roadsigns').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'description': doc['description'] as String,
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching roadSigns: $e');
      return [];
    }
  }
  Future<List<Map<String, String>>> fetchHowToApply() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('howtoapply').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'sub_title': doc['sub_title'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching howto apply: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchRtoCodes() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rtocodes').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'description': doc['description'] as String,
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching rtocodes: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchMainBanner() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('mainbanner').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching mainBanner: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchSubBanner() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('subbanner').get();
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'imageUrl': doc['imageUrl'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching subBanner: $e');
      return [];
    }
  }
}