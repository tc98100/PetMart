import 'package:cupertino_store/models/product.dart';

class Accessory extends Product {
  String condition;
  String category;
  Accessory({
    pid,
    name,
    photos,
    price,
    description,
    location,
    sellerId,
    imgPaths,
    fbsPath,
    timestamp,
    clickCount,
    searchIndex,
    this.condition,
    this.category,
  }) : super(
          pid: pid,
          name: name,
          photos: photos,
          price: price,
          description: description,
          location: location,
          sellerId: sellerId,
          // imgPaths: imgPaths,
          fbsPath: fbsPath,
          timestamp: timestamp,
          clickCount: clickCount,
          searchIndex: searchIndex,
        );
}
