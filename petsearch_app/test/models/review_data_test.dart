import 'package:cupertino_store/models/review_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  // Test the constructor and getters
  test("Unit Test: ReviewData - Constructor", () {
    // Variables
    Icon avatar = Icon(CupertinoIcons.person);
    String name = 'test-first';
    double rating = 1.1;
    String message = 'test-message';

    // Create `ReviewData`
    final ReviewData review = ReviewData(
      avatar: avatar,
      name: name,
      rating: rating,
      message: message,
    );

    // Ensure variables were set correctly
    expect(review.avatar, avatar);
    expect(review.rating, rating);
    expect(review.name, name);
    expect(review.message, message);
  });

  test("Unit Test: ReviewData - hasLeftReview false", () {
    // Create some test reviews
    Icon avatar = Icon(CupertinoIcons.person);
    double rating = 1.1;
    String message = 'test-message';

    final ReviewData reviewA = ReviewData(
      avatar: avatar,
      name: 'name-a',
      rating: rating,
      message: message,
    );

    final ReviewData reviewB = ReviewData(
      avatar: avatar,
      name: 'name-b',
      rating: rating,
      message: message,
    );

    final ReviewData reviewC = ReviewData(
      avatar: avatar,
      name: 'name-c',
      rating: rating,
      message: message,
    );

    List<ReviewData> reviewList = [reviewA, reviewB, reviewC];

    bool hasLeftReview = ReviewData.hasLeftReview(reviewList, 'gibberish');

    expect(hasLeftReview, false);
  });

  test("Unit Test: ReviewData - hasLeftReview true", () {
    // Create some test reviews
    Icon avatar = Icon(CupertinoIcons.person);
    double rating = 1.1;
    String message = 'test-message';

    final ReviewData reviewA = ReviewData(
      avatar: avatar,
      name: 'name-a',
      rating: rating,
      message: message,
    );

    final ReviewData reviewB = ReviewData(
      avatar: avatar,
      name: 'name-b',
      rating: rating,
      message: message,
    );

    final ReviewData reviewC = ReviewData(
      avatar: avatar,
      name: 'name-c',
      rating: rating,
      message: message,
    );

    List<ReviewData> reviewList = [reviewA, reviewB, reviewC];

    bool hasLeftReview = ReviewData.hasLeftReview(reviewList, 'name-b');

    expect(hasLeftReview, true);
  });
}
