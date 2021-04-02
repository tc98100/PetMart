import 'package:cupertino_store/models/category_list_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'category_cards.dart';

class CategoryList extends StatelessWidget {
  final CategoryListData data;
  CategoryList(this.data);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return CategoryCards(data.cards[index]);
          },
          childCount: data.cards.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 10,
        ));
  }
}
