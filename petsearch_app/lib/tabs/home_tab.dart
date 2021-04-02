import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/components/pet_page.dart';
import 'package:cupertino_store/models/pet.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/tabs/reviews_screen.dart';
import 'package:cupertino_store/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_store/backend/product_services.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class HomeTab extends StatefulWidget {
  static const String route = 'home';

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey _home = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Pet>>.value(
      value: ProductService().pets,
      child: HomeTabContent(),
    );
  }
}

class HomeTabContent extends StatefulWidget {
  @override
  _HomeTabContentState createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();

    return StreamBuilder(
        stream: productService.pets,
        builder: (context, snapshot) {
          List<Product> petList = [];
          if (snapshot.hasData) {
            petList = snapshot.data;
          } else if (snapshot.connectionState != ConnectionState.done) {
            return LoadingScreen(message: 'Loading Pets ...');
          }

          return StreamBuilder(
              stream: productService.items,
              builder: (context, snapshot) {
                List<Product> itemList = [];
                if (snapshot.hasData) {
                  itemList = snapshot.data;
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return LoadingScreen(message: 'Loading Pets ...');
                }
                List<Product> productList = [];

                productList.addAll(petList);
                productList.addAll(itemList);

                if (productList.isEmpty) {
                  return Container(
                      child: Text('There are currently no active listings.'));
                }

                // Sort most recent to oldest
                Product.sortByTimestamp(productList, true);

                return Container(
                    color: appTheme2.backgroundColor,
                    child: SafeArea(
                      child: CustomScrollView(slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoNavigationBar(
                                  backgroundColor: appTheme2.backgroundColor,
                                  middle: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.paw_solid),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Paws and Play',
                                        style: gradientText(30),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return StreamBuilder<UserModel>(
                                stream: UserService(productList[index].sellerId)
                                    .userInfo,
                                builder: (context, snapshot) {
                                  UserModel seller;
                                  String name = '';
                                  if (snapshot.hasData) {
                                    seller = snapshot.data;
                                    name = seller.firstName +
                                        ' ' +
                                        seller.lastName;
                                  } else if (snapshot.connectionState !=
                                      ConnectionState.done) {
                                    // Return blank lines until we've finished loading users
                                    return Text('');
                                  }

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  User user = FirebaseAuth
                                                      .instance.currentUser;
                                                  if (user == null ||
                                                      user.uid !=
                                                          seller.userId) {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pushNamed(
                                                            ReviewScreen.route,
                                                            arguments: seller);
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0),
                                                        child: ClipOval(
                                                            child: SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Image.network(
                                                              seller
                                                                  .profilePath,
                                                              fit:
                                                                  BoxFit.cover),
                                                        ))),
                                                    SizedBox(width: 10),
                                                    Text('$name',
                                                        style: title(18)),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: CupertinoButton(
                                                    onPressed: () {
                                                      final actionSheet =
                                                          CupertinoActionSheet(
                                                        actions: <Widget>[
                                                          CupertinoActionSheetAction(
                                                            onPressed: () {},
                                                            child: Text(
                                                                'Copy link to post'),
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            onPressed: () {},
                                                            child: Text(
                                                                'Share post'),
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Report',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .redAccent,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                      showCupertinoModalPopup(
                                                          context: context,
                                                          builder: (context) =>
                                                              actionSheet);
                                                    },
                                                    child: Icon(
                                                      CupertinoIcons.ellipsis,
                                                      color:
                                                          appTheme2.accentColor,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: OverflowBox(
                                            maxWidth: double.infinity,
                                            alignment: Alignment.center,
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  UnconstrainedBox(
                                                      constrainedAxis:
                                                          Axis.vertical,
                                                      child: Image.network(
                                                          productList[index]
                                                              .fbsPath,
                                                          fit: BoxFit.cover))
                                                ])),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            // decoration: gradient,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        productList[index].name,
                                                        style: title(18)),
                                                    Text(
                                                      '\$ ${productList[index].price.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(productList[index]
                                                    .description),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CupertinoButton(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      onPressed: () => Navigator
                                                              .of(context)
                                                          .push(CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  ProductPage(
                                                                      productList[
                                                                          index]))),
                                                      child: Text('See more',
                                                          style: TextStyle(
                                                              color: appTheme2
                                                                  .accentColor)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          childCount: productList.length,
                        ))
                      ]),
                    ));
              });
        });
  }
}
