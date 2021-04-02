import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../utils.dart';

class ProfileEdit extends StatefulWidget {
  static const String route = "profile_edit";

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String firstName = '';
  String lastName = '';
  String username = '';
  String userId = '';
  String bio = '';

  String updatedFirstName = '';
  String updatedLastName = '';
  String updatedUsername = '';
  String updatedBio = '';

  Widget button(String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        child: RaisedButton(
            child: Text(
              message,
              style: title(18),
            ),
            textColor: Colors.white,
            color: Colors.redAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              final UserService userFunctions = UserService(userId);
              if (updatedUsername.isEmpty) {
                updatedUsername = username;
              }
              if (updatedFirstName.isEmpty) {
                updatedFirstName = firstName;
              }
              if (updatedLastName.isEmpty) {
                updatedLastName = lastName;
              }
              if (updatedBio.isEmpty) {
                updatedBio = bio;
              }
              userFunctions.updateInfo(updatedFirstName, updatedLastName,
                  updatedUsername, updatedBio);
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  Widget heading(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<User>(context);
    userId = userInfo.uid;
    final UserService userFunctions = UserService(userId);

    return StreamBuilder<UserModel>(
        stream: userFunctions.userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            firstName = snapshot.data.firstName;
            lastName = snapshot.data.lastName;
            username = snapshot.data.username;
            bio = snapshot.data.bio;
          }
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: CupertinoNavigationBarBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: appTheme.primaryColor,
              ),
              middle: Text(
                "Edit Profile",
                style: gradientText(20),
              ),
              backgroundColor: appTheme.scaffoldBackgroundColor,
            ),
            child: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: heading("First Name")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DarkTextField(
                        obscureText: false,
                        maxLines: 1,
                        placeholder: firstName,
                        onChanged: (value) {
                          setState(() {
                            updatedFirstName = value;
                          });
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: heading("Last Name")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DarkTextField(
                        obscureText: false,
                        maxLines: 1,
                        placeholder: lastName,
                        onChanged: (value) {
                          setState(() {
                            updatedLastName = value;
                          });
                        },
                      ),
                    ),
                    Align(alignment: Alignment.topLeft, child: heading("bio")),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DarkTextField(
                        obscureText: false,
                        placeholder: bio,
                        onChanged: (value) {
                          setState(() {
                            updatedBio = value;
                          });
                        },
                      ),
                    ),
                    CustomButton(
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          final UserService userFunctions = UserService(userId);
                          if (updatedUsername.isEmpty) {
                            updatedUsername = username;
                          }
                          if (updatedFirstName.isEmpty) {
                            updatedFirstName = firstName;
                          }
                          if (updatedLastName.isEmpty) {
                            updatedLastName = lastName;
                          }
                          if (updatedBio.isEmpty) {
                            updatedBio = bio;
                          }
                          userFunctions.updateInfo(updatedFirstName,
                              updatedLastName, updatedUsername, updatedBio);
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
