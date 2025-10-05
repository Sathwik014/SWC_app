import 'package:get/get.dart';
import '../models/recipe_model.dart';
import '../services/favorite_service.dart';

class FavouriteController extends GetxController {
  final FavouriteService _service = Get.find();

  RxList<RecipeModel> get favourites => _service.favourites;

  void toggleFavourite(RecipeModel recipe) => _service.toggleFavourite(recipe);

  bool isFavourite(String id) => _service.isFavourite(id);
}
