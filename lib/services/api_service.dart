import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.spoonacular.com';
  static const String _apiKey = 'c86c0e8efd5144dcb97b4ee12d634d24';

  /// 🔍 Unified search by name, ingredient, or category
  static Future<List<RecipeModel>> searchAll({
    String? query,
    String? ingredient,
    String? category,
  }) async {
    try {
      String endpoint = '';
      if (ingredient != null && ingredient.isNotEmpty) {
        endpoint =
        '$_baseUrl/recipes/findByIngredients?ingredients=$ingredient&number=10&apiKey=$_apiKey';
      } else {
        endpoint =
        '$_baseUrl/recipes/complexSearch?query=${Uri.encodeComponent(query ?? category ?? '')}&addRecipeInformation=true&number=10&apiKey=$_apiKey';
      }

      final res = await http.get(Uri.parse(endpoint));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final results = data is Map ? data['results'] : data;
        return (results as List)
            .map((e) => RecipeModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        print("API Error: ${res.statusCode} ${res.body}");
        return _fallbackRecipes();
      }
    } catch (e) {
      print("Error: $e");
      return _fallbackRecipes();
    }
  }

  /// 🍲 Fetch full recipe details including nutrition
  static Future<RecipeModel?> getRecipeDetails(String? id) async {
    if (id == null || id.isEmpty || id == "0") {
      print("⚠️ Invalid recipe ID: $id, using fallback.");
      return _fallbackRecipes().first;
    }

    try {
      final url =
          '$_baseUrl/recipes/$id/information?includeNutrition=true&apiKey=$_apiKey';
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);

        // 🧾 Extract nutrition summary
        Map<String, dynamic>? nutritionMap;
        final nutrients = (json['nutrition']?['nutrients'] as List?) ?? [];
        if (nutrients.isNotEmpty) {
          nutritionMap = {};
          for (final n in nutrients.take(8)) {
            final name = n['name'];
            final amount = n['amount'];
            final unit = n['unit'];
            if (name != null) nutritionMap[name] = "$amount $unit";
          }
        }

        return RecipeModel(
          id: json['id']?.toString() ?? '',
          name: json['title'] ?? '',
          image: json['image'],
          time: json['readyInMinutes']?.toString(),
          ingredients: (json['extendedIngredients'] as List?)
              ?.map((i) => i['original']?.toString() ?? '')
              .toList() ??
              [],
          instructions: json['instructions'] ?? '',
          nutrition: nutritionMap,
        );
      } else {
        print("getRecipeDetails failed: ${res.statusCode}");
        return _fallbackRecipes().first;
      }
    } catch (e) {
      print("getRecipeDetails error: $e");
      return _fallbackRecipes().first;
    }
  }

  /// 🧪 Fallback local dummy data
  static List<RecipeModel> _fallbackRecipes() => [
    RecipeModel(
      id: "0",
      name: "Demo Biryani",
      image: "https://picsum.photos/300",
      time: "45",
      ingredients: ["Rice", "Chicken", "Spices"],
      instructions: "Mix all ingredients and cook for 45 minutes.",
      nutrition: {"Calories": "500 kcal", "Protein": "30 g"},
    ),
  ];
}
