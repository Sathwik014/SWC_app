import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swc_app/screens/favorites_screen.dart';
import 'package:swc_app/screens/setting_screen.dart';
import '../controllers/recipe_controller.dart';
import '../widgets/recipe_tile.dart';
import 'category_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeController controller = Get.find();
  int _currentIndex = 0;

  final List<Map<String, String>> dishes = [
    {"name": "Pizza", "image": "assets/images/pizza.png"},
    {"name": "Burger", "image": "assets/images/burger.jpg"},
    {"name": "Biryani", "image": "assets/images/biryani.jpg"},
    {"name": "Cake", "image": "assets/images/cake.jpg"},
    {"name": "Chicken", "image": "assets/images/chicken.jpg"},
  ];

  final List<Map<String, String>> cuisines = [
    {"name": "Indian", "image": "assets/images/north.jpg"},
    {"name": "Japanese", "image": "assets/images/japanese.jpg"},
    {"name": "Italian", "image": "assets/images/italian.jpg"},
    {"name": "Korean", "image": "assets/images/korean.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final pages = [
      _buildHome(theme, isDark),
      FavouritesScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        backgroundColor: theme.colorScheme.surface,
        indicatorColor: theme.colorScheme.primary,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite_outline), label: "Favorites"),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: "Settings"),
        ],
      ),
    );
  }

  Widget _buildHome(ThemeData theme, bool isDark) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("RecipeApp 🍽️",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: const Icon(Icons.person, color: Colors.orange),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Search bar → Navigates to Search Page
          GestureDetector(
            onTap: () => Get.to(() => SearchPage()),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark ? Colors.grey.shade900 : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black45 : Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Row(
                    children: const [
                      SizedBox(width: 16),
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        "Search by name, ingredient or category...",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),

          const Text("Popular Dishes 🍔",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildCategoryList(dishes, true),

          const SizedBox(height: 25),

          const Text("Explore by Cuisine 🌍",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildCategoryList(cuisines, false),

          const SizedBox(height: 25),

          const Text("Recommended 👨‍🍳",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.featuredRecipes.isEmpty) {
              controller.fetchFeatured();
              return const SizedBox.shrink();
            }
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.featuredRecipes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 220,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, i) {
                final recipe = controller.featuredRecipes[i];
                return RecipeTile(
                  recipe: recipe,
                  onTap: () => Get.toNamed('/Recipe-details', arguments: recipe),
                );
              },
            );
          }),
        ]),
      ),
    );
  }

  Widget _buildCategoryList(List<Map<String, String>> list, bool isDish) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return GestureDetector(
            onTap: () {
              if (isDish) {
                controller.search(query: item['name']);
              } else {
                controller.search(category: item['name']);
              }
              Get.to(() => CategoryRecipeView(title: item['name']!));
            },
            child: Container(
              width: 95,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(item['image']!,
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 6),
                  Text(item['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
