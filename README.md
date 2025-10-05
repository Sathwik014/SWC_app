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



![WhatsApp Image 2025-10-06 at 12 55 55 AM](https://github.com/user-attachments/assets/ee81d557-52b9-4785-8222-4cdf00975d28)
![WhatsApp Image 2025-10-06 at 12 55 56 AM](https://github.com/user-attachments/assets/34911d1f-cc0b-4d2e-9b28-be3fcf5fd8c3)
![WhatsApp Image 2025-10-06 at 12 55 56 AM (1)](https://github.com/user-attachments/assets/ae442bd8-4a39-4d66-bad1-58b650d65dee)
![WhatsApp Image 2025-10-06 at 12 55 57 AM](https://github.com/user-attachments/assets/82cbe235-8903-43e6-a88d-67795d59adfa)
![WhatsApp Image 2025-10-06 at 12 55 57 AM (1)](https://github.com/user-attachments/assets/c376f963-e517-48da-b1a6-be8a2c1cd5ef)
![WhatsApp Image 2025-10-06 at 12 56 08 AM](https://github.com/user-attachments/assets/9e4461ca-fac2-4fa2-87c2-2406c2126fb3)
![WhatsApp Image 2025-10-06 at 12 56 08 AM (1)](https://github.com/user-attachments/assets/90550775-ccbf-45f1-8990-381ce61edc4d)
https://github.com/user-attachments/assets/4df2e09e-5ea9-4d3c-b3ec-c942f94f5b30

