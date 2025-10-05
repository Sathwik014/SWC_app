import 'package:get/get.dart';
import 'package:swc_app/screens/home_Screen.dart';
import 'package:swc_app/screens/search_screen.dart';
import '../screens/recipe_screen.dart';
import '../screens/favorites_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.RECIPE, page: () => HomeScreen()),
    GetPage(name: Routes.RECIPE_DETAILS, page: () => DetailedRecipeView()),
    GetPage(name: Routes.FAVOURITES, page: () => FavouritesScreen()),
    GetPage(name: Routes.SEARCH, page: () => SearchPage()),
  ];
}
