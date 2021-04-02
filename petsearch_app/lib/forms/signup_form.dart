import 'package:cupertino_store/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_store/backend/auth_service.dart';
import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/error_messages.dart';

import '../utils.dart';

class SignUpForm extends StatefulWidget {
  static const String route = 'signup';

  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey formKey = GlobalKey<FormState>();

  String errorMessageGenerated = '';
  String errorMessageSelected = '';
  bool isLoading = false;
  String message = "signing you up!";

  String username = '';
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  String bio = '';

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen(
            message: message,
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: appTheme.scaffoldBackgroundColor,
              leading: CupertinoNavigationBarBackButton(
                color: appTheme.primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            child: CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Center(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign Up",
                                style: gradientText(
                                    MediaQuery.of(context).size.height *
                                        headerSize)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      padding,
                                  bottom: MediaQuery.of(context).size.height *
                                      separatorPadding),
                              child: Text(
                                'Sign up today for Paws & Play!',
                                style: regularFont(
                                    MediaQuery.of(context).size.height *
                                        subtitleSize),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              padding),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Name",
                                              style: gradientText(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize))),
                                    ),
                                    DarkTextField(
                                      obscureText: false,
                                      maxLines: 1,
                                      placeholder: 'Enter your first name',
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      onChanged: (value) {
                                        setState(() {
                                          firstName = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              padding,
                                    ),
                                    DarkTextField(
                                      obscureText: false,
                                      maxLines: 1,
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      placeholder: 'Enter your last name',
                                      onChanged: (value) {
                                        setState(() {
                                          lastName = value;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              padding,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              morePadding),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Username",
                                              style: gradientText(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize))),
                                    ),
                                    DarkTextField(
                                      obscureText: false,
                                      maxLines: 1,
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      placeholder: 'Enter a username',
                                      onChanged: (value) {
                                        setState(() {
                                          username = value;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              padding,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              morePadding),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Bio",
                                              style: gradientText(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize))),
                                    ),
                                    DarkTextField(
                                      obscureText: false,
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      placeholder:
                                          'Write something about yourself',
                                      onChanged: (value) {
                                        setState(() {
                                          bio = value;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              padding,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              morePadding),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Email",
                                              style: gradientText(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize))),
                                    ),
                                    DarkTextField(
                                      obscureText: false,
                                      maxLines: 1,
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      placeholder: 'Enter your email',
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              padding,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              morePadding),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Password",
                                              style: gradientText(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize))),
                                    ),
                                    DarkTextField(
                                      obscureText: true,
                                      maxLines: 1,
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      placeholder: 'Enter a password',
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              separatorPadding *
                                              2,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: RaisedButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final ErrorMessages errorMessage =
                                              ErrorMessages();
                                          errorMessageGenerated =
                                              errorMessage.messageChecker(
                                                  firstName,
                                                  lastName,
                                                  username,
                                                  email,
                                                  password);
                                          if (errorMessageGenerated.length ==
                                              0) {
                                            final AuthService _authFunctions =
                                                AuthService();
                                            User newUser = await _authFunctions
                                                .signUp(email, password);
                                            setState(() {
                                              errorMessageSelected =
                                                  _authFunctions.giveFeedback();
                                            });
                                            if (newUser != null) {
                                              final UserService _userFunctions =
                                                  UserService(newUser.uid);
                                              await _userFunctions.addInfo(
                                                  firstName,
                                                  lastName,
                                                  username,
                                                  bio);
                                              Navigator.of(context).pop();
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                              errorMessageSelected =
                                                  errorMessageGenerated;
                                            });
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0)),
                                        padding: EdgeInsets.all(0.0),
                                        child: Ink(
                                          decoration: gradientBorder,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minWidth: 100.0,
                                                minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Sign Up",
                                              textAlign: TextAlign.center,
                                              style: title(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      subtitleSize),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              morePadding),
                                      child: Text(
                                        errorMessageSelected,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                normalSize),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ]),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ]),
          );
  }
}
