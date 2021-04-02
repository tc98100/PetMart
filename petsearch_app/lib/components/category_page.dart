import 'package:cupertino_store/backend/product_services.dart';
import 'package:cupertino_store/components/category_list.dart';
import 'package:cupertino_store/components/product_page.dart';
import 'package:cupertino_store/components/segmented_control.dart';
import 'package:cupertino_store/models/category_list_data.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  final CategoryListData petList;
  final CategoryListData accessoryList;

  CategoryPage(this.title, this.petList, this.accessoryList);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // State Variables
  int isPetsOrAccessories = PET_VALUE;
  bool textInField = false;
  List<String> userInput;

  getResult(bool, string) {
    setState(() {
      textInField = bool;
      userInput = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.scaffoldBackgroundColor,
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(
            backgroundColor: appTheme.scaffoldBackgroundColor,
            padding: EdgeInsetsDirectional.zero,
            leading: CupertinoNavigationBarBackButton(
              color: appTheme2.accentColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            largeTitle: Text(
              widget.title,
              style: gradientText(30),
            )),
        isPetsOrAccessories == PET_VALUE
            ? CategoryList(widget.petList)
            : CategoryList(widget.accessoryList),
        SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ]),
    );
  }
}

class SearchResult extends StatefulWidget {
  final _CategoryPageState parent;

  SearchResult(this.parent);

  @override
  _SearchResultState createState() => _SearchResultState(parent);
}

class _SearchResultState extends State<SearchResult> {
  _SearchResultState(this.parent);
  _CategoryPageState parent;
  @override
  Widget build(BuildContext context) {
    bool isSearchForPets = parent.isPetsOrAccessories == PET_VALUE;
    return new StreamProvider<List<Product>>.value(
      value: ProductService().searchResults(parent.userInput, isSearchForPets),
      child: SearchResults(),
    );
  }
}

class SearchResults extends StatefulWidget {
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    final petListing = Provider.of<List<Product>>(context) ?? [];

    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        return FlatButton(
          onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => ProductPage(
                    product: petListing[index],
                  ))),
          child: Card(
            color: appTheme.scaffoldBackgroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Row(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  petListing[index].fbsPath,
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              ),
              SizedBox(width: 10),
              Row(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 3,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 10, 5, 0),
                          child: Row(
                            children: <Widget>[
                              Text(petListing[index].name ?? "placeholder",
                                  style: TextStyle(
                                      color: appTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text(
                                "\$" + petListing[index].price.toString(),
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.location,
                              color: Colors.blueAccent,
                              size: (20),
                            ),
                            Text(
                              "\$" + petListing[index].price.toString(),
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Row(children: <Widget>[
                          Icon(
                            CupertinoIcons.location,
                            color: Colors.blueAccent,
                            size: (20),
                          ),
                          Text(
                            petListing[index].location,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          )
                        ]),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0, top: 4),
                              child: Text(
                                petListing[index].description,
                                style: TextStyle(
                                    height: 1.25, color: Colors.white),
                                maxLines: (MediaQuery.of(context).size.height /
                                        15 /
                                        20)
                                    .round(),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Icon(
                  CupertinoIcons.chevron_compact_right,
                  color: Colors.blueAccent,
                )
              ]),
            ]),
          ),
        );
      },
      childCount: petListing.length,
    ));
  }
}
