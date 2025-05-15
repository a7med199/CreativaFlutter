class NoteModel {
  // headline
  // description
  // createdAt
  final String headline;
  final String description;
  final DateTime createdAt;

  NoteModel({
    required this.headline,
    required this.description,
    required this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      headline: json['headline'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
    'headline': headline,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    };
  }
}
