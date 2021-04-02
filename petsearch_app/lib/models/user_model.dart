import 'dart:io';

class UserModel {
  String userId;
  String firstName;
  String lastName;
  String username;
  int sumRatings;
  int countRatings;
  File profilePhoto;
  String profilePath;
  String bio;

  UserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.username,
      this.sumRatings,
      this.countRatings,
      this.profilePhoto,
      this.profilePath,
      this.bio});

  // `getRating`
  //
  // Calculates the average rating of the user
  double getRating() {
    if (countRatings == 0) {
      return 0.0;
    }
    return sumRatings / countRatings;
  }

  // `getUserFromUsername`
  //
  // Iterates a list of `UserModels` finding the username if it exists
  static UserModel getUserFromUsername(List<UserModel> users, String username) {
    for (UserModel user in users) {
      if (user.username == username) {
        return user;
      }
    }
    return null;
  }
}
