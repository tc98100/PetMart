import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/accessory.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/tabs/payment_tab.dart';
import 'package:cupertino_store/tabs/reviews_screen.dart';
import 'package:cupertino_store/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class AccessoryPage extends StatefulWidget {
  final Accessory product;

  const AccessoryPage({this.product});

  @override
  _AccessoryPageState createState() => _AccessoryPageState();
}

class _AccessoryPageState extends State<AccessoryPage> {
  @override
  Widget build(BuildContext context) {
    List<InfoItem> infoList = [
      InfoItem(
        icon: Container(),
        title: Text('Category'),
        info: Text(widget.product.category),
      ),
      InfoItem(
        icon: Container(),
        title: Text('Condition'),
        info: Text(widget.product.condition),
      )
    ];

    return StreamBuilder<UserModel>(
        stream: UserService(widget.product.sellerId).userInfo,
        builder: (context, snapshot) {
          UserModel currentUser;
          String name = '';
          if (snapshot.hasData) {
            currentUser = snapshot.data;
            name = currentUser.firstName + " " + currentUser.lastName;
          } else if (snapshot.connectionState != ConnectionState.done) {
            return LoadingScreen(message: 'Loading data please wait ...');
          }

          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: appTheme.primaryColor,
              ),
              backgroundColor: appTheme.scaffoldBackgroundColor,
              middle: Text('${widget.product.name}', style: gradientText(20)),
              trailing: CupertinoButton(
                  onPressed: () {
                    final actionSheet = CupertinoActionSheet(
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          onPressed: () {},
                          child: Text('Copy link to post'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {},
                          child: Text('Share post'),
                        ),
                        CupertinoActionSheetAction(
                          onPressed: () {},
                          child: Text(
                            'Report',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    );
                    showCupertinoModalPopup(
                        context: context, builder: (context) => actionSheet);
                  },
                  child: Icon(CupertinoIcons.ellipsis)),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
//                            itemCount: widget.product.photos.length,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return FittedBox(
                                child: Image.network(widget.product.fbsPath),
                                fit: BoxFit.fill,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 5,
                            children: [
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          CupertinoIcons.placemark,
                                          color: appTheme2.accentColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text('${widget.product.location}')
                                      ],
                                    ),
                                  )),
                              Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.money_dollar,
                                          color: appTheme2.accentColor,
                                          size: 20,
                                        ),
                                        Text(
                                            '${widget.product.price.toStringAsFixed(2)}'),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Description', style: header),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${widget.product.description}'),
                          Row(
                            children: [
                              Column(
                                children: [],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Info', style: header),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                              itemCount: infoList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 35,
                                  child: Row(
                                    children: [
                                      infoList[index].icon,
                                      infoList[index].title,
                                      Spacer(),
                                      infoList[index].info
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text('More about the seller', style: header),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      User user =
                                          FirebaseAuth.instance.currentUser;
                                      if (user == null ||
                                          user.uid != currentUser.userId) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(ReviewScreen.route,
                                                arguments: currentUser);
                                      }
                                    },
                                    child: CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(0),
                                        child: ClipOval(
                                            child: SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: Image.network(
                                                    snapshot.data.profilePath,
                                                    fit: BoxFit.cover))))),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(name),
                                    Text(
                                        'Rating: ${currentUser.getRating().toStringAsFixed(2)}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: CustomButton(
                                child: Text('Contact seller',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    if (currentUser != null &&
                                        FirebaseAuth.instance.currentUser.uid !=
                                            currentUser.userId) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed(
                                        "chat_page",
                                        arguments: currentUser,
                                      );
                                    } else {
                                      // Failed to fetch user from database
                                      print(
                                          "Could not retrieve user before being selected");
                                    }
                                  } else {
                                    String title = "Not Logged in";
                                    String content =
                                        "To be able to contact the seller, you need to log in";
                                    AlertBox(
                                      title: title,
                                      content: content,
                                    ).dialog(context);
                                  }
                                }),
                          ),
                          SizedBox(height: 30),
                          Center(
                            child: CustomButton(
                                child: Text(
                                  'Buy now',
                                  style: TextStyle(color: Colors.white),
                                ),
                                //todo can't buy now if not logged in ?
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    if (FirebaseAuth.instance.currentUser.uid !=
                                        currentUser.userId) {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  PaymentForm(widget.product)));
                                    }
                                  } else {
                                    String title = "Not Logged in";
                                    String content =
                                        "To be able to buy this item, you need to log in";
                                    AlertBox(
                                      title: title,
                                      content: content,
                                    ).dialog(context);
                                  }
                                }),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class InfoItem {
  final Widget icon;
  final Widget title;
  final Widget info;

  const InfoItem({this.icon, this.title, this.info});
}
