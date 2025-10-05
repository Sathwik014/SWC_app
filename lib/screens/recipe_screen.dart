import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swc_app/widgets/loading_dialog.dart';
import '../controllers/recipe_controller.dart';
import '../models/recipe_model.dart';
import '../services/favorite_service.dart';

class DetailedRecipeView extends StatelessWidget {
  final RecipeController recipeController = Get.find();
  final FavouriteService favouriteService = Get.find();

  DetailedRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeModel recipe = Get.arguments;
    recipeController.clearSelectedRecipe();
    recipeController.loadRecipeDetails(recipe.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name, overflow: TextOverflow.ellipsis),
        actions: [
          Obx(() {
            final isFav = favouriteService.isFavourite(recipe.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () => favouriteService.toggleFavourite(recipe),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (recipeController.isLoading.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            LoadingDialog.show(context);
          });
          return const SizedBox.shrink();
        } else {
          LoadingDialog.hide(context);
        }

        final data = recipeController.selectedRecipe.value ?? recipe;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    data.image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 220,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                data.name,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.orangeAccent),
                  const SizedBox(width: 6),
                  Text("${data.time ?? '--'} mins"),
                ],
              ),
              const SizedBox(height: 20),

              // 🍽 Ingredients
              if (data.ingredients != null && data.ingredients!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Ingredients:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...data.ingredients!.map((i) => Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          const Icon(Icons.circle,
                              size: 6, color: Colors.orangeAccent),
                          const SizedBox(width: 8),
                          Expanded(child: Text(i)),
                        ],
                      ),
                    )),
                    const SizedBox(height: 20),
                  ],
                ),

              // 🧾 Instructions
              const Text("Instructions:",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(
                data.instructions?.isNotEmpty == true
                    ? data.instructions!
                    : "Instructions not available.",
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
              const SizedBox(height: 20),

              // 🍎 Nutrition Summary (Color-coded)
              if (data.nutrition != null && data.nutrition!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nutrition Summary:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 6,
                      children: data.nutrition!.entries.map((e) {
                        final color = _getNutritionColor(e.key);
                        return Chip(
                          label: Text("${e.key}: ${e.value}",
                              style: const TextStyle(fontSize: 13)),
                          backgroundColor: color.withOpacity(0.25),
                          side: BorderSide(color: color, width: 1.5),
                        );
                      }).toList(),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }

  Color _getNutritionColor(String name) {
    if (name.toLowerCase().contains("calorie")) return Colors.redAccent;
    if (name.toLowerCase().contains("protein")) return Colors.blueAccent;
    if (name.toLowerCase().contains("carb")) return Colors.green;
    if (name.toLowerCase().contains("fat")) return Colors.orange;
    return Colors.purpleAccent;
  }
}
