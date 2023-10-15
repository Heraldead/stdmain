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

  IllnessEntity copyWith({
    String? image,
    int? rating,
    String? name,
    String? description,
    String? allDescription,
    List<String>? tags,
  }) {
    return IllnessEntity(
      image: image ?? this.image,
      rating: rating ?? this.rating,
      name: name ?? this.name,
      description: description ?? this.description,
      allDescription: allDescription ?? this.allDescription,
      tags: tags ?? this.tags,
    );
  }

  @override
  String toString() {
    return 'IllnessEntity{image: $image, rating: $rating, name: $name, description: $description, allDescription: $allDescription, tags: $tags}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IllnessEntity &&
          runtimeType == other.runtimeType &&
          image == other.image &&
          rating == other.rating &&
          name == other.name &&
          description == other.description &&
          allDescription == other.allDescription &&
          tags == other.tags;

  @override
  int get hashCode =>
      image.hashCode ^ rating.hashCode ^ name.hashCode ^ description.hashCode ^ allDescription.hashCode ^ tags.hashCode;
}
