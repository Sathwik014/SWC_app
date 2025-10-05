import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/recipe_model.dart';

class FavouriteService extends GetxService {
  final storage = GetStorage();
  final favourites = <RecipeModel>[].obs;
  static const _storageKey = 'favourites';

  @override
  void onInit() {
    super.onInit();
    final stored = storage.read<List>(_storageKey);
    if (stored != null) {
      favourites.assignAll(stored
          .map((e) => RecipeModel.fromJson(Map<String, dynamic>.from(e)))
          .toList());
    }

    ever(favourites, (_) {
      storage.write(_storageKey, favourites.map((e) => e.toJson()).toList());
    });
  }

  void toggleFavourite(RecipeModel recipe) {
    if (favourites.any((r) => r.id == recipe.id)) {
      favourites.removeWhere((r) => r.id == recipe.id);
      Get.snackbar("Removed", "${recipe.name} removed from favourites",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      favourites.add(recipe);
      Get.snackbar("Added", "${recipe.name} added to favourites",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isFavourite(String id) => favourites.any((r) => r.id == id);
}
