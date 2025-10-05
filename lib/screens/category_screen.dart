import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../widgets/recipe_tile.dart';

class CategoryRecipeView extends StatelessWidget {
  final String title;
  final RecipeController controller = Get.find();

  CategoryRecipeView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.recipes.isEmpty) {
          return const Center(child: Text("No recipes found"));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.recipes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 220, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, i) {
            final recipe = controller.recipes[i];
            return RecipeTile(
              recipe: recipe,
              onTap: () => Get.toNamed('/Recipe-details', arguments: recipe),
            );
          },
        );
      }),
    );
  }
}
