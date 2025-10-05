import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/recipe_model.dart';

class RecipeTile extends StatelessWidget {
  final RecipeModel recipe;
  final VoidCallback onTap;

  const RecipeTile({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: recipe.image != null
                  ? Image.network(
                recipe.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.fastfood, size: 40)),
              )
                  : const Icon(Icons.fastfood, size: 60),
            ),

            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
              ),
            ),

            // Text overlay
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Text(
                recipe.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
