import 'package:test/test.dart';
import 'package:cupertino_store/models/error_messages.dart';

void main() {
  //Testing for first name input
  test("Unit Test: ErrorMessages - first name error case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.firstNameError("");
    expect(errorMessages.message, "You have to input your first name");
  });

  test("Unit Test: ErrorMessages - first name pass case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.firstNameError("Jack");
    expect(errorMessages.message, "");
  });

  //Testing for last name input
  test("Unit Test: ErrorMessages - last name error case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.lastNameError("");
    expect(errorMessages.message, "You have to input your last name");
  });

  test("Unit Test: ErrorMessages - last name pass case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.lastNameError("Smith");
    expect(errorMessages.message, "");
  });

  //Testing for username input
  test("Unit Test: ErrorMessages - username error case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.usernameError("");
    expect(errorMessages.message, "You have to input your username");
  });

  test("Unit Test: ErrorMessages - username pass case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.usernameError("JS1234");
    expect(errorMessages.message, "");
  });

  //Testing for email input
  test("Unit Test: ErrorMessages - email error case 1", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.emailError("");
    expect(errorMessages.message, "You have to input your email");
  });

  test("Unit Test: ErrorMessages - email error case 2", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.emailError("JS1234");
    expect(errorMessages.message, "You must input a valid email");
  });

  test("Unit Test: ErrorMessages - email pass case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.emailError("JS1234@example.com");
    expect(errorMessages.message, "");
  });

  //Testing for password input
  test("Unit Test: ErrorMessages - password error case 1", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("");
    expect(errorMessages.message, "You have to input your password");
  });

  test("Unit Test: ErrorMessages - password error case 2", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("JS1234");
    expect(errorMessages.message,
        "The password you input must contain at least 8 characters");
  });

  test("Unit Test: ErrorMessages - password error case 3", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("JS1234js");
    expect(errorMessages.message,
        "The password must contain at least one lower case letter, one upper case letter, one digit and one special character");
  });

  test("Unit Test: ErrorMessages - password error case 4", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("JS1234#!");
    expect(errorMessages.message,
        "The password must contain at least one lower case letter, one upper case letter, one digit and one special character");
  });

  test("Unit Test: ErrorMessages - password error case 5", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("JackSmith#!");
    expect(errorMessages.message,
        "The password must contain at least one lower case letter, one upper case letter, one digit and one special character");
  });

  test("Unit Test: ErrorMessages - password error case 6", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("js1234#!");
    expect(errorMessages.message,
        "The password must contain at least one lower case letter, one upper case letter, one digit and one special character");
  });

  test("Unit Test: ErrorMessages - password pass case", () {
    final ErrorMessages errorMessages = ErrorMessages();
    errorMessages.passwordError("JS1234js!");
    expect(errorMessages.message, "");
  });
}
