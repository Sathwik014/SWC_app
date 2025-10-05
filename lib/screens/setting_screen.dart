import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart'; // ✅ use this

class SettingsScreen extends StatelessWidget {
  final ThemeController themeController = Get.find(); // ✅ use existing instance

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=12"),
            ),
            const SizedBox(height: 10),
            const Text("Sathwik",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text("sathwik@iitg.ac.in",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Obx(() => SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeController.isDarkMode.value,
              onChanged: (_) => themeController.toggleTheme(),
              secondary: const Icon(Icons.dark_mode),
            )),
          ],
        ),
      ),
    );
  }
}
