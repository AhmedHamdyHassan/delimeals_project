import 'package:flutter/material.dart';
import '../Dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20),
        children: DUMMY_CATEGORIES
            .map((categoryData) => Padding(
                  padding: const EdgeInsets.all(3),
                  child: CategoryItem(
                    id: categoryData.id,
                    title: categoryData.title,
                    color: categoryData.color,
                  ),
                ))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ));
  }
}
