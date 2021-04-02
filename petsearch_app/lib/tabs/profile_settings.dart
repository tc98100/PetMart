import 'dart:ui';

import 'package:cupertino_store/backend/auth_service.dart';
import 'package:cupertino_store/tabs/profile_edit.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  static const String route = "profile_settings";

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final AuthService authFunctions = AuthService();

  // Change user information, change password, manage items, sign out
  Widget setting(String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        child: RaisedButton(
          child: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          ),
          textColor: Colors.white,
          color: Colors.redAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () async {
            await authFunctions.signOut();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget button(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        child: RaisedButton(
          color: appTheme.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(CupertinoIcons.pencil, color: Colors.white)
                ]),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true)
              .pushNamed(ProfileEdit.route),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: appTheme.scaffoldBackgroundColor,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: appTheme.primaryColor,
        ),
        middle: Text(
          "Settings",
          style: gradientText(20),
        ),
      ),
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(ProfileEdit.route),
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.pencil,
                      color: Colors.white,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                // onTap: () => Navigator.of(context, rootNavigator: true)
                //     .pushNamed(ProfileEdit.route),
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.question_circle,
                      color: Colors.white,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Help",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              setting("Sign Out")
            ],
          ),
        ),
      ),
    );
  }
}
