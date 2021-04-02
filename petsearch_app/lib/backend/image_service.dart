import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageProcess {
  bool success = true;

  // `addProductImage`
  //
  // Adds an new image for a Product to the backend
  Future addProductImage(Product product) async {
    for (int i = 0; i < product.photos.length; i++) {
      StorageReference reference = FirebaseStorage.instance.ref();
      String imgPath = product.photos[i].path;
      String path = imgPath
          .substring(imgPath.lastIndexOf("/"), imgPath.lastIndexOf("."))
          .replaceAll("/", "");
      StorageTaskSnapshot snapshot = await reference
          .child("images/$path")
          .putFile(product.photos[i])
          .onComplete;
      if (snapshot.error == null) {
        final String path = await snapshot.ref.getDownloadURL();
        product.fbsPath = path;
      } else {
        print("add photo failed");
        success = false;
      }
    }
  }

  // `addProfileImage`
  //
  // Adds a new image for a user to the backend
  Future addProfileImage(UserModel user) async {
    StorageReference reference = FirebaseStorage.instance.ref();
    String imgPath = user.profilePhoto.path;
    String path = imgPath
        .substring(imgPath.lastIndexOf("/"), imgPath.lastIndexOf("."))
        .replaceAll("/", "");
    StorageTaskSnapshot snapshot = await reference
        .child("ProfileImages/$path")
        .putFile(user.profilePhoto)
        .onComplete;
    if (snapshot.error == null) {
      final String path = await snapshot.ref.getDownloadURL();
      UserService userService = UserService(user.userId);
      userService.updateProfile(path);
    } else {
      print("add photo failed");
      success = false;
    }
  }

  // `deleteImage`
  //
  // Deletes an image from the backend
  Future deleteImage(String path) async {
    String originalProfile =
        'https://firebasestorage.googleapis.com/v0/b/pet-research-43059.appspot.com/o/ProfileImages%2Fcomputer-icons-avatar-user-profile-png-favpng-HPjiNes3x112h0jw38sbfpDY9.jpg?alt=media&token=52c4f1aa-7c9c-4d84-9603-26d9641d5525';
    if (path != originalProfile) {
      FirebaseStorage.instance
          .getReferenceFromUrl(path)
          .then((value) => value.delete());
    }
  }
}
