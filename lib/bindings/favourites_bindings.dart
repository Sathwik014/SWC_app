import 'package:get/get.dart';
import 'package:swc_app/controllers/favorite_controller.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(FavouriteController(),permanent: true);
  }
}