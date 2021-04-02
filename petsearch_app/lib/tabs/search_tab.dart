import 'package:cupertino_store/backend/product_services.dart';
import 'package:cupertino_store/components/accessory_page.dart';
import 'package:cupertino_store/components/category_list.dart';
import 'package:cupertino_store/components/product_page.dart';
import 'package:cupertino_store/components/search_bar.dart';
import 'package:cupertino_store/components/segmented_control.dart';
import 'package:cupertino_store/frontend_data/category_data.dart';
import 'package:cupertino_store/models/pet.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SearchTab extends StatefulWidget {
  static const String route = 'marketplace';

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  // Static Store of CategoryCards
  static CategoryData database = new CategoryData();

  // State Variables
  int isPetsOrAccessories = PET_VALUE;
  List<String> userInput;
  bool textInField = false;

  // Toggle Display of `Pets` vs `Accessories`
  setPetsOrAccessoriesToggle(val) {
    setState(() {
      isPetsOrAccessories = val;
    });
  }

  getResult(bool, string) {
    setState(() {
      textInField = bool;
      userInput = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoNavigationBar(
                  backgroundColor: appTheme2.backgroundColor,
                  middle: Text(
                    'Marketplace',
                    style: gradientText(30),
                  )),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: textInField
                ? null
                : SegmentedControl(
                    setPetsOrAccessoriesToggle, isPetsOrAccessories)),
        SearchBar(getResult, isPetsOrAccessories),
        textInField
            ? new SearchResult(this)
            : isPetsOrAccessories == PET_VALUE
                ? CategoryList(database.petList)
                : CategoryList(database.accessoryList),
        SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ]),
    );
  }
}

class SearchResult extends StatefulWidget {
  final _SearchTabState parent;

  SearchResult(this.parent);

  @override
  _SearchResultState createState() => _SearchResultState(parent);
}

class _SearchResultState extends State<SearchResult> {
  _SearchResultState(this.parent);

  _SearchTabState parent;

  @override
  Widget build(BuildContext context) {
    bool isSearchForPets = parent.isPetsOrAccessories == PET_VALUE;
    return new StreamBuilder<List<Product>>(
      stream: ProductService().searchResults(parent.userInput, isSearchForPets),
      builder: (context, snapshot) {
        // Add found products to the list
        List<Product> productList = [];
        if (snapshot.hasData) {
          productList = snapshot.data;
        }

        // Filter out products not in search index.
        productList =
            Product.filterBySearchIndex(productList, parent.userInput);

        return SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return FlatButton(
              onPressed: () => {
                if (productList[index] is Pet)
                  {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => ProductPage(
                          product: productList[index],
                        )))
                  }
                else
                  {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => AccessoryPage(
                          product: productList[index],
                        )))
                  }
              },
              child: Card(
                color: appTheme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Row(children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      productList[index].fbsPath,
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
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                          productList[index].name ?? "No name",
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: appTheme.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    ),
                                  ),
                                  Text(
                                    "\$" + productList[index].price.toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            Row(children: <Widget>[
                              Icon(
                                CupertinoIcons.location,
                                color: Colors.blueAccent,
                                size: (20),
                              ),
                              Text(
                                productList[index].location,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent),
                              )
                            ]),
                            Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 15,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 4),
                                  child: Text(
                                    productList[index].description,
                                    style: TextStyle(
                                        height: 1.25, color: Colors.white),
                                    maxLines:
                                        (MediaQuery.of(context).size.height /
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
                      color: appTheme.primaryColor,
                    )
                  ]),
                ]),
              ),
            );
          },
          childCount: productList.length,
        ));
      },
    );
  }
}
