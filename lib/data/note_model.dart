class NoteModel {
  final String headLine;
  final String description;
  final String ?mediaUrl;
  final DateTime createdAt;

  NoteModel({
    required this.headLine,
    required this.description,
    required this.createdAt,
    this.mediaUrl,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      headLine: json['headLine'] as String,
      description: json['description'] as String,
      mediaUrl: json['mediaUrl'] ?? "" ,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headLine': headLine,
      'mediaUrl': mediaUrl ?? "",
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}