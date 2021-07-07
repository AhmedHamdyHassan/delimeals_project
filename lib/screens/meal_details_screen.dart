import 'package:flutter/cupertino.dart';

import '../Dummy_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MealDetailsScreen extends StatefulWidget {
  static const String mealDetailsScreenKey='/meal_details_screen';
  final Function isFavorite,addAndDeleteFavoriteMeal;
  MealDetailsScreen(this.isFavorite,this.addAndDeleteFavoriteMeal);

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget textConatinerWidget(String text,BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text,style: Theme.of(context).textTheme.bodyText1,)
    );
  }

  Widget containerBuilder(Widget widget,BuildContext context){
    return Container(
      decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey,),
      borderRadius: BorderRadius.circular(18)),
      width: MediaQuery.of(context).size.width/1.3,
      height: MediaQuery.of(context).size.height/4,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final argsID=ModalRoute.of(context).settings.arguments as String;
    final mealData=DUMMY_MEALS.firstWhere((meal)=>meal.id==argsID);
    final appBar=Platform.isAndroid?AppBar(
        title: Text(mealData.title),)
      :
      CupertinoNavigationBar(
      middle: Text(mealData.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child:widget.isFavorite(argsID)? const Icon(CupertinoIcons.heart_solid):const Icon(CupertinoIcons.heart),
            onTap:(){
              setState((){
              widget.addAndDeleteFavoriteMeal(argsID);
              });
            }
          ),
        ]
      )
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              mealData.imageUrl,
              width: double.infinity,
              height: MediaQuery.of(context).orientation==Orientation.landscape? 
              MediaQuery.of(context).size.height/1.6
              :
              MediaQuery.of(context).size.height/2.4,
              fit: BoxFit.cover,
            ),
            textConatinerWidget('Ingredients', context)
            ,
            containerBuilder(ListView.builder(
                itemBuilder:(cxt,index){
                  return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(mealData.ingredients[index],style: Theme.of(context).textTheme.bodyText1,),
                      ),
                  );
                } ,
                itemCount: mealData.ingredients.length,),
              context
            ),
            textConatinerWidget('Steps', context),
            containerBuilder(ListView.builder(itemBuilder:(ctx,index){
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(child: Text('# ${index+1}'),),
                    title: Text(mealData.steps[index]),
                  ),
                  Divider(),
                ],
              );
            } ,itemCount: mealData.steps.length,), context),
          ],
        ),
      ),
      floatingActionButton:Platform.isAndroid?FloatingActionButton(
        child: widget.isFavorite(argsID)? Icon(Icons.favorite):Icon(Icons.favorite_border),
        onPressed:(){
          setState(() {
            widget.addAndDeleteFavoriteMeal(argsID);
          });
        }
      ):null,
    );
  }
}