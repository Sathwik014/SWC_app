import 'package:get/get.dart';
import 'package:swc_app/controllers/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(RecipeController());
  }
}