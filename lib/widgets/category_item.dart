import '../screens/category_meals_screen.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title,id;
  final Color color;
  CategoryItem({this.id,this.title,this.color});
  void changeScreen(BuildContext context){
    Navigator.of(context).pushNamed(CategoryMealsScreen.CategoryMealsScreenKey,arguments: {'id':id,'title':title});
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> changeScreen(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        child: Text(title,style: Theme.of(context).textTheme.bodyText1,),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, 
          ),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}