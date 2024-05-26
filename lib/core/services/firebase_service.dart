import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, String>>> fetchSignboards() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('signboards').get();
      print("Apicalls ::: signboards");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'name': doc['name'] as String,
          'name_ml': doc['name_ml'] as String,
          'description': doc['description'] as String,
          'description_ml': doc['description_ml'] as String,
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
          'title_ml': doc['title_ml'] as String,
          'description_ml': doc['description_ml'] as String,
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
      print("Apicalls ::: roadsigns");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'description': doc['description'] as String,
          'title_ml': doc['title_ml'] as String,
          'description_ml': doc['description_ml'] as String,
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
      print("Apicalls ::: howtoapply");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'sub_title': doc['sub_title'] as String,
          'title_ml': doc['title_ml'] as String,
          'sub_title_ml': doc['sub_title_ml'] as String,
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
      print("Apicalls ::: rtocodes");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'description': doc['description'] as String,
          'title_ml': doc['title_ml'] as String,
          'description_ml': doc['description_ml'] as String,
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
      print("Apicalls ::: mainbanner");
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

  Future<List<Map<String, String>>> fetchLanguages() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('languages').get();
      print("Apicalls ::: languages");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'title': doc['title'] as String,
          'short_name': doc['short_name'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching languages: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchSubBanner() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('subbanner').get();
      print("Apicalls ::: subbanner");
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

  Future<List<Map<String, String>>> fetchPreTestQuestions() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('pretest').get();
      print("Apicalls ::: pretest");
      return snapshot.docs.map((doc) {
        // Ensure values are cast to String
        return {
          'question': doc['question'] as String,
          'answer': doc['answer'] as String,
          'option_one': doc['option_one'] as String,
          'option_two': doc['option_two'] as String,
          'option_three': doc['option_three'] as String,
          'question_ml': doc['question'] as String,
          'answer_ml': doc['answer_ml'] as String,
          'option_one_ml': doc['option_one_ml'] as String,
          'option_two_ml': doc['option_two_ml'] as String,
          'option_three_ml': doc['option_three_ml'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error fetching pretest questions: $e');
      return [];
    }
  }
}
