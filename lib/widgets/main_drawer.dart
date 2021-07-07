import '../screens/filter_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTale(String title, IconData icon, Function handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor,
          height: MediaQuery.of(context).size.height / 6,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            'Cooking up!',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor,
              fontSize: 30,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        buildListTale('Meals', Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTale('Filters', Icons.settings, () {
          Navigator.of(context)
              .pushReplacementNamed(FilterScreen.filterScreenKey);
        })
      ],
    ));
  }
}
