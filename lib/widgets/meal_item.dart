import '../screens/meal_details_screen.dart';
import '../meal.dart';
import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String title, imageUrl, id;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.affordability,
    @required this.complexity,
  });

  void changeMealScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailsScreen.mealDetailsScreenKey, arguments: id)
        .then((value) {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Hard:
        return 'Hard';
      case Complexity.Challenging:
        return 'Challenging';
    }
    return 'Unknown';
  }

  String get affordText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => changeMealScreen(context),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          elevation: 10,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25)),
                    child: Image.network(
                      imageUrl,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.height / 1.6
                          : MediaQuery.of(context).size.height / 2.7,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black54,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.schedule),
                        SizedBox(
                          width: 6,
                        ),
                        Text('$duration min')
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work),
                        SizedBox(
                          width: 6,
                        ),
                        Text(complexityText)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money),
                        SizedBox(
                          width: 6,
                        ),
                        Text(affordText)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
