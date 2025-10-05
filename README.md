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

## 🧠 State Management & Local Storage

--The app uses **GetX** extensively for reactive state management, dependency injection, and route handling. All controllers and services are registered globally with `Get.put()` and accessed anywhere without context, ensuring clean and maintainable architecture.

--Favourites are handled using a dedicated `FavouriteService`, which stores the list of favourite recipes in an observable `RxList<RecipeModel>`. This list automatically updates the UI whenever changes occur, thanks to GetX’s reactivity.

--Local persistence is implemented using **GetStorage**, a lightweight key-value storage system. Each time the favourites list changes, the updated data is serialized via `toJson()` and saved locally. On app startup, the data is read back into memory, ensuring users never lose their saved recipes even after restarting the app.

--In short — **GetX** powers the app’s reactivity, routing, and dependency management, while **GetStorage** ensures persistent and seamless offline access to user favourites.





