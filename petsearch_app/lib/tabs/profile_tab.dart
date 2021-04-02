import 'dart:io';

import 'package:cupertino_store/backend/image_service.dart';
import 'package:cupertino_store/backend/product_services.dart';
import 'package:cupertino_store/models/pet.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/theme.dart';
import 'package:cupertino_store/tabs/profile_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utils.dart';
import 'reviews_screen.dart';

class ProfileTab extends StatefulWidget {
  static const String route = "profile";

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return ProfileTabContent();
  }
}

class ProfileTabContent extends StatefulWidget {
  @override
  _ProfileTabContentState createState() => _ProfileTabContentState();
}

class _ProfileTabContentState extends State<ProfileTabContent> {
  GlobalKey _globalKey = GlobalKey();

  Widget profileInfo(int itemsForSale, int reviews, double rating) {
    return Row(
      children: [
        Expanded(
            child: Column(
          children: [
            Text(
              "Items",
              style: gradientText(
                  MediaQuery.of(context).size.height * subtitleSize),
            ),
            Text(
              itemsForSale.toString(),
              style:
                  gradientText(MediaQuery.of(context).size.height * normalSize),
            )
          ],
        )),
        Expanded(
          child: Column(
            children: [
              Text(
                "Reviews",
                style: gradientText(
                    MediaQuery.of(context).size.height * subtitleSize),
              ),
              Text(
                reviews.toString(),
                style: gradientText(
                    MediaQuery.of(context).size.height * normalSize),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                "Rating",
                style: gradientText(
                    MediaQuery.of(context).size.height * subtitleSize),
              ),
              Text(
                rating.toString(),
                style: gradientText(
                    MediaQuery.of(context).size.height * normalSize),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return LoadingScreen(message: 'Loading ...');
    }
    List<Product> productListing = [];
    final List<Product> productsOnly = [];
    final List<Product> accessoriesOnly = [];

    // Load Pets
    return StreamBuilder(
        stream: ProductService().petsForUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            productsOnly.clear();
            productListing.clear();
            productsOnly.addAll(snapshot.data);
            productListing.addAll(productsOnly);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen(message: 'Loading user details ...');
          }

          // Load Accessories
          return StreamBuilder(
              stream: ProductService().itemsForUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  accessoriesOnly.clear();
                  accessoriesOnly.addAll(snapshot.data);
                  productListing.clear();
                  productListing = productsOnly + accessoriesOnly;
                }
                // Create profile page
                return profilePage(context, user, productListing);
              });
        });
  }

  Widget profilePage(
      BuildContext context, UserModel user, List<Product> productListing) {
    // Order products by most recent first
    Product.sortByTimestamp(productListing, true);

    return MaterialApp(
      title: "string",
      home: CupertinoPageScaffold(
        backgroundColor: Colors.grey[900],
        navigationBar: CupertinoNavigationBar(
          backgroundColor: appTheme.scaffoldBackgroundColor,
          middle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * allPadding),
                  child: Text(
                    user.firstName + "'s Profile",
                    style: gradientText(
                        MediaQuery.of(context).size.height * titleSize),
                  ),
                ),
                CupertinoButton(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.height * padding, 0),
                    child:
                        Icon(CupertinoIcons.settings, color: Colors.redAccent),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(ProfileSettings.route);
                    }),
              ]),
        ),
        child: CustomScrollView(key: _globalKey, slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.43,
            elevation: 100,
            pinned: false,
            collapsedHeight: 100,
            titleSpacing: 1,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: appTheme.scaffoldBackgroundColor,
              ),
              child: FlexibleSpaceBar(
                background: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            final actionSheet = CupertinoActionSheet(
                              title: Text(
                                'Update your profile picture',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      subtitleSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: Text('Take a photo now!'),
                                  onPressed: () async {
                                    var _media = await ImagePicker()
                                        .getImage(source: ImageSource.camera);
                                    setState(() {
                                      if (_media != null) {
                                        user.profilePhoto = File(_media.path);
                                      }
                                    });
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    ImageProcess().addProfileImage(user);
                                  },
                                ),
                                CupertinoActionSheetAction(
                                  child: Text('Select from my gallery!'),
                                  onPressed: () async {
                                    final _media = await ImagePicker()
                                        .getImage(source: ImageSource.gallery);
                                    setState(() {
                                      if (_media != null) {
                                        user.profilePhoto = File(_media.path);
                                        ImageProcess()
                                            .deleteImage(user.profilePath);
                                      }
                                    });
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    ImageProcess().addProfileImage(user);
                                  },
                                ),
                              ],
                            );
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) => actionSheet);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height *
                                    allPadding),
                            child: CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0),
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: ClipOval(
                                    child: new SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: new Image.network(
                                            user.profilePath,
                                            fit: BoxFit.cover)))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * allPadding),
                          child: Text(user.firstName + " " + user.lastName,
                              style: gradientText(
                                  MediaQuery.of(context).size.height *
                                      headerSize)),
                        ),
                        bio(user.bio),
                        SizedBox(
                          height: 5,
                        ),
                        profileInfo(productListing.length, user.countRatings,
                            user.getRating()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonTheme(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "View Reviews",
                                  style: regularFont(
                                      MediaQuery.of(context).size.height *
                                          normalSize),
                                ),
                                color: appTheme.primaryColor,
                                onPressed: () => {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(ReviewScreen.route,
                                          arguments: user),
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Divider(
                            color: Colors.red,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * padding),
                          child: Text(
                            "Products listed",
                            style: gradientText(
                                MediaQuery.of(context).size.height *
                                    subtitleSize),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Slidable(
                  child: Container(
                    decoration:
                        BoxDecoration(color: appTheme.scaffoldBackgroundColor),
                    child: Card(
                      color: appTheme.scaffoldBackgroundColor,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0.4),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(productListing[index].fbsPath),
                        ),
                        title: Text(
                          productListing[index].name,
                          style: gradientText(20),
                        ),
                        subtitle: Text(
                          productListing[index].description,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'delete',
                      color: Colors.red,
                      icon: CupertinoIcons.delete,
                      onTap: () {
                        if (productListing[index] is Pet) {
                          ProductService().deletePet(productListing[index].pid);
                        } else {
                          ProductService()
                              .deleteItem(productListing[index].pid);
                        }
                        ImageProcess()
                            .deleteImage(productListing[index].fbsPath);
                        setState(() {
                          productListing = productListing;
                        });
                      },
                    )
                  ],
                );
              },
              childCount: productListing.length,
            ),
          ),
          //userPet(context, petListing),
        ]),
      ),
    );
  }

  Widget bio(String bio) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * allPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "'" + bio + "'",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: MediaQuery.of(context).size.height * normalSize,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ));
  }
}
