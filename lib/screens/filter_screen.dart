import '../widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const String filterScreenKey='/filter_screen';
  final Map<String,bool>currentStates;
  final Function filterMeals;

  FilterScreen(this.currentStates,this.filterMeals);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isGlutenFree=false,isVegan= false,isVegetarian= false,isLactoseFree= false;

  @override
  void initState(){
  isGlutenFree=widget.currentStates['Gluten'];
  isVegan= widget.currentStates['Vegan'];
  isVegetarian= widget.currentStates['Vegetarian'];
  isLactoseFree= widget.currentStates['Lactose'];
  super.initState();
  }

  Widget buildSwitches(String title,String description,bool currentValue,Function changeValue){
    return SwitchListTile(
      subtitle: Text(description),
      title: Text(title),
      value: currentValue, 
      onChanged: changeValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: (){
              Map<String,bool>returnedValue={
               'Gluten':isGlutenFree,
               'Vegan':isVegan,
               'Vegetarian':isVegetarian,
               'Lactose':isLactoseFree
              };
              widget.filterMeals(returnedValue);
              Navigator.of(context).pushReplacementNamed('/');
            }
          )
        ],
      ),
      body: Column(children: <Widget>[
        Container(padding: const EdgeInsets.all(20),
        child: Center(child: Text('Filter your meals.',style: Theme.of(context).textTheme.bodyText1,)),
        ),
        Expanded(child: ListView(children: <Widget>[
          buildSwitches(
            'Gluten-free', 
            'Only include gluten-free meals', 
            isGlutenFree, 
            (newValue){setState(() {
              isGlutenFree=newValue;
              });
            }
          ),
          buildSwitches(
            'Lactose-free', 
            'Only include lactose-free meals', 
            isLactoseFree, 
            (newValue){setState(() {
              isLactoseFree=newValue;
              });
            }
          ),
          buildSwitches(
            'Vegetarian', 
            'Only include vegetarian meals', 
            isVegetarian, 
            (newValue){setState(() {
              isVegetarian=newValue;
              });
            }
          ),
          buildSwitches(
            'Vegan', 
            'Only include vegan meals', 
            isVegan, 
            (newValue){setState(() {
              isVegan=newValue;
              });
            }
          )
        ],))
      ],),
      drawer: MainDrawer(),
    );
  }
}