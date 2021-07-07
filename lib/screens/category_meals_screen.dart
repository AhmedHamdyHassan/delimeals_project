import '../meal.dart';
import '../widgets/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String CategoryMealsScreenKey = '/category_meals_screen';
  final List<Meal> recentMeal;
  CategoryMealsScreen(this.recentMeal);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> categoryMeals;
  bool didChange = false;
  @override
  void didChangeDependencies() {
    if (!didChange) {
      final modelRoute =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = modelRoute['title'];
      final categoryID = modelRoute['id'];
      categoryMeals = widget.recentMeal.where((singleMeal) {
        return singleMeal.categories.contains(categoryID);
      }).toList();
      didChange = true;
    }
    super.didChangeDependencies();
  }

  void removeItem(itemID) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == itemID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryMeals.length != 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                return MealItem(
                  id: categoryMeals[index].id,
                  title: categoryMeals[index].title,
                  imageUrl: categoryMeals[index].imageUrl,
                  duration: categoryMeals[index].duration,
                  affordability: categoryMeals[index].affordability,
                  complexity: categoryMeals[index].complexity,
                );
              },
              itemCount: categoryMeals.length,
            )
          : Center(
              child: Text(
                'There\'s no meals with these filter set!',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
    );
  }
}
