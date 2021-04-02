import 'package:cupertino_store/forms/signup_form.dart';
import 'package:cupertino_store/theme.dart';
import 'package:cupertino_store/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_store/backend/auth_service.dart';

class LoginForm extends StatefulWidget {
  static const String route = 'login';

  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String errorMessageSelected = '';
  bool isLoading = false;
  String message = "Logging in...";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen(
            message: message,
          )
        : CupertinoPageScaffold(
            child: CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                    child: Form(
                      key: formKey,
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          sectionPadding,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              sectionPadding /
                                              2,
                                    ),
                                    child: Text("Sign In",
                                        style: gradientText(
                                            MediaQuery.of(context).size.height *
                                                headerSize)),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Email",
                                          style: gradientText(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  subtitleSize))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                padding,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                padding,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                morePadding),
                                    child: DarkTextField(
                                      obscureText: false,
                                      placeholder: 'Enter your email',
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      maxLines: 1,
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Password",
                                          style: gradientText(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  subtitleSize))),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                padding,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                padding,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                morePadding),
                                    child: DarkTextField(
                                      obscureText: true,
                                      placeholder: 'Enter your password',
                                      textStyle: regularFont(
                                          MediaQuery.of(context).size.height *
                                              normalSize),
                                      maxLines: 1,
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        morePadding,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final AuthService _authFunctions =
                                            AuthService();
                                        User loggedInUser = await _authFunctions
                                            .signIn(email, password);
                                        setState(() {
                                          errorMessageSelected =
                                              _authFunctions.giveFeedback();
                                        });
                                        if (loggedInUser == null) {
                                          setState(() {
                                            isLoading = false;
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
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Login",
                                            textAlign: TextAlign.center,
                                            style: title(MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                subtitleSize),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    indent: MediaQuery.of(context).size.height *
                                        separatorPadding,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        padding,
                                  ),
                                  Divider(
                                    indent: MediaQuery.of(context).size.height *
                                        separatorPadding,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Need an account?'),
                                      GestureDetector(
                                          onTap: () => Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed(SignUpForm.route),
                                          child: Text(
                                            "Sign up here",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    normalSize),
                                          ))
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height *
                                            padding),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          );
  }
}
