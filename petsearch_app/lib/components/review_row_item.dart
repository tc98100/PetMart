import 'package:cupertino_store/models/review_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../theme.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    this.index,
    this.review,
    this.lastItem,
    this.profile,
  });

  final ReviewData review;
  final int index;
  final bool lastItem;
  final String profile;

  @override
  Widget build(BuildContext context) {
    // Get profile picture
    Widget avatar;
    if (profile == null || profile == '') {
      avatar = Icon(CupertinoIcons.person);
    } else {
      avatar = Image.network(profile, fit: BoxFit.cover);
    }

    final row = SafeArea(
        top: false,
        bottom: false,
        minimum: EdgeInsets.only(
          left: 0,
          top: MediaQuery.of(context).size.height * padding,
          bottom: MediaQuery.of(context).size.height * padding,
          right: MediaQuery.of(context).size.height * padding,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * padding,
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: Colors.white.withOpacity(0),
                child: ClipOval(
                    child: new SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08 * 2,
                        height: MediaQuery.of(context).size.width * 0.08 * 2,
                        child: avatar))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * padding * 2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    padding),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    Text(review.name,
                                        style: gradientText(
                                            MediaQuery.of(context).size.height *
                                                titleSize)),
                                  ]),
                                  Column(children: <Widget>[
                                    SmoothStarRating(
                                      isReadOnly: true,
                                      allowHalfRating: true,
                                      filledIconData: CupertinoIcons.star_fill,
                                      halfFilledIconData:
                                          CupertinoIcons.star_lefthalf_fill,
                                      defaultIconData: CupertinoIcons.star,
                                      starCount: 5,
                                      rating: review.rating,
                                      size: MediaQuery.of(context).size.height *
                                          titleSize,
                                      color: appTheme.primaryColor,
                                      borderColor: appTheme.primaryColor,
                                    ),
                                  ]),
                                ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    padding),
                            child: Text(review.message,
                                style: regularFont(
                                    MediaQuery.of(context).size.height *
                                        normalSize)),
                          ),
                        ]))),
          ]),
        ));

    return Column(children: <Widget>[
      row,
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * padding),
          child: Container(
            height: 1,
            color: appTheme.primaryColor,
          ))
    ]);
  }
}
