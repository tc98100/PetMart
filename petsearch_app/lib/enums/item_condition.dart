import 'package:flutter/material.dart';

enum ItemCondition { brandNew, usedExcellent, usedGood, usedFair, other }

ItemCondition itemConditionFromInt(int input) {
  switch (input) {
    case 0:
      return ItemCondition.brandNew;
    case 1:
      return ItemCondition.usedExcellent;
    case 2:
      return ItemCondition.usedGood;
    case 3:
      return ItemCondition.usedFair;
    default:
      return ItemCondition.other;
  }
}

int itemConditionToInt(ItemCondition cond) {
  switch (cond) {
    case ItemCondition.brandNew:
      return 0;
    case ItemCondition.usedExcellent:
      return 1;
    case ItemCondition.usedGood:
      return 2;
    case ItemCondition.usedFair:
      return 3;
    default:
      return 4;
  }
}

String itemConditionToString(ItemCondition cond) {
  switch (cond) {
    case ItemCondition.brandNew:
      return 'Brand New';
    case ItemCondition.usedExcellent:
      return 'Used - Excellent';
    case ItemCondition.usedGood:
      return 'Used - Good';
    case ItemCondition.usedFair:
      return 'Used - Fair';
    default:
      return "other";
  }
}

List<Widget> itemConditionList = [
  Text("Brand new"),
  Text("Used - Excellent"),
  Text("Used - Good"),
  Text("Used - Fair"),
  Text("other"),
];

String itemCondition(int input) {
  switch (input) {
    case 0:
      return 'brandNew';
    case 1:
      return 'usedExcellent';
    case 2:
      return 'usedGood';
    case 3:
      return 'usedFair';
    default:
      return "Other";
  }
}
