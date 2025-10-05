import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:swc_app/controllers/theme_controller.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'controllers/recipe_controller.dart';
import 'services/favorite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(RecipeController(),permanent: true);
  Get.put(FavouriteService(),permanent: true);
  Get.put(ThemeController(), permanent: true);


  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Recipe App",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
