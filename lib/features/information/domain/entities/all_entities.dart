class PopularEntity {
  final String name;
  final String description;

  PopularEntity({
    required this.name,
    required this.description,
  });
}

class IllnessEntity {
  final String image;
  final int rating;
  final String name;
  final String description;

  final String allDescription;
  final List<String> tags;
  IllnessEntity({
    required this.image,
    required this.rating,
    required this.name,
    required this.description,
    required this.tags,
    required this.allDescription,
  });
}
