class RecipeModel {
  final String id;
  final String name;
  final String? image;
  final String? time;
  final List<String>? ingredients;
  final String? instructions;
  final Map<String, dynamic>? nutrition;

  RecipeModel({
    required this.id,
    required this.name,
    this.image,
    this.time,
    this.ingredients,
    this.instructions,
    this.nutrition,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id']?.toString() ?? '',
      name: json['title'] ?? json['name'] ?? 'Unknown',
      image: json['image'],
      time: json['readyInMinutes']?.toString() ?? json['time']?.toString(),
      ingredients: (json['extendedIngredients'] != null)
          ? (json['extendedIngredients'] as List)
          .map((i) => i['original']?.toString() ?? '')
          .toList()
          : (json['ingredients'] != null)
          ? (json['ingredients'] as List)
          .map((i) => i.toString())
          .toList()
          : [],
      instructions:
      json['instructions'] ?? json['summary'] ?? 'No instructions available.',
      nutrition: json['nutrition'] != null
          ? Map<String, dynamic>.from(json['nutrition'])
          : {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'time': time,
    'ingredients': ingredients,
    'instructions': instructions,
    'nutrition': nutrition,
  };
}
