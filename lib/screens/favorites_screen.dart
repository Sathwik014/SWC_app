import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/favorite_service.dart';

class FavouritesScreen extends StatelessWidget {
  final FavouriteService service = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favourites")),
      body: Obx(() {
        if (service.favourites.isEmpty) {
          return const Center(child: Text("No favourites yet"));
        }

        return ListView.builder(
          itemCount: service.favourites.length,
          itemBuilder: (context, i) {
            final recipe = service.favourites[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                leading: recipe.image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    recipe.image!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Icon(Icons.fastfood, size: 40),
                title: Text(recipe.name),
                subtitle: Text("${recipe.time ?? '--'} mins"),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => service.toggleFavourite(recipe),
                ),
                onTap: () => Get.toNamed('/Recipe-details', arguments: recipe),
              ),
            );
          },
        );
      }),
    );
  }
}
