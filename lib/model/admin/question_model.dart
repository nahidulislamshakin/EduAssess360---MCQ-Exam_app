class Question {
  final String id; // Firestore document ID
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String category;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.category,
  });

  // Convert Firestore document to Question model
  factory Question.fromFirestore(String id, Map<String, dynamic> data) {
    return Question(
      id: id,
      question: data['question'],
      options: List<String>.from(data['options']),
      correctAnswer: data['correct_answer'],
      category: data['category'],
    );
  }

  // Convert Question model to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'category': category,
    };
  }
}
