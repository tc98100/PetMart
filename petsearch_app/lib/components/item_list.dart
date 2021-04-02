import 'package:cupertino_store/components/item_list_rows.dart';
import 'package:cupertino_store/models/listing_page_data.dart';
import 'package:flutter/cupertino.dart';

class ItemList extends StatefulWidget {
  final ListingPageData data;

  ItemList(this.data);

  @override
  _ItemListState createState() => _ItemListState(data);
}

class _ItemListState extends State<ItemList> {
  _ItemListState(this.data);
  final ListingPageData data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          largeTitle: Text(
            data.title,
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ItemListRows(data.products[index]);
        },
        childCount: data.products.length,
      )),
      SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).size.height / 9)),
    ]);
  }
}
