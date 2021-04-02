import 'package:cupertino_store/backend/product_services.dart';
import 'package:cupertino_store/components/accessory_page.dart';
import 'package:cupertino_store/components/product_page.dart';
import 'package:cupertino_store/models/pet.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListingPageBase extends StatefulWidget {
  static const String route = "content";

  @override
  _ListingPageBaseState createState() => _ListingPageBaseState();
}

class _ListingPageBaseState extends State<ListingPageBase> {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    return StreamProvider<List<Product>>.value(
      value: data['isItem']
          ? ProductService()
              .itemsForCategory(data['petName'].toString().toLowerCase())
          : ProductService().petsForCategory(
              data['petName'] == null
                  ? data['title']
                  : data['petName'].toUpperCase().toString().substring(0, 1) +
                      data['petName'].substring(1),
              data['size']),
      // : ProductService().petsForCategory(
      //     data['petName'] == null
      //         ? data['title']
      //         : data['petName'].toUpperCase().toString().substring(0, 1) +
      //             data['petName'].substring(1),
      //     data['size']),
      child: ListingPage(data['title']),
    );
  }
}

class ListingPage extends StatefulWidget {
  final String category;

  ListingPage(this.category);

  @override
  _ListingPageState createState() => _ListingPageState(this.category);
}

class _ListingPageState extends State<ListingPage> {
  String category;

  _ListingPageState(this.category);

  @override
  Widget build(BuildContext context) {
    final petListing = Provider.of<List<Product>>(context) ?? [];

    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            backgroundColor: appTheme.scaffoldBackgroundColor,
            leading: CupertinoNavigationBarBackButton(
              color: appTheme.primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            largeTitle: Text(
              this.category,
              style: gradientText(30),
            )),
        petListing.isEmpty
            ? SliverToBoxAdapter(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                        "Sorry, there are no listings in the marketplace.")),
              ))
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FlatButton(
                    onPressed: () => {
                      if (petListing[index] is Pet)
                        {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => ProductPage(
                                    product: petListing[index],
                                  )))
                        }
                      else
                        {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => AccessoryPage(
                                    product: petListing[index],
                                  )))
                        }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: appTheme.scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              petListing[index].fbsPath ??
                                  "https://images.theconversation.com/files/93616/original/image-20150902-6700-t2axrz.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1000&fit=clip",
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 4,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          2, 10, 5, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              child: Text(
                                                  petListing[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color:
                                                          appTheme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ),
                                          ),
                                          Text(
                                            "\$" +
                                                petListing[index]
                                                    .price
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.green),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          petListing[index].location,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent),
                                        ),
                                      )
                                    ]),
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, top: 4),
                                          child: Text(
                                            petListing[index].description,
                                            style: TextStyle(
                                                height: 1.25,
                                                color: Colors.white),
                                            maxLines: (MediaQuery.of(context)
                                                        .size
                                                        .height /
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
                    ),
                  );
                },
                childCount: petListing.length,
              )),
      ]),
    );
  }
}
