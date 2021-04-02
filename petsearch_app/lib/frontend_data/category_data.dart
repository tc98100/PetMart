import 'package:cupertino_store/components/category_page.dart';
import 'package:cupertino_store/models/category_card_data.dart';
import 'package:cupertino_store/models/category_list_data.dart';

class CategoryData {
  static CategoryPage birdPage =
      CategoryPage("Birds", birdList, animalAccessoryList);
  static CategoryPage bunnyPage =
      CategoryPage("Bunnies", bunnyList, animalAccessoryList);
  static CategoryPage catPage =
      CategoryPage("Cat", catList, animalAccessoryList);
  static CategoryPage dogPage =
      CategoryPage("Dogs", dogList, animalAccessoryList);
  static CategoryPage gPigPage =
      CategoryPage("Guinea Pigs", gPigsList, animalAccessoryList);
  static CategoryPage hamsterPage =
      CategoryPage("Hamsters", hamsterList, animalAccessoryList);
  static CategoryPage foxPage =
      CategoryPage("Foxes", foxList, animalAccessoryList);
  static CategoryPage otherAnimalPage =
      CategoryPage("Other", otherAnimalList, animalAccessoryList);

  //Main category list items
  static List<CategoryCardData> petCards = [
    CategoryCardData(
        imgPath: 'assets/bird.png', cardName: 'Bird', path: birdPage),
    CategoryCardData(
        imgPath: 'assets/bunny.jpg', cardName: 'Bunny', path: bunnyPage),
    CategoryCardData(imgPath: 'assets/cat.jpg', cardName: 'Cat', path: catPage),
    CategoryCardData(imgPath: 'assets/dog.jpg', cardName: 'Dog', path: dogPage),
    CategoryCardData(imgPath: 'assets/fox.jpg', cardName: 'Fox', path: foxPage),
    CategoryCardData(
        imgPath: 'assets/mediumGPig.jpg',
        cardName: 'Guinea pigs',
        path: gPigPage),
    CategoryCardData(
        imgPath: 'assets/hamster.jpg', cardName: 'Hamsters', path: hamsterPage),
    CategoryCardData(
        imgPath: 'assets/hedgeHogs.jpg',
        cardName: 'Other',
        path: otherAnimalPage),
  ];

  static List<CategoryCardData> accessoryCards = [
    CategoryCardData(
        imgPath: 'assets/accessories/leash.jpg',
        cardName: 'Leash',
        dataBaseName: 'Leash',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/clothes.jpg',
        cardName: 'Clothes',
        dataBaseName: 'Clothes',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/waterMachine.jpg',
        cardName: 'Water Machine',
        dataBaseName: 'WaterMachine',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/feedingMachine.jpg',
        cardName: 'Feeding Machine',
        dataBaseName: 'FeedingMachine',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/camera.jpeg',
        cardName: 'Camera',
        dataBaseName: 'Camera',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/collarRing.jpg',
        cardName: 'Collar Ring',
        dataBaseName: 'CollarRing',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/bed.jpeg',
        cardName: 'Beds',
        dataBaseName: 'Beds',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/houses.jpeg',
        cardName: 'Houses',
        dataBaseName: 'Houses',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/cage.jpg',
        cardName: 'Cages',
        dataBaseName: 'Cages',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/aquariums.jpeg',
        cardName: 'Aquariums',
        dataBaseName: 'Aquariums',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/bowls.jpeg',
        cardName: 'Bowls',
        dataBaseName: 'Bowls',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/brushes.jpg',
        cardName: 'Brushes',
        dataBaseName: 'Brushes',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/carriers.jpeg',
        cardName: 'Carriers',
        dataBaseName: 'Carriers',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/toys.jpeg',
        cardName: 'Toys',
        dataBaseName: 'Toys',
        isItem: true),
    CategoryCardData(
        imgPath: 'assets/accessories/other.jpeg',
        cardName: 'Other',
        dataBaseName: 'Other',
        isItem: true),
  ];
  final CategoryListData petList =
      new CategoryListData(cards: petCards, title: "Pets");
  final CategoryListData accessoryList =
      new CategoryListData(cards: accessoryCards, title: "Accessories");
//Each animal categories
  //dogs
  static final List<CategoryCardData> dogs = [
    CategoryCardData(
        imgPath: 'assets/dog_breeds/germanShepherd.jpg',
        cardName: 'Big Dogs',
        dataBaseName: "Dog",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/dog_breeds/bulldog.jpg',
        cardName: 'Medium Dogs',
        dataBaseName: "Dog",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/dog_breeds/poodle.jpg',
        cardName: 'Small Dogs',
        dataBaseName: "Dog",
        petSize: "small"),
  ];
  static final CategoryListData dogList =
      new CategoryListData(cards: dogs, title: "Dog");
  static final CategoryListData animalAccessoryList =
      new CategoryListData(cards: accessoryCards, title: "Accessories");
  //cats
  static final List<CategoryCardData> cats = [
    CategoryCardData(
        imgPath: 'assets/cat_breeds/britishShorthair.jpg',
        cardName: 'Big Cats',
        dataBaseName: "Cat",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/cat_breeds/persian.jpg',
        cardName: 'Medium Cats',
        dataBaseName: "Cat",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/cat_breeds/americanShorthair.jpg',
        cardName: 'Small Cats',
        dataBaseName: "Cat",
        petSize: "small"),
  ];

  static final CategoryListData catList =
      new CategoryListData(cards: cats, title: "Cat");

  //birds
  static final List<CategoryCardData> birds = [
    CategoryCardData(
        imgPath: 'assets/bird_breeds/whiteCockatoo.jpg',
        cardName: 'Big Birds',
        dataBaseName: "bird",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/bird_breeds/scarletMacaw.jpg',
        cardName: 'Medium Birds',
        dataBaseName: "bird",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/bird_breeds/grayParrot.jpg',
        cardName: 'Small Birds',
        dataBaseName: "bird",
        petSize: "small"),
  ];

  static final CategoryListData birdList =
      new CategoryListData(cards: birds, title: "Bird");
  //foxes
  static final List<CategoryCardData> foxes = [
    CategoryCardData(
        imgPath: 'assets/fox_breeds/fennecFox.jpg',
        cardName: 'Big Foxes',
        dataBaseName: "fox",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/fox_breeds/redFox.jpg',
        cardName: 'Medium Foxes',
        dataBaseName: "fox",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/fox_breeds/silverFox.jpeg',
        cardName: 'Small Foxes',
        dataBaseName: "fox",
        petSize: "small"),
  ];
  static final CategoryListData foxList =
      new CategoryListData(cards: foxes, title: "Fox");

  //bunnies
  static final List<CategoryCardData> bunnies = [
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/hollandLop.jpg',
        cardName: 'Big Bunnies',
        dataBaseName: "bunny",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/lionheadRabbit.jpg',
        cardName: 'Medium Bunnies',
        dataBaseName: "bunny",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/rexRabbit.jpg',
        cardName: 'Small Bunnies',
        dataBaseName: "bunny",
        petSize: "small"),
  ];

  static final CategoryListData bunnyList =
      new CategoryListData(cards: bunnies, title: "Bunny");

  static final List<CategoryCardData> gPigs = [
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/bigGPig.jpg',
        cardName: 'Big Guinea Pigs',
        dataBaseName: "Guinea Pig",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/mediumGPig.jpg',
        cardName: 'Medium Guinea Pigs',
        dataBaseName: "Guinea Pig",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/bunny_breeds/smallGPig.jpg',
        cardName: 'Small Guinea Pigs',
        dataBaseName: "Guinea Pig",
        petSize: "small"),
  ];

  static final CategoryListData gPigsList =
      new CategoryListData(cards: gPigs, title: "Guinea Pigs");

  static final List<CategoryCardData> hamster = [
    CategoryCardData(
        imgPath: 'assets/bigHamster.jpg',
        cardName: 'Big Hamster',
        dataBaseName: "hamster",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/mediumHamster.jpg',
        cardName: 'Medium Hamster',
        dataBaseName: "hamster",
        petSize: "medium"),
    CategoryCardData(
        imgPath: 'assets/hamster.jpg',
        cardName: 'Small Hamster',
        dataBaseName: "hamster",
        petSize: "small"),
  ];

  static final CategoryListData hamsterList =
      new CategoryListData(cards: hamster, title: "Hamster");

  static final List<CategoryCardData> otherAnimal = [
    CategoryCardData(
        imgPath: 'assets/horse.jpg',
        cardName: 'Big Pets',
        dataBaseName: "other",
        petSize: "large"),
    CategoryCardData(
        imgPath: 'assets/sheep.jpeg',
        cardName: 'Medium Pets',
        dataBaseName: "other"),
    CategoryCardData(
        imgPath: 'assets/hedgeHogs.jpg',
        cardName: 'Small Pets',
        dataBaseName: "other"),
  ];

  static final CategoryListData otherAnimalList =
      new CategoryListData(cards: otherAnimal, title: "Other");
}
