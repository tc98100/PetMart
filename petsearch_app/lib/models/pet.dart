import 'package:cupertino_store/models/product.dart';

class Pet extends Product {
  String gender;
  int ageYears;
  int ageMonths;
  String size;
  String category;
  bool healthCheck;
  bool microchip;
  bool desexed;
  bool vaccinated;
  bool wormed;

  Pet({
    pid,
    photos,
    name,
    price,
    description,
    location,
    sellerId,
    // imgPaths,
    fbsPath,
    timestamp,
    clickCount,
    searchIndex,
    this.gender,
    this.ageYears,
    this.ageMonths,
    this.size,
    this.category,
    this.healthCheck = false,
    this.microchip = false,
    this.desexed = false,
    this.vaccinated = false,
    this.wormed = false,
  }) : super(
          pid: pid,
          photos: photos,
          name: name,
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

  void addChecker(String input, List<String> list) {
    List<String> splitList = input.split(" ");
    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + 1; j++) {
        String element = splitList[i].substring(0, j).toLowerCase();
        if (list.contains(element)) {
          continue;
        } else if (element.isEmpty) {
        } else {
          list.add(element);
        }
      }
    }
  }

  void setUpSearchIndex() {
    searchIndex = new List<String>();
    addChecker(this.name.toLowerCase(), searchIndex);
    for (String i in description.split(" ")) {
      addChecker(i.toLowerCase(), searchIndex);
    }
    addChecker(this.category.toLowerCase(), searchIndex);
    addChecker(ageYears.toString(), searchIndex);
    addChecker(location.toString().toLowerCase(), searchIndex);
    addChecker(this.size.toLowerCase(), searchIndex);
    addChecker(this.gender.toLowerCase(), searchIndex);

    desexed
        ? addChecker("desexed", searchIndex)
        : addChecker("not desexed", searchIndex);
    wormed
        ? addChecker("wormed", searchIndex)
        : addChecker("not wormed", searchIndex);
    vaccinated
        ? addChecker("vaccinated", searchIndex)
        : addChecker("not vaccinated", searchIndex);
    healthCheck
        ? addChecker("healthCheck", searchIndex)
        : addChecker("not healthCheck", searchIndex);
    microchip
        ? addChecker("microchip", searchIndex)
        : addChecker("not microchip", searchIndex);
    searchIndex.removeAt(0);
  }
}
