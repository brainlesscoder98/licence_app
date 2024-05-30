import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> fetchSignboards() async {
    return _fetchCollection('signboards');
  }

  Future<List<Map<String, String>>> fetchHandSigns() async {
    return _fetchCollection('handsigns');
  }

  Future<List<Map<String, String>>> fetchRoadSigns() async {
    return _fetchCollection('roadsigns');
  }

  Future<List<Map<String, String>>> fetchHowToApply() async {
    return _fetchCollection('howtoapply');
  }

  Future<List<Map<String, String>>> fetchRtoCodes() async {
    return _fetchCollection('rtocodes');
  }

  Future<List<Map<String, String>>> fetchMainBanner() async {
    return _fetchCollection('mainbanner');
  }

  Future<List<Map<String, String>>> fetchLanguages() async {
    return _fetchCollection('languages');
  }

  Future<List<Map<String, String>>> fetchSubBanner() async {
    return _fetchCollection('subbanner');
  }

  Future<List<Map<String, dynamic>>> fetchPreTestQuestions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('questions').get();
      print("Apicalls ::: questions");

      return snapshot.docs.map((doc) {
        // Cast the document data to Map<String, dynamic> before converting to Map<String, String>
        final data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching pretest questions: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> _fetchCollection(String collectionName) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
      print("Apicalls ::: $collectionName");

      return snapshot.docs.map((doc) {
        // Cast the document data to Map<String, dynamic> before converting to Map<String, String>
        final data = doc.data() as Map<String, dynamic>;
        return data.map((key, value) => MapEntry(key, value.toString()));
      }).toList();
    } catch (e) {
      print('Error fetching $collectionName: $e');
      return [];
    }
  }
}