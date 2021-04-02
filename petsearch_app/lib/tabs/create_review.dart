import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:cupertino_store/theme.dart';
import 'package:cupertino_store/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CreateReview extends StatefulWidget {
  static const String route = 'create_review';
  @override
  _CreateReviewState createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final _textController = TextEditingController();
  double rating = 0.0;
  UserModel aboutUser;
  UserModel byUser;

  @override
  Widget build(BuildContext context) {
    // Extract aboutUser from argument
    setState(() {
      aboutUser = ModalRoute.of(context).settings.arguments;
      byUser = Provider.of<UserModel>(context);
    });

    // Handle case where users are null
    if (aboutUser == null || byUser == null) {
      return Text("Not logged in OR no user selected");
    }

    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              color: appTheme.primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            middle: Text("Leave " + aboutUser.firstName + " A Review",
                style: gradientText(
                    MediaQuery.of(context).size.height * titleSize)),
            backgroundColor: appTheme.scaffoldBackgroundColor),
        child: ListView(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * morePadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SmoothStarRating(
                        isReadOnly: false,
                        allowHalfRating: false,
                        filledIconData: CupertinoIcons.star_fill,
                        halfFilledIconData: CupertinoIcons.star_lefthalf_fill,
                        defaultIconData: CupertinoIcons.star,
                        starCount: 5,
                        size: MediaQuery.of(context).size.width * 0.15,
                        spacing: MediaQuery.of(context).size.width * padding,
                        color: appTheme2.accentColor,
                        borderColor: appTheme2.accentColor,
                        onRated: (value) {
                          setState(() {
                            rating = value;
                          });
                        }),
                  ])),
          Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * separatorPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: DarkTextField(
                        obscureText: false,
                        placeholder: "Enter your comment...",
                        maxLines: 15,
                        controller: _textController,
                      ),
                    ),
                  ])),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical:
                      MediaQuery.of(context).size.height * separatorPadding,
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(children: <Widget>[
                      CustomButton(
                          child: Text("Cancel",
                              style: regularFont(
                                  MediaQuery.of(context).size.height *
                                      normalSize)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ]),
                    Column(children: <Widget>[
                      CustomButton(
                          child: Text("Submit",
                              style: regularFont(
                                  MediaQuery.of(context).size.height *
                                      normalSize)),
                          onPressed: () {
                            _handleSubmitted(_textController.text);
                            Navigator.of(context).pop();
                          })
                    ])
                  ])),
        ]));
  }

  // Create review
  void _handleSubmitted(String text) {
    // Send review to firebase.
    UserService userService = UserService(byUser.userId);
    userService.createReview(aboutUser, byUser.username, text, rating.toInt());
  }
}
