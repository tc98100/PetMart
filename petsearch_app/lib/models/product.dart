import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String pid;
  List<File> photos;
  String name;
  double price;
  String description;
  String location;
  String sellerId;
  String category;
  // List<String> imgPaths;
  String fbsPath;
  Timestamp timestamp;
  int clickCount;
  List<String> searchIndex;

  Product({
    this.pid,
    this.photos,
    this.name,
    this.price,
    this.description,
    this.location,
    this.sellerId,
    // this.imgPaths,
    this.fbsPath,
    this.timestamp,
    this.clickCount,
    this.category,
    this.searchIndex,
  });

  void addChecker(String input, List<String> list) {
    List<String> splitList = input.split(" ");
    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + 1; j++) {
        String element = splitList[i].substring(0, j).toLowerCase();
        if (list.contains(element)) {
          continue;
        } else {
          list.add(element);
        }
      }
    }
  }

  void setUpSearchIndex() {
    searchIndex = new List<String>();
    for (String i in description.split(" ")) {
      addChecker(i.toLowerCase(), searchIndex);
    }
    addChecker(name.toString().toLowerCase(), searchIndex);
    addChecker(category.toString().toLowerCase(), searchIndex);
    addChecker(location.toString().toLowerCase(), searchIndex);
    searchIndex.removeAt(0);
  }

  // `sortByPrice`
  //
  // Sorts the products by price.
  // `lowToHigh` set to true will sort the lowest priced product as the first
  // product in the list.
  static void sortByPrice(List<Product> products, bool lowToHigh) {
    if (lowToHigh) {
      // index 0 is the cheapest
      products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      // index 0 is most expensive
      products.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  // `sortByTimestamp`
  //
  // Sorts the products based off the timestamp
  // Set `isRecentFirst` to true for most recent first
  static void sortByTimestamp(List<Product> products, bool isRecentFirst) {
    if (isRecentFirst) {
      // index 0 is most recent timestamp
      products.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } else {
      // index 0 is oldest timestamp
      products.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    }
  }

  // `filterBySearchIndex`
  //
  // Removes all items from a list which do not contain all strings in `indexes`.
  static List<Product> filterBySearchIndex(
      List<Product> products, List<String> indexes) {
    List<Product> filteredProducts = products ?? [];
    for (String index in indexes) {
      if (index == null || index.isEmpty) {
        continue;
      }
      filteredProducts = filteredProducts
          .where((product) => product.searchIndex.contains(index))
          .toList();
    }
    return filteredProducts;
  }
}
