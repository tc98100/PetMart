import 'package:cupertino_store/models/category_card_data.dart';

class CategoryListData {
  List<CategoryCardData> cards = <CategoryCardData>[];
  String title;

  CategoryListData({this.cards, this.title});
}
