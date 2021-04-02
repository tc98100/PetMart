enum Gender { Female, Male }

Gender genderFromInt(int input) {
  switch (input) {
    case 0:
      return Gender.Female;
    case 1:
      return Gender.Male;
    default:
      return null;
  }
}

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.Female:
      return 'Female';
    case Gender.Male:
      return 'Male';
    default:
      return null;
  }
}

int genderToInt(Gender gender) {
  switch (gender) {
    case Gender.Female:
      return 0;
    case Gender.Male:
      return 1;
    default:
      return null;
  }
}

String gender(int input) {
  switch (input) {
    case 0:
      return "Female";
    case 1:
      return "Male";
    default:
      return null;
  }
}
