import 'package:flutter/cupertino.dart';

class ReviewData {
  final Icon avatar;
  final String name;
  final double rating;
  final String message;

  const ReviewData({this.avatar, this.name, this.rating, this.message});

  // `hasLeftReview`
  //
  // Checks a list of reviews to see if a user has already left a review
  static bool hasLeftReview(List<ReviewData> reviews, String username) {
    for (ReviewData review in reviews) {
      if (review.name == username) {
        return true;
      }
    }
    return false;
  }
}
