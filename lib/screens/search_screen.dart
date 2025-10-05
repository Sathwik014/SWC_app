import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/loading_dialog.dart';

class SearchPage extends StatelessWidget {
  final RecipeController controller = Get.find();
  final TextEditingController queryController = TextEditingController();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Recipes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: queryController,
            decoration: InputDecoration(
              hintText: "Search by dish, ingredient, or category...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onSubmitted: (val) async {
              LoadingDialog.show(context);
              await controller.search(query: val);
              if (context.mounted) LoadingDialog.hide(context);
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) return const SizedBox.shrink();
              if (controller.recipes.isEmpty) {
                return const Center(child: Text("No results found"));
              }
              return GridView.builder(
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
          ),
        ]),
      ),
    );
  }
}
