import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final String? id;
  final String? type; // Firestore document ID
  final String? name;
  final String? date;

  Exam({this.id, this.type,  this.name,  this.date});

  // // Convert Firestore document to Exam model
  // factory Exam.fromFirestore(String type, Map<String, dynamic> data) {
  //   return Exam(
  //     type: data['type'],
  //     name: data['name'],
  //     date: data['date'],
  //   );
  // }


  // Convert Firestore document to Exam object
  factory Exam.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Exam(
      id: doc.id, // Get document ID
      name: data['name'],
      type: data['type'],
      date: data['date'],
    );
  }

  // Convert Exam model to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'date': " ",
      'type' : type
    };
  }
}
