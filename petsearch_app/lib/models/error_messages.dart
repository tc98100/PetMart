class ErrorMessages {
  String message = "";

  void firstNameError(String firstName) {
    if (firstName.isEmpty) {
      message = "You have to input your first name";
    }
  }

  void lastNameError(String lastName) {
    if (lastName.isEmpty) {
      message = "You have to input your last name";
    }
  }

  void usernameError(String username) {
    if (username.isEmpty) {
      message = "You have to input your username";
    }
  }

  //this methods cna be used once phone No is implemented
  void phoneNumberError(String phoneNumber) {
    RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

    if (phoneNumber.isEmpty) {
      message = "You have to input your phoneNumber";
    } else if (!regex.hasMatch(phoneNumber)) {
      message = "Please enter a valid phone number";
    }
  }

  void emailError(String email) {
    Pattern pattern = r'^(?=.*?[@])';
    RegExp regex = new RegExp(pattern);

    if (email.isEmpty) {
      message = "You have to input your email";
    } else if (!regex.hasMatch(email)) {
      message = "You must input a valid email";
    }
  }

  void passwordError(String password) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])';

    RegExp regex = new RegExp(pattern);

    if (password.isEmpty) {
      message = "You have to input your password";
    } else if (password.length < 8) {
      message = "The password you input must contain at least 8 characters";
    } else if (!regex.hasMatch(password)) {
      message =
          "The password must contain at least one lower case letter, one upper case letter, one digit and one special character";
    }
  }

  //need to add in phone numbers
  String messageChecker(String firstName, String lastName, String username,
      String email, String password) {
    passwordError(password);
    emailError(email);
    usernameError(username);
    lastNameError(lastName);
    firstNameError(firstName);

    print("message: " + message);

    return message;
  }
}
