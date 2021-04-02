import 'package:flutter/cupertino.dart';

enum AccessoryCategory {
  Aquariums,
  Bedding,
  Beds,
  Bowls,
  Brushes,
  Cages,
  Camera,
  Carriers,
  Clothes,
  CollarRing,
  CollarsAndLeads,
  FeedingMachine,
  Grooming,
  Houses,
  KennelsAndCarriers,
  Leash,
  Lighting,
  Other,
  Toys,
  WaterMachine,
}

AccessoryCategory accessoryCategoryFromInt(int value) {
  switch (value) {
    case 0:
      return AccessoryCategory.Leash;
    case 1:
      return AccessoryCategory.Clothes;
    case 2:
      return AccessoryCategory.WaterMachine;
    case 3:
      return AccessoryCategory.FeedingMachine;
    case 4:
      return AccessoryCategory.Camera;
    case 5:
      return AccessoryCategory.CollarRing;
    case 6:
      return AccessoryCategory.Beds;
    case 7:
      return AccessoryCategory.Houses;
    case 8:
      return AccessoryCategory.Cages;
    case 9:
      return AccessoryCategory.Aquariums;
    case 10:
      return AccessoryCategory.Bowls;
    case 11:
      return AccessoryCategory.Brushes;
    case 12:
      return AccessoryCategory.Carriers;
    case 13:
      return AccessoryCategory.Toys;
    default:
      return AccessoryCategory.Other;
  }
}

String accessoryCategoryToString(AccessoryCategory product) {
  switch (product) {
    case AccessoryCategory.Leash:
      return ("Leash");
    case AccessoryCategory.Clothes:
      return ("Clothes");
    case AccessoryCategory.WaterMachine:
      return ("Water Machine");
    case AccessoryCategory.FeedingMachine:
      return ("Feeding Machine");
    case AccessoryCategory.Camera:
      return ("Camera");
    case AccessoryCategory.CollarRing:
      return ("Collar Ring");
    case AccessoryCategory.Beds:
      return ("Bed");
    case AccessoryCategory.Houses:
      return ("House");
    case AccessoryCategory.Cages:
      return ("Cage");
    case AccessoryCategory.Aquariums:
      return ("Aquariums");
    case AccessoryCategory.Bowls:
      return ("Bowl");
    case AccessoryCategory.Brushes:
      return ("Grooms");
    case AccessoryCategory.Carriers:
      return ("Carrier");
    case AccessoryCategory.Toys:
      return ("Toy");
    default:
      return ("Other");
  }
}

int accessoryCategoryToInt(AccessoryCategory product) {
  switch (product) {
    case AccessoryCategory.Aquariums:
      return 0;
    case AccessoryCategory.Bedding:
      return 1;
    case AccessoryCategory.Bowls:
      return 2;
    case AccessoryCategory.Cages:
      return 3;
    case AccessoryCategory.Clothes:
      return 4;
    case AccessoryCategory.CollarsAndLeads:
      return 5;
    case AccessoryCategory.Grooming:
      return 6;
    case AccessoryCategory.KennelsAndCarriers:
      return 7;
    case AccessoryCategory.Lighting:
      return 8;
    case AccessoryCategory.Toys:
      return 9;
    default:
      return null;
  }
}

List<Widget> accessoryCategoryList = [
  Text("Leash"),
  Text("Clothes"),
  Text("Water Machine"),
  Text("Feeding Machine"),
  Text("Camera"),
  Text("Collar Ring"),
  Text("Beds"),
  Text("Houses"),
  Text("Cages"),
  Text("Aquariums"),
  Text("Bowls"),
  Text("Brushes"),
  Text("Carriers"),
  Text("Toys"),
  Text("Other"),
];

String accessoryCategory(int value) {
  switch (value) {
    case 0:
      return "Leash";
    case 1:
      return "Clothes";
    case 2:
      return "WaterMachine";
    case 3:
      return "FeedingMachine";
    case 4:
      return "Camera";
    case 5:
      return "Collar Ring";
    case 6:
      return "Beds";
    case 7:
      return "Houses";
    case 8:
      return "Cages";
    case 9:
      return "Aquariums";
    case 10:
      return "Bowls";
    case 11:
      return "Brushes";
    case 12:
      return "Carriers";
    case 13:
      return "Toys";
    default:
      return "Other";
  }
}
