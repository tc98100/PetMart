import 'dart:ui';
import 'dart:io';
import 'dart:async';

import 'package:cupertino_store/backend/image_service.dart';
import 'package:cupertino_store/backend/product_services.dart';
import 'package:cupertino_store/enums/accessory_category.dart';
import 'package:cupertino_store/enums/item_condition.dart';
import 'package:cupertino_store/models/accessory.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class CreateAccessoryListingForm extends StatefulWidget {
  static const String route = 'accessory_item_listing';

  _CreateAccessoryListingFormState createState() =>
      _CreateAccessoryListingFormState();
}

class _CreateAccessoryListingFormState
    extends State<CreateAccessoryListingForm> {
  final GlobalKey formKey = GlobalKey<FormState>();
  String message = 'Creating a post for you';
  bool isLoading = false;

  Accessory _product = Accessory();

  Future _openCamera() async {
    var _media = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (_media != null) {
        _product.photos.add(File(_media.path));
      }
    });
  }

  Future _openGallery() async {
    final _media = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (_media != null) {
        _product.photos.add(File(_media.path));
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      _product.photos.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _product.photos = [];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return isLoading
        ? LoadingScreen(
            message: message,
          )
        : CupertinoPageScaffold(
            backgroundColor: appTheme.scaffoldBackgroundColor,
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                color: appTheme2.accentColor,
              ),
              backgroundColor: appTheme.scaffoldBackgroundColor,
              middle: Text(
                'New Accessory Listing',
                style: gradientText(20),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add some photos',
                            style: gradientText(20),
                          ),
                          if (_product.photos?.isEmpty ?? true)
                            Container()
                          else
                            Container(
                              height: 160,
                              child: ListView.builder(
                                itemCount: _product.photos.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Align(
                                              alignment: Alignment.bottomCenter,
                                              heightFactor: 1,
                                              widthFactor: 0.75,
                                              child: Image.file(
                                                  _product.photos[index]))),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: GestureDetector(
                                          onTap: () => _removeImage(index),
                                          child: Icon(
                                            CupertinoIcons.xmark_circle_fill,
                                            color: Colors.red,
                                            size: 25,
                                          ),
                                        ))
                                  ]);
                                },
                              ),
                            ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.all(10.0),
                                  onPressed: () {
                                    _openCamera();
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    child: Card(
                                      color: Colors.grey.withOpacity(0.2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Icon(
                                        CupertinoIcons.photo_camera,
                                        color: appTheme2.accentColor,
                                      ),
                                    ),
                                  ),
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.all(10.0),
                                  onPressed: () {
                                    _openGallery();
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    child: Card(
                                        color: Colors.grey.withOpacity(0.2),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Icon(CupertinoIcons.photo,
                                            color: appTheme2.accentColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Info',
                            style: gradientText(20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DarkTextField(
                            obscureText: false,
                            placeholder: 'Name of Product',
                            onChanged: (value) {
                              setState(() {
                                _product.name = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DarkTextField(
                            obscureText: false,
                            placeholder: 'Location',
                            onChanged: (value) {
                              setState(() {
                                _product.location = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DarkTextField(
                            obscureText: false,
                            placeholder: 'Price',
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '\$',
                                style: TextStyle(color: appTheme2.accentColor),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _product.price = double.parse(value);
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Description',
                            style: gradientText(20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DarkTextField(
                            obscureText: false,
                            placeholder: 'Describe the item',
                            maxLines: 5,
                            onChanged: (value) {
                              setState(() {
                                _product.description = value;
                              });
                            },
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                              onTap: () {
                                if (_product.category == null) {
                                  setState(() {
                                    _product.category =
                                        accessoryCategory(0).toLowerCase();
                                  });
                                }
                                showCupertinoModalPopup(
                                    semanticsDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 250,
                                        child: CupertinoPicker(
                                          backgroundColor: Colors.white,
                                          onSelectedItemChanged: (value) {
                                            setState(() {
                                              _product.category =
                                                  accessoryCategory(value)
                                                      .toLowerCase();
                                            });
                                          },
                                          itemExtent: 32.0,
                                          children: accessoryCategoryList,
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Categories'),
                                  Expanded(child: Container()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(_product.category ?? 'Select one',
                                      style: shadow),
                                  Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: appTheme2.accentColor,
                                  ),
                                ],
                              )),
                          SizedBox(height: 15),
                          GestureDetector(
                              onTap: () {
                                if (_product.condition == null) {
                                  setState(() {
                                    _product.condition = itemCondition(0);
                                  });
                                }
                                showCupertinoModalPopup(
                                    semanticsDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 250,
                                        child: CupertinoPicker(
                                          backgroundColor: Colors.white,
                                          onSelectedItemChanged: (value) {
                                            setState(() {
                                              _product.condition =
                                                  itemCondition(value);
                                            });
                                          },
                                          itemExtent: 32.0,
                                          children: itemConditionList,
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Condition'),
                                  Expanded(child: Container()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _product.condition ?? 'Select one',
                                    style: shadow,
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: appTheme2.accentColor,
                                  ),
                                ],
                              )),
                          SizedBox(height: 15),
                          Center(
                            child: CustomButton(
                              onPressed: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  _product.sellerId = user.userId;
                                  _product.setUpSearchIndex();
                                  ProductService productService =
                                      ProductService();
                                  ImageProcess imageProcess = ImageProcess();
                                  imageProcess
                                      .addProductImage(_product)
                                      .then((value) =>
                                          productService.createItem(_product))
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                } else {
                                  String title = "Not logged in";
                                  String content =
                                      "To be able to post, you have to log in first";
                                  AlertBox(
                                    title: title,
                                    content: content,
                                  ).dialog(context);
                                }
                              },
                              child: Text('Post',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          );
  }
}
