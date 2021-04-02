import 'package:cupertino_store/models/pet.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/tabs/reviews_screen.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cupertino_store/backend/user_service.dart';

import '../theme.dart';
import 'accessory_page.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage(this.product);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.product is Pet) {
      return PetPage(product: widget.product);
    } else {
      return AccessoryPage(product: widget.product);
    }
  }
}

class PetPage extends StatefulWidget {
  final Pet product;

  const PetPage({this.product});

  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    List<InfoItem> infoList = [
      InfoItem(
        icon: Container(),
        title: Text('Category'),
        info: Text('${widget.product.category}'),
      ),
      InfoItem(
        icon: Container(),
        title: Text('Size'),
        info: Text('${widget.product.size}'),
      ),
      InfoItem(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: FaIcon(
            FontAwesomeIcons.heartbeat,
            size: 25,
            color: appTheme2.accentColor,
          ),
        ),
        title: Text('Health Check'),
        info: widget.product.healthCheck
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: appTheme2.accentColor,
              )
            : Icon(
                CupertinoIcons.multiply,
                color: appTheme2.accentColor,
              ),
      ),
      InfoItem(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: FaIcon(
            FontAwesomeIcons.microchip,
            size: 25,
            color: appTheme2.accentColor,
          ),
        ),
        title: Text('Microchip'),
        info: widget.product.microchip
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: appTheme2.accentColor,
              )
            : Icon(
                CupertinoIcons.multiply,
                color: appTheme2.accentColor,
              ),
      ),
      InfoItem(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SizedBox(
            height: 25,
            width: 25,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.genderless,
                size: 25,
                color: appTheme2.accentColor,
              ),
            ),
          ),
        ),
        title: Text('Desexed'),
        info: widget.product.desexed
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: appTheme2.accentColor,
              )
            : Icon(
                CupertinoIcons.multiply,
                color: appTheme2.accentColor,
              ),
      ),
      InfoItem(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: FaIcon(
            FontAwesomeIcons.syringe,
            size: 25,
            color: appTheme2.accentColor,
          ),
        ),
        title: Text('Vaccinated'),
        info: widget.product.vaccinated
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: appTheme2.accentColor,
              )
            : Icon(
                CupertinoIcons.multiply,
                color: appTheme2.accentColor,
              ),
      ),
      InfoItem(
        icon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: FaIcon(
            FontAwesomeIcons.bug,
            size: 25,
            color: appTheme2.accentColor,
          ),
        ),
        title: Text('Wormed'),
        info: widget.product.wormed
            ? Icon(
                CupertinoIcons.checkmark_alt,
                color: appTheme2.accentColor,
              )
            : Icon(
                CupertinoIcons.multiply,
                color: appTheme2.accentColor,
              ),
      ),
    ];

    return StreamBuilder<UserModel>(
        stream: UserService(widget.product.sellerId).userInfo,
        builder: (context, snapshot) {
          UserModel currentUser;
          String name = '';
          if (snapshot.hasData) {
            currentUser = snapshot.data;
            name = currentUser.firstName + " " + currentUser.lastName;
          } else {
            return LoadingScreen(message: "Loading product data");
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
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.venusMars,
                                          color: appTheme2.accentColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text('${widget.product.gender}')
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
                                      children: [
                                        Icon(
                                          CupertinoIcons.paw_solid,
                                          color: appTheme2.accentColor,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            (widget.product.ageYears == 0 ||
                                                    widget.product.ageYears ==
                                                        null)
                                                ? Container()
                                                : widget.product.ageYears == 1
                                                    ? Text(
                                                        '${widget.product.ageYears} year')
                                                    : Text(
                                                        '${widget.product.ageYears} years'),
                                            (widget.product.ageMonths == 0 ||
                                                    widget.product.ageMonths ==
                                                        null)
                                                ? Container()
                                                : widget.product.ageMonths == 1
                                                    ? Text(
                                                        ', ${widget.product.ageMonths} month')
                                                    : Text(
                                                        ', ${widget.product.ageMonths} months'),
                                          ],
                                        ),
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
                                              fit: BoxFit.cover),
                                        )))),
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
                          SizedBox(height: 10),
                          Text(
                            'No instant buy option for pets, please contact the seller for purchasing options.',
                            style: TextStyle(color: Colors.grey[600]),
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
