import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'dart:io';
import 'package:cupertino_store/models/product.dart';

void main() {
  // Test the constructor and getters
  test("Unit Test: Product - Constructor", () {
    // Variables
    String pid = 'pid-test';
    List<File> photos = [File('test.png')];
    String name = 'name-test';
    double price = 20.1;
    String description = 'description-test';
    String location = 'location-test';
    String sellerId = 'sellerId-test';
    String fbsPath = 'fbsPath-test';
    Timestamp timestamp = Timestamp.now();
    int clickCount = 1;
    String category = 'category-test';

    // Create `Product`
    final Product product = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: timestamp,
      clickCount: clickCount,
      category: category,
    );

    // Ensure variables were set correctly
    expect(product.pid, pid);
    expect(product.photos, photos);
    expect(product.name, name);
    expect(product.price, price);
    expect(product.description, description);
    expect(product.location, location);
    expect(product.sellerId, sellerId);
    expect(product.fbsPath, fbsPath);
    expect(product.timestamp, timestamp);
    expect(product.clickCount, clickCount);
    expect(product.category, category);
  });

  // Test Sorting by price, high to low
  test("Unit Test: Product - sortByPrice high to low", () {
    // Create some test products
    Product productA = Product(
      pid: 'pid-a',
      photos: [File('photo-a')],
      name: 'name-a',
      price: 13.1,
      description: 'description-a',
      location: 'location-a',
      sellerId: 'seller-a',
      category: 'dog',
      fbsPath: 'fbsPath-a',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    Product productB = Product(
      pid: 'pid-b',
      photos: [File('photo-b')],
      name: 'name-b',
      price: 13.11,
      description: 'description-b',
      location: 'location-b',
      sellerId: 'seller-b',
      category: 'cat',
      fbsPath: 'fbsPath-b',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    Product productC = Product(
      pid: 'pid-c',
      photos: [File('photo-c')],
      name: 'name-c',
      price: 0.0,
      description: 'description-c',
      location: 'location-c',
      sellerId: 'seller-c',
      category: 'cat',
      fbsPath: 'fbsPath-c',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    // Test Sorting high to low
    List<Product> productList = [productA, productB, productC];

    Product.sortByPrice(productList, false);

    expect(productList, [productB, productA, productC]);
  });

  // Test Sorting by price, low to high
  test("Unit Test: Product - sortByPrice low to high", () {
    // Create some test products
    Product productA = Product(
      pid: 'pid-a',
      photos: [File('photo-a')],
      name: 'name-a',
      price: 13.1,
      description: 'description-a',
      location: 'location-a',
      sellerId: 'seller-a',
      category: 'dog',
      fbsPath: 'fbsPath-a',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    Product productB = Product(
      pid: 'pid-b',
      photos: [File('photo-b')],
      name: 'name-b',
      price: 13.11,
      description: 'description-b',
      location: 'location-b',
      sellerId: 'seller-b',
      category: 'cat',
      fbsPath: 'fbsPath-b',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    Product productC = Product(
      pid: 'pid-c',
      photos: [File('photo-c')],
      name: 'name-c',
      price: 0.0,
      description: 'description-c',
      location: 'location-c',
      sellerId: 'seller-c',
      category: 'cat',
      fbsPath: 'fbsPath-c',
      timestamp: Timestamp.now(),
      clickCount: 3,
    );

    // Test Sorting high to low
    List<Product> productList = [productA, productB, productC];

    Product.sortByPrice(productList, true);

    expect(productList, [productC, productA, productB]);
  });

  // Test sorting by timestamp functionality
  test('Unit Test: Product - sortByTimestamp recent first', () {
    // Variables
    String pid = 'pid-test';
    List<File> photos = [File('test.png')];
    String name = 'name-test';
    double price = 20.1;
    String description = 'description-test';
    String location = 'location-test';
    String sellerId = 'sellerId-test';
    String fbsPath = 'fbsPath-test';
    int clickCount = 1;
    String category = 'category-test';

    // Create `ProductA` with first timestamp
    final Product productA = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // Create `ProductB` with second timestamp
    final Product productB = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // Create `ProductC` with third timestamp
    final Product productC = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // List products in not ordered by timestamp
    List<Product> products = [productB, productC, productA];

    // Recent first sort
    Product.sortByTimestamp(products, true);
    expect(products, [productC, productB, productA]);
  });

// Test sorting by timestamp functionality
  test('Unit Test: Product - sortByTimestamp recent first', () {
    // Variables
    String pid = 'pid-test';
    List<File> photos = [File('test.png')];
    String name = 'name-test';
    double price = 20.1;
    String description = 'description-test';
    String location = 'location-test';
    String sellerId = 'sellerId-test';
    String fbsPath = 'fbsPath-test';
    int clickCount = 1;
    String category = 'category-test';

    // Create `ProductA` with first timestamp
    final Product productA = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // Create `ProductB` with second timestamp
    final Product productB = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // Create `ProductC` with third timestamp
    final Product productC = Product(
      pid: pid,
      photos: photos,
      name: name,
      price: price,
      description: description,
      location: location,
      sellerId: sellerId,
      fbsPath: fbsPath,
      timestamp: Timestamp.now(),
      clickCount: clickCount,
      category: category,
    );

    // List products in not ordered by timestamp
    List<Product> products = [productB, productC, productA];

    // Recent last sort
    Product.sortByTimestamp(products, false);
    expect(products, [productA, productB, productC]);
  });
}
