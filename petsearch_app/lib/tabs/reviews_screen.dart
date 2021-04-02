import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/components/review_row_item.dart';
import 'package:cupertino_store/models/review_data.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_store/theme.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../theme.dart';
import '../utils.dart';
import 'create_review.dart';

class ReviewScreen extends StatefulWidget {
  static const String route = 'review_page';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    // Create `UserService` for the current user
    UserModel currentUser = Provider.of<UserModel>(context);
    String currentUserId = '';
    if (currentUser != null) {
      currentUserId = currentUser.userId;
    }
    UserService userService = UserService(currentUserId);

    // Extract viewedUser information (the user who's page we are viewing)
    final UserModel viewedUser = ModalRoute.of(context).settings.arguments;

    return StreamBuilder<List<ReviewData>>(
        stream: userService.getReviews(viewedUser.userId),
        builder: (context, snapshot) {
          // Get reviews if they exist
          List<ReviewData> reviews = [];
          if (snapshot.hasData) {
            reviews = snapshot.data;
          }

          // Check if current user has already left a review
          bool hasLeftReview = true; // set `true` if no current user
          if (currentUser != null) {
            hasLeftReview =
                ReviewData.hasLeftReview(reviews, currentUser.username);
          }

          return Localizations(
              locale: const Locale('en', 'AUS'),
              delegates: <LocalizationsDelegate<dynamic>>[
                DefaultWidgetsLocalizations.delegate,
                DefaultMaterialLocalizations.delegate,
              ],
              child: CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  leading: CupertinoNavigationBarBackButton(
                    color: appTheme.primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  //this is removed in order to reuse this page, otherwise need "if, else"
                  //previousPageTitle: "User Profile",
                  backgroundColor: appTheme.scaffoldBackgroundColor,
                  middle: Text("Reviews", style: gradientText(20)),
                ),
                child: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: MediaQuery.of(context).size.height * 0.27,
                    pinned: false,
                    stretch: true,
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                        color: appTheme.scaffoldBackgroundColor,
                      ),
                      child: Container(
                        child: UserProfile(
                          viewedUser: viewedUser,
                          currentUser: currentUser,
                          hasLeftReview: hasLeftReview,
                        ),
                      ),
                    ),
                    bottom: PreferredSize(
                        child: Column(children: <Widget>[
                      Container(
                        width: 0.0,
                        height: 0.0,
                      ),
                    ])),
                  ),
                  SliverSafeArea(
                      top: false,
                      sliver: SliverList(delegate:
                          SliverChildBuilderDelegate((context, index) {
                        if (index < reviews.length) {
                          return StreamBuilder(
                            stream: userService
                                .getUserByUsername(reviews[index].name),
                            builder: (context, snapshot) {
                              // The user who has left the review
                              String profilePath;
                              if (snapshot.hasData) {
                                UserModel reviewerProfile = snapshot.data;
                                profilePath = reviewerProfile.profilePath;
                              }

                              return ReviewItem(
                                index: index,
                                review: reviews[index],
                                lastItem: index == reviews.length - 1,
                                profile: profilePath,
                              );
                            },
                          );
                        }
                        return null;
                      }))),
                ]),
              ));
        });
  }
}

class UserProfile extends StatelessWidget {
  final UserModel viewedUser;
  final UserModel currentUser;
  final bool hasLeftReview;

  UserProfile({this.viewedUser, this.currentUser, this.hasLeftReview});

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
        background: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * padding),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * padding),
                          child: CircleAvatar(
                              radius: (MediaQuery.of(context).size.width)
                                      .toDouble() *
                                  0.1,
                              backgroundColor: Colors.white.withOpacity(0),
                              child: ClipOval(
                                  child: new SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1 *
                                          2,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1 *
                                              2,
                                      child: new Image.network(
                                          viewedUser.profilePath,
                                          fit: BoxFit.cover)))))
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * padding,
                            top: MediaQuery.of(context).size.height * padding,
                          ),
                          child: Text(
                            viewedUser.firstName + " " + viewedUser.lastName,
                            style: gradientText(
                                MediaQuery.of(context).size.height *
                                    headerSize),
                          ),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * padding),
                            child: SmoothStarRating(
                              isReadOnly: true,
                              allowHalfRating: true,
                              filledIconData: CupertinoIcons.star_fill,
                              halfFilledIconData:
                                  CupertinoIcons.star_lefthalf_fill,
                              defaultIconData: CupertinoIcons.star,
                              starCount: 5,
                              rating: viewedUser.getRating(),
                              size: MediaQuery.of(context).size.height *
                                  headerSize,
                              color: appTheme2.accentColor,
                              borderColor: appTheme2.accentColor,
                            )),
                      ])
                    ])
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * padding),
                        child: Text("Bio",
                            style: gradientText(
                                MediaQuery.of(context).size.height *
                                    titleSize)),
                      ),
                    ]),
                    Column(children: <Widget>[
                      getReviewButton(context),
                    ])
                  ]),
              Row(children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * padding),
                  child: Text(
                    viewedUser.bio,
                    style:
                        title(MediaQuery.of(context).size.height * normalSize),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ]),
              Container(
                height: 1,
                color: appTheme.primaryColor,
              ),
            ])));
  }

  // `getReviewButton`
  //
  // Create button to leave a review if we have not already left a review.
  Widget getReviewButton(BuildContext context) {
    // Check if we should display `leave a review` button.
    bool shouldLeaveReview = true;
    if (currentUser == null || viewedUser == null) {
      shouldLeaveReview = false;
    } else if (currentUser == viewedUser) {
      shouldLeaveReview = false;
    } else if (hasLeftReview) {
      shouldLeaveReview = false;
    }

    // Create button if we have not previously left a review (and are not viewing ourself)
    if (shouldLeaveReview) {
      return Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * padding),
          child: CustomButton(
              child: Text("Leave a Review",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          MediaQuery.of(context).size.height * normalSize)),
              onPressed: () => {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      CreateReview.route,
                      arguments: viewedUser,
                    ),
                  }));
    }

    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * padding),
    );
  }
}
