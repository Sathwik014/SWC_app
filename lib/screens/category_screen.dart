import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/recipe_controller.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/loading_dialog.dart';

class CategoryRecipeView extends StatefulWidget {
  final String title;
  const CategoryRecipeView({super.key, required this.title});

  @override
  State<CategoryRecipeView> createState() => _CategoryRecipeViewState();
}

class _CategoryRecipeViewState extends State<CategoryRecipeView> {
  final RecipeController controller = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LoadingDialog.show(context);
      await controller.search(category: widget.title);
      if (mounted) LoadingDialog.hide(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Obx(() {
        if (controller.isLoading.value) return const SizedBox.shrink();
        if (controller.recipes.isEmpty) {
          return const Center(child: Text("No recipes found"));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 220,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.recipes.length,
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
