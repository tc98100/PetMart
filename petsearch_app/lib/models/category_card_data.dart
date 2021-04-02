import 'package:flutter/cupertino.dart';

class CategoryCardData {
  String imgPath;
  String cardName;
  Widget path;
  String dataBaseName;
  String petSize;
  bool isItem = false; // Default to false for pets
  CategoryCardData(
      {this.imgPath,
      this.cardName,
      this.path,
      this.dataBaseName,
      this.petSize,
      this.isItem});
}
