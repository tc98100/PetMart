enum PetSize { small, medium, large }

// PetSize petSizeFromInt(int input) {
//   switch (input) {
//     case 0:
//       return PetSize.small;
//     case 1:
//       return PetSize.medium;
//     case 2:
//       return PetSize.large;
//     default:
//       return null;
//   }
// }
//
// int petSizeToInt(PetSize type) {
//   switch (type) {
//     case PetSize.small:
//       return 0;
//     case PetSize.medium:
//       return 1;
//     case PetSize.large:
//       return 2;
//     default:
//       return null;
//   }
// }

String petSizeToString(PetSize type) {
  switch (type) {
    case PetSize.small:
      return 'Small';
    case PetSize.medium:
      return 'Medium';
    case PetSize.large:
      return 'Large';
    default:
      return null;
  }
}

String petSize(int input) {
  switch (input) {
    case 0:
      return "Small";
    case 1:
      return "Medium";
    case 2:
      return "Large";
    default:
      return null;
  }
}
