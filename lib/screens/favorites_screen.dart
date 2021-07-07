import '../widgets/meal_item.dart';
import '../meal.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final Function addAndDeleteFavoriteMeal;
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.addAndDeleteFavoriteMeal, this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    return favoriteMeals.length != 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                id: favoriteMeals[index].id,
                title: favoriteMeals[index].title,
                imageUrl: favoriteMeals[index].imageUrl,
                duration: favoriteMeals[index].duration,
                affordability: favoriteMeals[index].affordability,
                complexity: favoriteMeals[index].complexity,
              );
            },
            itemCount: favoriteMeals.length,
          )
        : Center(
            child: Text(
              'There\'s no favorite meals!',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
  }
}
