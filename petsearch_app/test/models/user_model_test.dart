import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:cupertino_store/models/user_model.dart';

void main() {
  // Test the constructor and getters
  test("Unit Test: UserModel - Constructor", () {
    // Variables
    String userId = 'test-id';
    String firstName = 'test-first';
    String lastName = 'test-last';
    String username = 'test-username';
    int sumRatings = 5;
    int countRatings = 1;
    File profilePhoto = File('profile-photo');
    String profilePath = 'profile-path';
    String bio = 'bio';

    // Create `UserModel`
    final UserModel user = UserModel(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      username: username,
      sumRatings: sumRatings,
      countRatings: countRatings,
      profilePhoto: profilePhoto,
      profilePath: profilePath,
      bio: bio,
    );

    // Ensure variables were set correctly
    expect(user.userId, userId);
    expect(user.firstName, firstName);
    expect(user.lastName, lastName);
    expect(user.username, username);
    expect(user.sumRatings, sumRatings);
    expect(user.countRatings, countRatings);
    expect(user.profilePhoto, profilePhoto);
    expect(user.profilePath, profilePath);
    expect(user.bio, bio);
  });

  test("Unit Test: UserModel - getUserFromUsername", () {
    // Create some test users
    String firstName = 'test-first';
    String lastName = 'test-last';
    int sumRatings = 5;
    int countRatings = 1;
    File profilePhoto = File('profile-photo');
    String profilePath = 'profile-path';
    String bio = 'bio';

    // Create `UserModel`
    final UserModel userA = UserModel(
      userId: 'idA',
      firstName: firstName,
      lastName: lastName,
      username: 'userA',
      sumRatings: sumRatings,
      countRatings: countRatings,
      profilePhoto: profilePhoto,
      profilePath: profilePath,
      bio: bio,
    );

    final UserModel userB = UserModel(
      userId: 'idB',
      firstName: firstName,
      lastName: lastName,
      username: 'userB',
      sumRatings: sumRatings,
      countRatings: countRatings,
      profilePhoto: profilePhoto,
      profilePath: profilePath,
      bio: bio,
    );

    final UserModel userC = UserModel(
      userId: 'idC',
      firstName: firstName,
      lastName: lastName,
      username: 'userC',
      sumRatings: sumRatings,
      countRatings: countRatings,
      profilePhoto: profilePhoto,
      profilePath: profilePath,
      bio: bio,
    );

    // Test Sorting high to low
    List<UserModel> userList = [userA, userB, userC];

    UserModel foundUser = UserModel.getUserFromUsername(userList, 'userB');

    expect(foundUser, userB);
  });
}
