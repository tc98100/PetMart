import 'dart:async';
import 'package:cupertino_store/models/review_data.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// A class for interacting with the "userInformation" collection
class UserService {
  // Stores the reference to the collection `userInformation`.
  static CollectionReference userInformation =
      FirebaseFirestore.instance.collection('userInformation');
  String userId = '';

  UserService(this.userId);

  /*
  * User Functions
  */

  // `addInfo`
  //
  // Sets the user details for this document base off the userId
  Future addInfo(
      String firstName, String lastName, String username, String bio) async {
    try {
      await userInformation.doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'sumRatings': 0,
        'countRatings': 0,
        'profilePath':
            'https://firebasestorage.googleapis.com/v0/b/pet-research-43059.appspot.com/o/ProfileImages%2Fcomputer-icons-avatar-user-profile-png-favpng-HPjiNes3x112h0jw38sbfpDY9.jpg?alt=media&token=52c4f1aa-7c9c-4d84-9603-26d9641d5525',
        'bio': bio,
      });
      print("user information added");
      return userInformation;
    } catch (e) {
      print(e.toString());
      print("error when adding users");
      return null;
    }
  }

  // `userData`
  //
  // Maps a `DocumentSnapshot` to `UserModel`
  UserModel userData(DocumentSnapshot documentSnapshot) {
    return UserModel(
      userId: userId,
      firstName: documentSnapshot.data()['firstName'] ?? '',
      lastName: documentSnapshot.data()['lastName'] ?? '',
      username: documentSnapshot.data()['username'] ?? '',
      sumRatings: documentSnapshot.data()['sumRatings'] ?? 0,
      countRatings: documentSnapshot.data()['countRatings'] ?? 0,
      profilePath: documentSnapshot.data()['profilePath'] ?? '',
      bio: documentSnapshot.data()['bio'] ?? '',
    );
  }

  // `userInfo`
  //
  // Return the stream of userInformation mapped to the `UserModel`
  Stream<UserModel> get userInfo {
    if (userId == '') {
      return Stream.value(null);
    }
    return userInformation.doc(userId).snapshots().map(userData);
  }

  // `updateInfo`
  //
  // Sends an asynchronous request to updates the fields `firstName`, `lastName`, `username`
  Future updateInfo(
      String firstName, String lastName, String username, String bio) async {
    try {
      await userInformation.doc(userId).update({
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'bio': bio,
      });
      print("user information updated");
      return userInformation;
    } catch (e) {
      print(e.toString());
      print("error when updating user info");
      return null;
    }
  }

  // `updateProfile`
  //
  // Sends an asynchronous request to update a user profile picture
  Future updateProfile(String path) async {
    try {
      await userInformation.doc(userId).update({
        'profilePath': path,
      });
      print("user profile picture updated");
      return userInformation;
    } catch (e) {
      print(e.toString());
      print("error when updating user profile picture");
      return null;
    }
  }

  // `getUserByUsername`
  //
  // Return the stream of a user looking up a username
  Stream<UserModel> getUserByUsername(String username) {
    return userInformation
        .where('username', isEqualTo: username)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return userData(querySnapshot.docs.first);
    });
  }

  // `getUserByUsername`
  //
  // Return a list of users from a list of usernames
  Stream<List<UserModel>> getUsersByUsername(List<String> usernames) {
    if (usernames.isEmpty) {
      return Stream.value(null);
    }

    return userInformation
        .where('username', whereIn: usernames)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(userData).toList();
    });
  }

  /*
  * Review Sub-collection Functions
  */

  // `getMyReviews`
  //
  // Get all reviews for this user
  Stream<List<ReviewData>> getMyReviews() {
    return userInformation
        .doc(userId)
        .collection("reviews")
        .snapshots()
        .map(reviewDataFromSnapshot);
  }

  // `getReviews`
  //
  // Get all reviews for a specific user
  Stream<List<ReviewData>> getReviews(String otherUserId) {
    return userInformation
        .doc(otherUserId)
        .collection("reviews")
        .snapshots()
        .map(reviewDataFromSnapshot);
  }

  // `createReview`
  //
  // Create a new review
  Future createReview(UserModel aboutUser, String byUsername,
      String description, int rating) async {
    try {
      // TODO: Do this in a single transaction, such that it can be validated by firestore rules.
      await userInformation.doc(aboutUser.userId).collection("reviews").add({
        "byUser": byUsername,
        "description": description,
        "rating": rating,
      });
      await userInformation.doc(aboutUser.userId).update({
        "sumRatings": FieldValue.increment(rating),
        "countRatings": FieldValue.increment(1),
      });
    } catch (e) {
      print("cannot create review");
    }
  }

  // `reviewDataFromSnapshot`
  //
  // Converts database snapshots to a list of `MessageData`
  static List<ReviewData> reviewDataFromSnapshot(QuerySnapshot snapshot) {
    List<ReviewData> ret = snapshot.docs.map((doc) {
      return ReviewData(
        // TODO: Icon
        avatar: Icon(CupertinoIcons.person),
        name: doc['byUser'] ?? '',
        rating: doc['rating'].toDouble() ?? 0.0,
        message: doc['description'] ?? '',
      );
    }).toList();
    return ret;
  }
}
