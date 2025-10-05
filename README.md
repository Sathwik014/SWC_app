# Zara Khud Se Bhi Khana Pakalo — Recipe App

A beautifully designed **Flutter Recipe App** built using **GetX** architecture.  
This app lets users explore recipes by **name, category, or ingredients**, view **nutritional summaries**, toggle **dark/light mode**, and even **save favourites** locally — all with a fun, smooth UI & animations.

---

## Features

### Home Screen
- Two horizontal categories:
  - **Dishes** → Cake, Biryani, Burger, Pizza, etc.
  - **Cuisines** → North Indian, South Indian, Italian, Japanese, Korean.
- Each category loads recipes using the **Spoonacular API**.
- Reuses a clean, responsive **Recipe Tile UI** throughout the app.
- Built-in **Bottom Navigation Bar** with:
  - Home  
  - Favourites  
  - Settings  

---

### Smart Search
- Single **search bar** to search recipes by:
  - Name
  - Ingredient
  - Category (Cuisine)
- Automatically fetches from Spoonacular’s `complexSearch` and `findByIngredients` endpoints.

---

### Detailed Recipe Page
- Displays:
  - Recipe image, name, and preparation time.
  - **Ingredients list**
  - **Instructions**
  - **Nutrition Summary** (calories, protein, carbs, etc.) shown with colorful chips.
- Includes a **heart icon ❤️** to save/remove favourites.
- Data fetched dynamically from:
- https://api.spoonacular.com/recipes/{id}/information?includeNutrition=true
  - If API fails or recipe ID is invalid → loads a **fallback local recipe**.

---

### ❤️ Favourites Screen
- Displays all recipes liked by the user.
- Uses **local persistence** — your favourites remain even after app restart.
- Managed entirely using **GetStorage**, a lightweight key-value store.

---

### ⚙️ Settings Screen
- Includes:
- **Fake profile** (Avatar, name, email)
- **Dark Mode toggle** 🌙  
- Theme preference is stored locally in **GetStorage** and auto-restores on restart.

---

### 💾 Local Storage Details

| Data Type | Storage Method | File Used | Description |
|------------|----------------|-----------|--------------|
| Favourites | `GetStorage` | `favourites` key | Stores list of favourite recipes as JSON |
| Theme Mode | `GetStorage` | `isDarkMode` key | Stores boolean value for dark/light theme |

##File struture
lib/
 ├── controllers/
 │   ├── recipe_controller.dart
 │   ├── theme_controller.dart
 │   └── ...
 ├── models/
 │   └── recipe_model.dart
 ├── services/
 │   ├── api_service.dart
 │   └── favorite_service.dart
 ├── screens/
 │   ├── home_screen.dart
 │   ├── search_screen.dart
 │   ├── detailed_recipe_view.dart
 │   ├── favorites_screen.dart
 │   ├── settings_screen.dart
 │   └── splash_screen.dart
 ├── widgets/
 │   ├── recipe_tile.dart
 │   └── loading_dialog.dart
 └── main.dart




