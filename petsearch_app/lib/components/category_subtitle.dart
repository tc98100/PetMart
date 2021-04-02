import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CategorySubtitle extends StatelessWidget {
  final String data;
  CategorySubtitle(this.data);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Text(this.data, style: gradientText(30))),
    );
  }
}
