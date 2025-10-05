import 'package:get/get.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class RecipeController extends GetxController {
  var recipes = <RecipeModel>[].obs;
  var featuredRecipes = <RecipeModel>[].obs;
  var selectedRecipe = Rx<RecipeModel?>(null);
  var isLoading = false.obs;

  Future<void> search({String? query, String? ingredient, String? category}) async {
    try {
      isLoading.value = true;
      final results = await ApiService.searchAll(
        query: query,
        ingredient: ingredient,
        category: category,
      );
      recipes.assignAll(results);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFeatured() async {
    isLoading.value = true;
    final dishes = ['Pizza', 'Burger', 'Biryani', 'Cake', 'Pasta', 'Salad'];
    featuredRecipes.clear();
    for (var name in dishes) {
      final res = await ApiService.searchAll(query: name);
      if (res.isNotEmpty) featuredRecipes.add(res.first);
    }
    isLoading.value = false;
  }

  /// 🧾 Fetch details for one recipe
  Future<void> loadRecipeDetails(String id) async {
    isLoading.value = true;
    selectedRecipe.value = await ApiService.getRecipeDetails(id);
    isLoading.value = false;
  }

  void clearSelectedRecipe() => selectedRecipe.value = null;
}
