import 'dart:async';

import 'package:cupertino_store/models/accessory.dart';
import 'package:cupertino_store/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/models/pet.dart';

class ProductService {
  // Stores the collection of `pets`.
  final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('pets');

  // Stores the collection of `items`.
  final CollectionReference itemsCollection =
      FirebaseFirestore.instance.collection('items');

  FirebaseAuth auth = FirebaseAuth.instance;

  // `pets`
  //
  // Get all pets (ordering by most recent)
  Stream<List<Pet>> get pets {
    return petsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(petList);
  }

  // `hotPets`
  //
  // Get all pets (ordering by most viewed)
  Stream<List<Pet>> get hotPets {
    return petsCollection.orderBy('clickCount').snapshots().map(petList);
  }

  // `petsForUser`
  //
  // Get pets created by current user
  Stream<List<Pet>> get petsForUser {
    return petsCollection
        .orderBy('timestamp', descending: true)
        .where('sellerId', isEqualTo: auth.currentUser.uid)
        .snapshots()
        .map(petList);
  }

  // `petsForCategory`
  //
  // Get pets for a specific category and size
  Stream<List<Pet>> petsForCategory(String category, String size) {
    return petsCollection
        .orderBy('timestamp', descending: true)
        .where('category', isEqualTo: category)
        .where('size', isEqualTo: size)
        .snapshots()
        .map(petList);
  }

  // `searchResults`
  //
  // Searches either the `Pets` or `Accessories` (items) database for
  // items which contain each of the strings in their `searchIndex` field.
  Stream<List<Product>> searchResults(
      List<String> userInput, bool isSearchForPets) {
    if (isSearchForPets) {
      // Search for `Pets`
      Query query =
          petsCollection.orderBy('timestamp', descending: true).limit(1000);

      // Add the first input as criteria to `searchIndex`
      if (userInput.isNotEmpty) {
        query = query.where('searchIndex', arrayContains: userInput[0]);
      }

      return query.snapshots().map(petList);
    } else {
      // Search for `Accessories`
      Query query = itemsCollection.orderBy('timestamp', descending: true);

      // Add the first input as criteria to `searchIndex`
      if (userInput.isNotEmpty) {
        query =
            query.where('searchIndex', arrayContains: userInput[0]).limit(1000);
      }

      return query.snapshots().map(itemList);
    }
  }

  // `createPet`
  //
  // Create a new `Pet` in the database
  Future createPet(Pet pet) async {
    try {
      // var uuid = Uuid();
      // var pid = uuid.v4();
      String pid = petsCollection.doc().id;
      await petsCollection.doc(pid).set({
        'pid': pid,
        'name': pet.name,
        'price': pet.price,
        'description': pet.description,
        'location': pet.location,
        'sellerId': pet.sellerId,
        'gender': pet.gender,
        'ageYears': pet.ageYears,
        'ageMonths': pet.ageMonths,
        'size': pet.size,
        'category': pet.category,
        'healthCheck': pet.healthCheck,
        'microchip': pet.microchip,
        'desexed': pet.desexed,
        'vaccinated': pet.vaccinated,
        'wormed': pet.wormed,
        'fbsPath': pet.fbsPath,
        'timestamp': FieldValue.serverTimestamp(),
        'clickCount': 0,
        'searchIndex': pet.searchIndex,
      });
      print("pet information added");
      return petsCollection;
    } catch (e) {
      print(e.toString());
      print("error when adding pets");
      return null;
    }
  }

  // `petList`
  //
  // Converts a `QuerySnapshot` to a `Pet` model
  List<Pet> petList(QuerySnapshot snapshot) {
    return snapshot.docs.map((info) {
      // Convert dynamic list to string
      List<dynamic> searchIndexDynamic = info['searchIndex'];
      List<String> searchIndex =
          searchIndexDynamic.map((e) => e.toString()).toList();

      return Pet(
        pid: info['pid'],
        name: info['name'] ?? '',
        price: info['price'] ?? 0,
        description: info['description'] ?? '',
        location: info['location'] ?? '',
        sellerId: info['sellerId'] ?? '',
        gender: info['gender'] ?? '',
        ageYears: info['ageYears'] ?? 0,
        ageMonths: info['ageMonths'] ?? 0,
        size: info['size'] ?? '',
        category: info['category'] ?? '',
        healthCheck: info['healthCheck'] ?? false,
        microchip: info['microchip'] ?? false,
        desexed: info['desexed'] ?? false,
        vaccinated: info['vaccinated'] ?? false,
        wormed: info['wormed'] ?? false,
        fbsPath: info['fbsPath'] ?? '',
        timestamp: info['timestamp'] ?? Timestamp.now(),
        searchIndex: searchIndex,
      );
    }).toList();
  }

  // `deletePet`
  //
  // Deletes a `Pet` from the database
  Future deletePet(String pid) async {
    //remove by document id
    await petsCollection.doc(pid).delete();
    //remove by field 'id'
    //await petsCollection.where('pid', isEqualTo: pid).get().then((value) => value.docs.first.reference.delete());
  }

  ////////////////////////
  ////////////////////////
  ////////////////////////
  //below section is for accessories
  ////////////////////////
  ////////////////////////
  ////////////////////////

  // `items`
  //
  // Get all accessories (ordering by most recent)
  Stream<List<Accessory>> get items {
    return itemsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(itemList);
  }

  // Get all accessories (ordering by most viewed)
  Stream<List<Accessory>> get hotItems {
    return itemsCollection.orderBy('clickCount').snapshots().map(itemList);
  }

  // `itemsForUser`
  //
  // Get items created by one user
  Stream<List<Accessory>> get itemsForUser {
    return itemsCollection
        .orderBy('timestamp', descending: true)
        .where('sellerId', isEqualTo: auth.currentUser.uid)
        .snapshots()
        .map(itemList);
  }

  // `itemsForConditionCategory`
  //
  // Get accessories for a specific category amd condition
  Stream<List<Accessory>> itemsForConditionCategory(
      String category, String condition) {
    return itemsCollection
        .orderBy('timestamp', descending: true)
        .where('category', isEqualTo: category)
        .where('condition', isEqualTo: condition)
        .snapshots()
        .map(itemList);
  }

  // `itemsForCategory`
  //
  // Get items which match a certain category
  Stream<List<Accessory>> itemsForCategory(String name) {
    return itemsCollection
        .orderBy('timestamp', descending: true)
        .where('category', isEqualTo: name)
        .snapshots()
        .map(itemList);
  }

  // `createItem`
  //
  // Create a new accessory
  Future createItem(Accessory item) async {
    try {
      String pid = itemsCollection.doc().id;
      await itemsCollection.doc(pid).set({
        'pid': pid,
        'name': item.name,
        'price': item.price,
        'description': item.description,
        'location': item.location,
        'sellerId': item.sellerId,
        'condition': item.condition,
        'category': item.category,
        'fbsPath': item.fbsPath,
        'timestamp': FieldValue.serverTimestamp(),
        'clickCount': 0,
        'searchIndex': item.searchIndex,
      });
      print("accessory information added");
      return itemsCollection;
    } catch (e) {
      print(e.toString());
      print("error when adding accessory");
      return null;
    }
  }

  // `itemList`
  //
  // Convert a `QuerySnapshot` to a List of `Accessories`
  List<Accessory> itemList(QuerySnapshot snapshot) {
    return snapshot.docs.map((info) {
      // Convert dynamic list to string
      List<dynamic> searchIndexDynamic = info['searchIndex'];
      List<String> searchIndex =
          searchIndexDynamic.map((e) => e.toString()).toList();

      return Accessory(
        pid: info['pid'],
        name: info['name'],
        price: info['price'] ?? 0,
        description: info['description'] ?? '',
        location: info['location'] ?? '',
        sellerId: info['sellerId'] ?? '',
        condition: info['condition'] ?? '',
        category: info['category'] ?? '',
        fbsPath: info['fbsPath'] ?? '',
        timestamp: info['timestamp'] ?? Timestamp.now(),
        searchIndex: searchIndex,
      );
    }).toList();
  }

  // `deleteItem`
  //
  // Deletes an `Accessory` from the database
  Future deleteItem(String pid) async {
    await itemsCollection.doc(pid).delete();
  }
}
