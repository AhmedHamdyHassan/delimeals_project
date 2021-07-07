import './Dummy_data.dart';
import './meal.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';
import 'package:flutter/material.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _fitlers = {
    'Gluten': false,
    'Vegan': false,
    'Vegetarian': false,
    'Lactose': false
  };

  List<Meal> filteredMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void addAndDeleteFavoriteMeal(String id) {
    int index = favoriteMeals.indexWhere((meal) => meal.id == id);
    if (index >= 0) {
      favoriteMeals.removeAt(index);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == id));
    }
  }

  bool isFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  void changeFitlerData(Map<String, bool> currentFilters) {
    setState(() {
      _fitlers = currentFilters;
      filteredMeals = DUMMY_MEALS.where((meal) {
        if (_fitlers['Gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_fitlers['Vegan'] && !meal.isVegan) {
          return false;
        }
        if (_fitlers['Vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_fitlers['Lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
      ),
      routes: {
        '/': (context) => TabsScreen(addAndDeleteFavoriteMeal, favoriteMeals),
        CategoryMealsScreen.CategoryMealsScreenKey: (context) =>
            CategoryMealsScreen(filteredMeals),
        MealDetailsScreen.mealDetailsScreenKey: (context) =>
            MealDetailsScreen(isFavorite, addAndDeleteFavoriteMeal),
        FilterScreen.filterScreenKey: (context) =>
            FilterScreen(_fitlers, changeFitlerData)
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
