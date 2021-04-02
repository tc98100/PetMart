import 'package:flutter/cupertino.dart';

enum PetCategory { Bird, Bunny, Cat, Dog, Fox, GuineaPig, Hamster, Other }

PetCategory petCategoryFromInt(int value) {
  switch (value) {
    case 0:
      return PetCategory.Bird;
    case 1:
      return PetCategory.Bunny;
    case 2:
      return PetCategory.Cat;
    case 3:
      return PetCategory.Dog;
    case 4:
      return PetCategory.Fox;
    case 5:
      return PetCategory.GuineaPig;
    default:
      return PetCategory.Other;
  }
}

String petCategoryToString(PetCategory category) {
  switch (category) {
    case PetCategory.Bird:
      return 'Bird';
    case PetCategory.Bunny:
      return 'Bunny';
    case PetCategory.Cat:
      return 'Cat';
    case PetCategory.Dog:
      return 'Dog';
    case PetCategory.Fox:
      return 'Fox';
    case PetCategory.GuineaPig:
      return 'GuineaPig';
    case PetCategory.Hamster:
      return 'Hamster';
    default:
      return "Other";
  }
}

List<Widget> categoryList = [
  Text("Bird"),
  Text("Bunny"),
  Text("Cat"),
  Text("Dog"),
  Text("Fox"),
  Text("Guinea Pig"),
  Text("Hamster"),
  Text("Other")
];

String petCategory(int value) {
  switch (value) {
    case 0:
      return "Bird";
    case 1:
      return "Bunny";
    case 2:
      return "Cat";
    case 3:
      return "Dog";
    case 4:
      return "Fox";
    case 5:
      return "Guinea Pig";
    case 6:
      return "Hamster";
    default:
      return "Other";
  }
}
