class Movie {
  final String title;
  final String description;
  final int id;
  Movie({
    required this.title,
    required this.description,
    required this.id,
  });

  @override
  String toString() {
    return 'Movie(title: $title, description: $description, id: $id,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ id.hashCode;
}
